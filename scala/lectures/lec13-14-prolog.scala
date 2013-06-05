// logic programming

object Prolog {

trait Term {

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

case class Binding(name: String, term: Term)
type Subst = List[Binding]

// X            -> Var("X")
// cons(X, nil) -> Constr("cons", List(Var("X")), Constr("nil", List()))

def lookup(s: Subst, name: String): Option[Term] = s match {
  case List() => None
  case b :: s1 => if (name == b.name) Some(b.term) else lookup(s1, name)
}

def pmatch(pattern: Term, term: Term, s: Subst): Option[Subst] =
  (pattern, term) match {
    case (Var(a), _) => lookup(s, a) match {
      case Some(term1) => pmatch(term1, term, s)
      case None => Some(Binding(a, term) :: s)
    }
    case (Constr(a, ps), Constr(b, ts)) if a == b =>
      pmatch(ps, ts, s)
    case _ => None
  }

def pmatch(patterns: List[Term], terms: List[Term], s: Subst): Option[Subst] =  {
  if (patterns.length != terms.length) None else
    (patterns, terms) match {
      case (Nil, Nil) => Some(s)
      case (x :: xs, y :: ys) => pmatch(x, y, s) match {
        case Some(b) => pmatch(xs, ys, b ++ s)
        case None    => None
      }
      case _ => None
    }
}

def unify(x: Term, y: Term, s: Subst): Option[Subst] = (x, y) match {
  case (Var(a), Var(b)) if a == b => Some(s)
  case (Var(a), _) => lookup(s, a) match {
    case Some(x1) => unify(x1, y, s)
    // case None => if ((y map s).freevars contains a) None
    //              else Some(Binding(a,y) :: s)
    case None => Some(Binding(a,y) :: s)
  }
  case (_, Var(b)) => unify(y, x, s)
  case (Constr(a, xs), Constr(b, ys)) if a == b => unify(xs, ys, s)
  case _ => None
}

def unify(xs: List[Term], ys: List[Term], s: Subst): Option[Subst] =  {
  if (xs.length != ys.length) None else
    (xs, ys) match {
      case (Nil, Nil) => Some(s)
      case (x :: xs, y :: ys) => unify(x, y, s) match {
        case Some(b) => unify(xs, ys, b ++ s)
        case None    => None
      }
      case _ => None
    }
}

}

// friends(bob, alice)
// friends(alex, john)
// friends(alex, X)
