fun double x = 2 * x;
fun incr x = x + 1;
val a_tuple = (double, incr, double(incr 7));
val eighteen = (#1 a_tuple) 9;

(* abstracting away similarity *)

fun increment_n_times (n,x) =
  if n=0
  then x
  else 1 + increment_n_times (n-1,x);

fun double_n_times (n,x) =
  if n=0
  then x
  else 2 * double_n_times (n-1,x);

fun nth_tail (n,xs) =
  if n=0
  then xs
  else tl (nth_tail(n-1,xs));

(* better *)

fun n_times(f,n,x) =
  if n=0
  then x
  else f (n_times(f,n-1,x));

fun increment x = x + 1;
fun double x = x + x;

fun addition(n,x) = n_times(increment,n,x)
fun double_n_times(n,x) = n_times(double,n,x)

val x1 = n_times(double, 4, 7);
val x2 = n_times(increment, 4, 7);
val x3 = n_times(tl, 4, [3,4,5,6,7]);

(* anonymous functions *)

fn x => x + x;

val triple = fn y => 3 * y;

fun triple_n_times (n,x) = n_times(fn x => 3*x,n,x);

(* bad style *)

fun nth_tail(n,xs) = n_times(fn x => tl x, n, xs); (* pointless *)
fun nth_tail(n,xs) = n_times(tl, n, xs);

fun rev xs = List.rev xs (* pointless *)
val rev = List.rev

(* map and filter *)
 
fun map(f, xs) = case xs of
    [] => []
  | y :: ys => (f y) :: map(f, ys);

val x1 = map((fn x => x + 1), [4,5,6,7,8]);
val x2 = map(hd, [[1,2],[3,4],[5,6]]);

fun filter(f, xs) = case xs of
    [] => []
  | y :: ys => if f y then y :: filter(f, ys) else filter(f, ys);

fun is_even v = (v mod 2 = 0);

fun all_even xs = filter(is_even, xs);
fun all_even_snd xs = filter(fn (_,v) => is_even v, xs);

datatype exp = Constant of int
             | Negate of exp
             | Add of exp * exp
             | Multiply of exp * exp;

fun true_of_all_constants (f, exp) = case exp of
    Constant(i) => (f i)
  | Negate(exp) => true_of_all_constants(f,exp)
  | Add(exp1, exp2) => true_of_all_constants(f,exp1) andalso true_of_all_constants(f,exp2)
  | Multiply(exp1, exp2) => true_of_all_constants(f,exp1) andalso true_of_all_constants(f,exp2);

val e = Add(Multiply(Constant 1, Constant 2), Negate(Constant 3));
true_of_all_constants(fn x => x < 10, e);

(* closures and lexical scope *)

val x = 1;

fun f y =
  let
    val x = y+1
  in
    fn z => x + y + z
  end;

val x = 3;

val g = f(4);

val y = 5;

val z = g 6; (* get 15 *)

(* lexical scope allows functions to be pure, irrespective of the environment
   they are called in *)

(* technical reasons for lexical scope:
     * local variables in functions don't change meaning
     * functions can be type checked and reasoned about where they are defined
     * closures can easily store the data they need *)

fun greaterThanX x = fn y => y > x;
fun noNegatives xs = filter(greaterThanX ~1, xs);

fun allGreater (xs, n) = filter (fn  x => x > n, xs);

(* avoiding recomputation using closures *)

fun allShorterThan1 (xs, s) =
  filter (fn x => String.size x < String.size s, xs);

fun allShorterThan2 (xs, s) =
  let val i = String.size s
  in  filter(fn x => String.size x < i, xs)
  end;

(* fold and friends *)

fun fold (f,acc,xs) =
  case xs of
       [] => acc
     | x::xs => fold(f, f(acc,x), xs);

fun sumlist xs = fold (fn (acc,x) => acc + x, 0, xs);

fun nonneg xs = fold (fn (acc,x) => acc andalso x >= 0, true, xs);

(* combining functions *)

fun compose(f,g) = fn x => f(g x);
fun compose(f,g)  = f o g;

val sqrt_of_abs = Math.sqrt o Real.fromInt o abs;

(* redefining operators and pipelining *)

infix !>;
fun x !> f = f x;

fun sqrt_of_abs i = i !> abs !> Real.fromInt !> Math.sqrt;

fun backup1 (f,g) = fn x => case f x of
                                NONE => g x
                              | SOME y => y;

fun backup2 (f,g) = fn x => f x handle _ => g x;

(* currying *)

val sorted3 = fn x => fn y => fn z => z >= y andalso y >= x;

((sorted3 3) 2) 1;
sorted3 1 2 3;

fun sorted3_nicer x y z = z >= y andalso y >= x;

val t = sorted3_nicer 7 9 11;

(* partial application *)

val is_nonnegative = sorted3 0 0;

fun fold f acc xs =
  case xs of
       [] => acc
     | x :: xs' => fold f (f(acc,x)) xs';
     
val sum = fold (fn (x,y) => x+y) 0;
sum [1,2,3,4,5];

fun range i j = if i > j then [] else i :: range (i+1) j;

val countup = range 1;

countup(6);

fun exists predicate xs =
  case xs of
       [] => false
     | x :: xs' => predicate x orelse exists predicate xs';

val hasZero = exists (fn x => x=0);

hasZero [1,2,3,4,0,5,6];

val removeZeros = List.filter (fn x => x <> 0);

removeZeros [0,1,2,3];

(* partially applied polymorphic functions may error out! *)

val pairWithOne = List.map (fn x => (x,1));
pairWithOne [1,2,3];

(* converting between curried and tupled functions *)

fun curry f x y = f (x,y);
fun uncurry f (x,y) = f x y;

(* partial application of later args *)

fun other_curry f x y = f y x;

(* mutable references, a one field mutable object *)

val x = ref 42;
val y = ref 42;
val z = x;
val _ = x := 43;
val w = (!y) + (!z);

(* callbacks *)

val cbs : (int -> unit) list ref = ref [];

fun onKeyEvent f = cbs := f :: (!cbs);

fun onEvent i =
  let fun loop fs =
    case fs of
         [] => ()
       | f::fs' => (f i; loop fs')
    in loop (!cbs) end;

(* examples *)

fun printIfPressed i =
  onKeyEvent (fn j =>
    if i=j
    then print ("you pressed " ^ Int.toString i)
    else ());

(* ADTs with clojures *)

(* must use datatype keyword because type is recursive *)

datatype set = S of { insert : int -> set,
                      member : int -> bool,
                      size   : unit -> int };

val empty_set =
  let
    fun make_set xs =
    let
      fun contains i = List.exists (fn j => i=j) xs
    in
      S { insert = fn i => if contains i
                           then make_set xs
                           else make_set (i::xs),
          member = contains,
          size   = fn () => length xs }
    end
  in
    make_set []
  end;

(* client *)

fun use_sets () =
  let val S s1 = empty_set
      val S s2 = (#insert s1) 34
      val S s3 = (#insert s2) 34
      val S s4 = (#insert s3) 19
  in
    if (#member s4) 42
    then 99
    else if (#member s4) 19
    then 17 + (#size s3) ()
    else 0
  end;

(* porting closures to Java / C *)

datatype 'a mylist = Cons of 'a * ('a mylist) | Empty;

fun map f xs =
  case xs of
       Empty => Empty
     | Cons(c,xs) => Cons(f x, map f xs);

fun filter f xs =
  case xs of
       Empty => Empty
     | Cons(c,xs) => if f x then Cons(x, filter f xs) else filter f xs;

fun length xs =
  case xs of
       Empty => 0
     | Cons(_,xs) => 1 + length xs;

(* double all numbers in xs *)
val doubleAll = map (fn x => x * 2);

(* count number of ns in xs *)
fun countNs (xs, n : int) = length (filter (fn x => x = n) xs);

(* in Java through one-method interfaces, because functions are like objects
   with one method. *)

(* implement these interfaces with objects that have the fields we need *)

interface Func<B,A> { B m(A x); }

interface Pred<A> { boolean m(A x); }

(* in C, pass along an environment with first class functions. *)
