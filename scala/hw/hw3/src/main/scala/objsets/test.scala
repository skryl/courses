import objsets._

val t1 = new Tweet("skryl", "test tweet", 10)
val t2 = new Tweet("bob", "test tweet 2", 5)
val t3 = new Tweet("john", "test tweet 3", 0)

val s = new NonEmpty(t1, new NonEmpty(t2, new Empty, new Empty), new NonEmpty(t3, new Empty, new Empty))
s.print

val s2 = s.filter(t => t.retweets < 4)
s2.print

val s3 = new NonEmpty(t1, new Empty, new Empty)
val s4 = new NonEmpty(t2, new Empty, new Empty)
val s5 = new NonEmpty(t3, new Empty, new Empty)

val s6 = s3.union(s4)
val s7 = s6.union(s5)
