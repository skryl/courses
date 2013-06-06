// logic programming

object Prolog {

trait Term {

  def freevars: List[String] = this match {
    case Var(a) => List(a)
    case Constr(a, ts) => (ts flatMap (t => t.freevars)).distinct
  }

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

case class Clause(lhs: Term, rhs: List[Term]) {
  def freevars = (lhs.freevars ::: (rhs flatMap (t => t.freevars))).distinct
  def newInstance = {
    var s: Subst = List()
    for (a <- freevars) { s = Binding(a, Var(a)) :: s }
    Clause(lhs map s, rhs map (t => t map s))
  }
}

// X            -> Var("X")
// cons(X, nil) -> Constr("cons", List(Var("X")), Constr("nil", List()))

def lookup(s: Subst, name: String): Option[Term] = {
  s match {
    case List() => None
    case b :: s1 => if (name == b.name) Some(b.term) else lookup(s1, name)
  }
}

// replaced by unify()
// 
// def pmatch(pattern: Term, term: Term, s: Subst): Option[Subst] =
//   (pattern, term) match {
//     case (Var(a), _) => lookup(s, a) match {
//       case Some(term1) => pmatch(term1, term, s)
//       case None => Some(Binding(a, term) :: s)
//     }
//     case (Constr(a, ps), Constr(b, ts)) if a == b =>
//       pmatch(ps, ts, s)
//     case _ => None
//   }
// 
// def pmatch(patterns: List[Term], terms: List[Term], s: Subst): Option[Subst] =  {
//   if (patterns.length != terms.length) None else
//     (patterns, terms) match {
//       case (Nil, Nil) => Some(s)
//       case (x :: xs, y :: ys) => pmatch(x, y, s) match {
//         case Some(b) => pmatch(xs, ys, b ++ s)
//         case None    => None
//       }
//       case _ => None
//     }
// }

def unify(x: Term, y: Term, s: Subst): Option[Subst] = (x, y) match {
  case (Var(a), Var(b)) if a == b => Some(s)
  case (Var(a), _) => lookup(s, a) match {
    case Some(x1) => unify(x1, y, s)
    case None => if ((y map s).freevars contains a) None
                 else Some(Binding(a,y) :: s)
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
        case Some(b) => unify(xs, ys, b)
        case None    => None
      }
      case _ => None
    }
}

def solve(query: List[Term], clauses: List[Clause]): Stream[Subst] = {
  def solve1(query: List[Term], s: Subst): Stream[Subst] = query match { 
    case List() =>
      Stream.cons(s, Stream.empty)
    case Constr("not", qs) :: query1 =>
      if (solve1(qs, s).isEmpty) solve1(query1, s)
      else Stream.empty
    case q :: query1 =>
      for { clause <- clauses.toStream
            s1 <- tryClause(clause.newInstance, q, s)
            s2 <- solve1(query1, s1) } yield s2
  }

  def tryClause(c: Clause, q: Term, s: Subst): Stream[Subst] = {
    unify(q, c.lhs, s) match {
      case Some(s1) => solve1(c.rhs, s1)
      case None => Stream.empty
    }
  }

  solve1(query, List())
}

}

// father(a, b)
// father(b, c)
// ancestor(X,Y) := father(X,Y)
// ancestor(X,Y) := father(X,Z), ancestor(Z,Y)
// 
// father(a, b)  => yes
// father(X, b)  => a
// father(a, Y)  => b
// father(X, a)  => no
// father(a, c)  => no

// clauses
//
// val clauses = List(
//   Clause(Constr("father", List(Constr("a", List()), Constr("b", List()))), List()),
//   Clause(Constr("father", List(Constr("b", List()), Constr("c", List()))), List()),
//   Clause(Constr("ancestor", List(Var("X"), Var("Y"))), 
//     List(Constr("father", List(Var("X"), Var("Y"))))),
//   Clause(Constr("ancestor", List(Var("X"), Var("Y"))), 
//     List(Constr("father", List(Var("X"), Var("Z"))), Constr("ancestor", List(Var("Z"), Var("Y"))) ))
// )

// father queries
//
// val query = Constr("father", List(Constr("a", List()), Constr("b", List()) ))
// val query = Constr("father", List(Var("X"), Constr("b", List()) ))
// val query = Constr("father", List(Constr("a", List()), Var("Y")))
// val query = Constr("father", List(Constr("X", List()), Var("a")))
// val query = Constr("father", List(Constr("a", List()), Constr("c", List())))

// ancestor queries

// val s = solve(List(query), clauses)
// s.take(1).toList
