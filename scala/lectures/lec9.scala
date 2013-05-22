// functions and state

var x: String = "abc"
var count = 111

x = "hi"
count = count + 1

// objects with state

class BankAccount {
  private var balance = 0
  def deposit(amount: Int): Unit = {
    if (amount > 0) balance = balance + amount
  }

  def withdraw(amount: Int): Int = {
    if (0 < amount && amount <= balance) {
      balance = balance - amount
      balance
    } else throw new Error("insufficient funds")
  }
}

val account = new BankAccount
account deposit 50
account withdraw 20
account withdraw 20
account withdraw 15

// no state gives us referential integrity

val x = E; val y = E

val x = E; val y = x

// x and y should be the same either way. this goes away with state.

val x = new BankAccount
val y = new BankAccount

// is not the same as

val x = new BankAccount
val y = x

// the substitution model becomes invalid because values can no 
// longer be replaced by equivalent expressions

// loops

def power(x: Double, exp: Int): Double = {
  var r = 1.0
  var i = exp
  while (i > 0) { r = r * x; i = i - 1 }
  r
}

// defining while

def while_(condition: => Boolean)(command: => Unit): Unit = {
  if (condition) {
    command; while(condition)(command)
  }
}

// for loops
// a foreach must be defined on a collection that supports for loops, 
// just like map and flatMap need to be defined on collections that 
// support for comprehensions

// def foreach(f: T => Unit): Unit =

for (i <- 1 until 3; j <- "abc") println(i + " " + j)

// translates to

(1 until 3) foreach (i => "abc" foreach (j => println(i + " " + j)))

// discrete event simulation

abstract class Simulation {

  type Action = () => Unit

  case class WorkItem(time: Int, action: Action)
  private type Agenda = List[WorkItem]
  private var agenda: Agenda = List()

  private var curtime = 0
  def currentTime: Int = curtime

  def afterDelay(delay: Int)(block: => Unit): Unit = {
    agenda = (WorkItem(curtime + delay, () => block) :: agenda).sortBy(_.time)
  }

  def next():Unit = { agenda match {
      case Nil => Nil
      case x :: xs => {
        agenda = xs
        x.action()
      }
    }
    curtime += 1
  }

  def run(): Unit = {
    afterDelay(0) {
      println("*** simulation started, time = "+currentTime+" ***")
    }
    while (!agenda.isEmpty) next()
  }
}

abstract class BasicCircuitSimulation extends Simulation {
  def InverterDelay: Int
  def AndGateDelay: Int
  def OrGateDelay: Int
    
  class Wire {

    private var sigVal = false
    private var actions: List[Action] = List()

    def getSignal: Boolean = sigVal
    def setSignal(s: Boolean): Unit =
      if (s != sigVal) {
        sigVal = s
        actions foreach (_())
      }

    def addAction(a: Action): Unit = {
      actions = a :: actions
      a()
    }
  }

  def inverter(input: Wire, output: Wire): Unit = {
    def invertAction(): Unit = {
      val inputSig = input.getSignal
      afterDelay(InverterDelay) { output setSignal !inputSig }
    }
    input addAction invertAction
  }

  def andGate(a1: Wire, a2: Wire, output: Wire): Unit = {
    def andAction(): Unit = {
      val a1Sig = a1.getSignal
      val a2Sig = a2.getSignal
      afterDelay(AndGateDelay) { output setSignal (a1Sig & a2Sig) }
    }
    a1 addAction andAction
    a2 addAction andAction
  }

  def orGate(o1: Wire, o2: Wire, output: Wire): Unit = {
    def orAction(): Unit = {
      val o1Sig = o1.getSignal
      val o2Sig = o2.getSignal
      afterDelay(OrGateDelay) { output setSignal (o1Sig | o2Sig) }
    }
    o1 addAction orAction
    o2 addAction orAction
  }

  def halfAdder(a: Wire, b: Wire, s: Wire, c: Wire): Unit = {
    val d = new Wire
    val e = new Wire
    orGate(a,b,d)
    andGate(a,b,c)
    inverter(c,e)
    andGate(d,e,s)
  }

  def fullAdder(a: Wire, b: Wire, cin: Wire, sum: Wire, cout: Wire): Unit = {
    val s = new Wire
    val c1 = new Wire
    val c2 = new Wire
    halfAdder(a, cin, s, c1)
    halfAdder(b, s, sum, c2)
    orGate(c1, c2, cout)
  }

  def probe(name: String, wire: Wire): Unit = {
    def probeAction(): Unit = {
      println(name + " " + currentTime + " value = " + wire.getSignal)
    }
    wire addAction probeAction
  }
}

object MySimulation extends BasicCircuitSimulation {
  def InverterDelay = 1
  def AndGateDelay = 3
  def OrGateDelay = 5
}

object TestCircuit {
  import MySimulation._
  val input1, input2, sum, carry = new Wire
  probe("sum", sum)
  probe("carry", carry)

  halfAdder(input1, input2, sum, carry)
  input1.setSignal(true)
  input2.setSignal(true)
  run()
}




