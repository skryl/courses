// LISP

// we can build a list data structure out of pure functions
// nil        = (lambda (k) (k 'none 'none))
// (cons x y) = (lambda (k) (k x y))
// (car l)    = (l (lambda (x y) x))
// (cdr l)    = (l (lambda (x y) y))
// (null? l)  = (l (lambda (x y) (= x 'none)))

(define (map f xs)
  (if (null? xs)
    '()
    (cons (f (car xs)) (map f (cdr xs)))))

(map (lambda (x) (* x x)) '(1 2 3))

// recursion through self application

(lambda (n)
  ((lambda (fact)
    (fact fact n))
  (lambda (ft k)
    (if (= k 1)
      1
      (* k (ft ft (- k 1)))))))

// more generally, the Y combinator, tada!

(define Y
  (lambda (f)
    ((lambda (x) (x x))
     (lambda (g)
       (f (lambda args (apply (g g) args)))))))

(define fac
  (Y
    (lambda (f)
      (lambda (x)
        (if (< x 2)
            1
            (* x (f (- x 1))))))))

// scheme interpreter

// internal representation

(define factorial
  (lambda (n)
    (if (= n 0)
      1
      (* n (factorial (- n 1))))))

(factorial 5)

List('def, 'factorial,
  List('lambda, List('n),
    List('if, List('=, 'n, 0),
      1
      List('*, 'n, List('factorial, List('-, 'n, 1))))))

List('factorial, 5')

// the parser
// string -> tokens
// tokens -> internal data structure

// the tokenizer

// can we use a better type set?
//
type Data = Any

class LispTokenizer(s: String) extends Iterator[String] {
  private var i = 0
  private def isDelimiter(ch: Char) = ch <= ' ' || ch == '(' || ch == ')'

  def hasNext: Boolean = {
    while (i < s.length() && s.charAt(i) <= ' ') { i = i + 1 }
    i < s.length()
  }

  def next: String = {
    if (hasNext) {
      val start = i
      var ch = s.charAt(i); i = i + 1
      if (ch == '(') "("
      else if (ch == ')') ")"
      else {
        while (i < s.length() && !isDelimiter(s.charAt(i))) { i = i + 1 }
        s.substring(start, i)
      }
    } else error("more input expected")
  }
}

def string2lisp(s: String): Data = {
  val it = new LispTokenizer(s)
  def parseExpr(token: String): Data = {
    if (token == "(") parseList
    else if (token == ")") error("unmatched parenthesis")
    else if (token.charAt(0).isDigit) token.toInt
    else if (token.charAt(0) == '\"' && token.charAt(token.length()-1) == '\"') token.substring(1, token.length - 1)
    else Symbol(token)
  }
  def parseList: List[Data] = {
    val token = it.next
    if (token == ")") Nil else parseExpr(token) :: parseList
  }
  parseExpr(it.next)
}

def lisp2string(l: Data): String = l match {
  case Symbol(n) => n
  case _: Int    => l.toString
  case x :: xs   => "(" + (x :: xs).map(lisp2string(_)).mkString(" ") + ")"
}

// def normalize(expr: Data): Data = expr match {
//   case 'and :: x :: y :: Nil =>
//     normalize('if :: x :: y :: 0 :: Nil)
// 
//   case 'or :: x :: y :: Nil =>
//     normalize('if :: x :: 1 :: y :: Nil)
// }

abstract class Environment {
  def lookup(n: String): Data

  def extendRec(name: String, expr: Environment => Data) =
    new Environment {
      def lookup(n: String): Data =
        if (n == name) expr(this) else Environment.this.lookup(n)
    }

  def extend(name: String, v: Data) = extendRec(name, env1 => v) 

  def extendMulti(ps: List[String], vs: List[Data]): Environment =
    (ps, vs) match {
      case (List(), List()) =>
        this
      case (p :: ps1, arg :: args1) =>
        extend(p, arg).extendMulti(ps1, args1)
      case _ =>
        error("wrong number of arguments")
    }
}

val EmptyEnvironment = new Environment {
  def lookup(n: String): Data = error("undefined : " + n)
}

case class Lambda(f: List[Data] => Data)

// example
Lambda { case List(arg1: Int, arg2: Int) => arg1 * arg2 }

def apply(fn: Data, args: List[Data]): Data = fn match {
  case Lambda(f) => f(args)
  case _ => error("applicatin of a non-function: " + fn + " to " + args)
}

def asList(x: Data): List[Data] = x match {
  case xs: List[_] => xs
  case _ => error("malformed list : " + x)
}

def eval(x: Data, env:Environment): Data = {
  def mkLambda(ps: List[String], body: Data, env: Environment) =
    Lambda { args => eval(body, env.extendMulti(ps, args)) }

  def paramName(param: Data): String = param match {
    case Symbol(name) => name 
  }

  x match {
    case _: String => x
    case _: Int    => x
    case Symbol(name) => env lookup name
    case 'val :: Symbol(name) :: expr :: rest :: Nil =>
      eval(rest, env.extend(name, eval(expr, env)))
    case 'def :: Symbol(name) :: expr :: rest :: Nil =>
      eval(rest, env.extendRec(name, env1 => eval(expr, env1)))
    case 'if :: cond :: thenpart :: elsepart :: Nil =>
      if (eval(cond, env) != 0) eval(thenpart, env) else eval(elsepart, env)
    case 'quote :: y :: Nil => y
    case 'lambda :: params :: body :: Nil =>
      mkLambda(asList(params) map paramName, body, env)
    case operator :: operands =>
      apply(eval(operator, env), operands map (x => eval(x, env)))
  }
}

val globalEnv = EmptyEnvironment.extend("=", Lambda{
  case List(arg1, arg2)                 => if(arg1 == arg2) 1 else 0}).extend("+", Lambda{
  case List(arg1: Int, arg2: Int)       => arg1 + arg2
  case List(arg1: String, arg2: String) => arg1 + arg2}).extend("-", Lambda{
  case List(arg1: Int, arg2: Int)       => arg1 - arg2}).extend("*", Lambda{
  case List(arg1: Int, arg2: Int)       => arg1 * arg2}).extend("/", Lambda{
  case List(arg1: Int, arg2: Int)       => arg1 / arg2}).extend("nil", Nil).extend("cons", Lambda{
  case List(arg1, arg2)                 => arg1 :: asList(arg2)}).extend("car", Lambda{
  case List(x :: xs)                    => x}).extend("cdr", Lambda{
  case List(x :: xs)                    => xs}).extend("null?", Lambda{
  case List(Nil) => 1
  case _ => 0})

def evaluate(s: String): String = lisp2string(eval(string2lisp(s), globalEnv))

def factDef = """
  (def factorial (lambda (n)
    (if (= n 0)
      1
      (* n (factorial (- n 1)))))
  (factorial 10))
"""

string2lisp(factDef)
evaluate(factDef)
