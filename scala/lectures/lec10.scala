// constraints

// constraint networks

val C, F = new Quantity

// boxes are constraints, connectors are quantities

def CFconverter(c: Quantity, f: Quantity) = {
  val u, v, w, x, y = new Quantity
  Constant(w, 9); Multiplier(c, w, u)
  Constant(y, 32); Adder(v, y, f)
  Constant(x, 5); Multiplier(v, x, u)
}

CFconverter(C, F)
Probe("Celsius temp", C)
Probe("Fahrenheit temp", F)

C setValue 25    // Probe: C: 25, F: 77
F setValue 212   // Error! contradiction: 77 and 212

// reusing

C forgetValue    // Probe: C: ?, F: ?
F setValue 212   // Probe: C: 100, F: 212

// quantities


abstract class Constraint {
  def newValue: Unit
  def dropValue: Unit
}

object NoConstraint extends Constraint {
  def newValue: Unit = error("NoConstraint.newValue")
  def dropValue: Unit = error("NoConstraint.dropValue") 
}

class Quantity {
  private var value: Option[Double] = None
  private var constraints: List[Constraint] = List()
  private var informant: Constraint = NoConstraint

  def getValue: Option[Double] = value

  def setValue(v: Double, setter: Constraint): Unit = value match {
    case Some(v1) =>
      if (v != v1) error("Error! contradiction: " + v + " and " + v1)
    case None =>
      informant = setter; value = Some(v)
    for (c <- constraints if c != informant) c.newValue
  }

  def setValue(v: Double): Unit = setValue(v, NoConstraint)

  def forgetValue(retractor: Constraint): Unit = {
    if (retractor == informant) {
      value = None
      for (c <- constraints if c!= informant) c.dropValue
    }
  }

  def forgetValue: Unit = forgetValue(NoConstraint)

  def connect(c: Constraint) = {
    constraints = c :: constraints
    value match {
      case Some(_) => c.newValue
      case None =>
    }
  }

}

case class Adder(a1: Quantity, a2: Quantity, sum: Quantity) extends Constraint {
  def newValue = (a1.getValue, a2.getValue, sum.getValue) match {
    case (Some(x1), Some(x2), _) => sum.setValue(x1 + x2, this)
    case (Some(x1), _, Some(r))  => a2.setValue(r - x1, this)
    case (_, Some(x2), Some(r))  => a1.setValue(r - x2, this)
    case _ =>
  }

  def dropValue {
    a1.forgetValue(this); a2.forgetValue(this); sum.forgetValue(this)
  }

  a1 connect this
  a2 connect this
  sum connect this
}

case class Multiplier(m1: Quantity, m2: Quantity, mul: Quantity) extends Constraint {
  def newValue = (m1.getValue, m2.getValue, mul.getValue) match {
    case (Some(x1), _, _) if x1 == 0 => mul.setValue(0, this)
    case (_, Some(x2), _) if x2 == 0 => mul.setValue(0, this)
    case (Some(x1), Some(x2), _) => mul.setValue(x1 * x2, this)
    case (Some(x1), _, Some(r))  => m2.setValue(r / x1, this)
    case (_, Some(x2), Some(r))  => m1.setValue(r / x2, this)
    case _ =>
  }

  def dropValue {
    m1.forgetValue(this); m2.forgetValue(this); mul.forgetValue(this)
  }

  m1 connect this
  m2 connect this
  mul connect this
}

case class Constant(q: Quantity, v: Double) extends Constraint {
  def newValue: Unit = error("Constant.newValue")
  def dropValue: Unit = error("Constant.dropValue") 
  q connect this
  q.setValue(v, this)
}

case class Equalizer(e1: Quantity, e2: Quantity) extends Constraint {
  def newValue: Unit = (e1.getValue, e2.getValue) match {
    case (Some(x1), _) => e2.setValue(x1, this)
    case (_, Some(x2)) => e1.setValue(x2, this)
    case _ =>
  }

  def dropValue {
    e1.forgetValue(this); e2.forgetValue(this)
  }

  e1 connect this
  e2 connect this
}

case class Probe(name: String, q: Quantity) extends Constraint {
  def newValue: Unit = printProbe(q.getValue)
  def dropValue: Unit = printProbe(None)

  def probe: Unit = printProbe(q.getValue)
    
  private def printProbe(v: Option[Double]): Unit = {
    val vstr = v match {
      case Some(x) => x.toString()
      case None => "?"
    }
    println(s"Probe: ${name} = ${vstr}")
  }

  q connect this
}


// make it prettier

class AlgebraicQuantity extends Quantity {

  def +(that: AlgebraicQuantity): AlgebraicQuantity = {
    val sum = new AlgebraicQuantity
    Adder(this, that, sum)
    sum
  }

  def *(that: AlgebraicQuantity): AlgebraicQuantity = {
    val mul = new AlgebraicQuantity
    Multiplier(this, that, mul)
    mul
  }

  def ===(that: AlgebraicQuantity): AlgebraicQuantity = {
    Equalizer(this, that)
    that
  }

}

def c(v: Double):AlgebraicQuantity = {
  val q = new AlgebraicQuantity
  Constant(q, v)
  q
}

val C, F = new AlgebraicQuantity
C * c(9) === (F + c(-32)) * c(5)

val p1 = Probe("Celsius temp", C)
val p2 = Probe("Fahrenheit temp", F)

C setValue 25    // Probe: C: 25, F: 77
F setValue 212   // Error! contradiction: 77 and 212

// reusing

C forgetValue    // Probe: C: ?, F: ?
F setValue 212   // Probe: C: 100, F: 212


// systems

val X, Y = new AlgebraicQuantity

X + Y === c(15)
X * Y === c(50)

val p1 = Probe("X", X)
val p2 = Probe("Y", Y)

X setValue 10



