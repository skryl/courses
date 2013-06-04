// logic programming

trait Term {

  private def lookup(s: Subst, name: String): Option[Term] = s match {
    case List() => None
    case b :: s1 => if (name == b.name) Some(b.term)
                    else lookup(s1, name)
  }

  def freevars: List[String] = ???

  def map(s: Subst): Term = this match {
    case Var(a) => lookup(s, a) match {
      case Some(b) => b map s
      case None => this
    }
    case Constr(a, ts) => Constr(a, ts map (t => t map s))
  }

}

case class Var(a: String) extends Term
case class Constr(a: String, ts: List[Term]) extends Term

Var("X")
Constr("cons", List(Var("X")), Constr("nil", List()))

type Subst = List[Binding]
case class Binding(name: String, term: Term)
