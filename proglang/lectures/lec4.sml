(* type inference *)

val x = 42;

fun f (y, z, w) =
  if y       (* must have type bool *)
  then z + x (* z must be an int *)
  else 0     (* both branches have same type *)

(* f must return an int
   f must take a bool * int * ANYTHIN
   so val f : bool * int * 'a -> int *)

(* key steps 
    - collect all the facts
    - these facts constrain the function type *)

(* 
  f : T1 -> T2 [must be a function; all functions take 1 arg]
  x : T1

  y : T3
  z : T4

  T1 = T3 * T4 [else pattern match doesn't type check]
  T3 = int     [abs has type int -> int]
  T4 = int     [because we added z to an int]
  So (abs y) + z : int, so let-expression : int, so body : int
  T2 = int
  f : int * int -> int
*)

fun f x = 
  let val (y, z) = x in
    (abx y) + z
  end

(* 
  sum : T1 -> T2
  xs : T1

  x : T3
  xs' : T3 list [pattern match a T1]

  T1 = T3 list
  T2 = int [ because 0 might be returned ]
  T3 = int [because x:T3 and we add x to something]
  from T1 = T3 list and T3 = int, we know T1 = int list
  from that and T2=int, we know f : int list -> int
*)
fun sum xs =
  case xs of
       [] => 0
     | x::xs' => x + (sum xs')


(*
  length : T1 -> T2
  xs : T1

  x : T3
  xs' : T3 list [ because of pattern match ]

  T1 = T3 list
  T2 = int [ because 0 might be returned ]

  T3 list -> int [because there are no more constraings]
  'a list -> int
*)
fun length xs =
  case xs of
       [] => 0
     | x::xs' => (length xs')


(* 
  f : T1 * T2 * T3 -> T4
  x : T1
  y : T2
  z : T3

  T4 = T1 * T2 * T3 [must be true]
  T4 = T2 * T1 * T3 [must be true]
  T1 = T2 [only way the above can be true]

  f : T1 * T1 * T3 -> T1 * T1 * T3
  f : 'a * 'a * 'b -> 'a * 'a * 'b
*)
fun f (x, y, z) =
  if true
  then (x,y,z)
  else (y,x,z)


(* 
  compose : T1 * T2 -> T3
  f : T1
  g : T2
  x : T4

  body being a function has type T3=T4->T5
  from g being passedx, T2=T4->T6 for some T6
  from f being passed the result of g, T1=T6->T7 
  from a call to f being the body of anonymous function T7=T5

  T1=T6->T5, T2=T4-T6, T3=T4->T5
  (T6->T5) * (T4->T6) -> (T4->T5)

  ('a -> 'b) * ('c -> 'a) -> ('c -> 'b)
*)
fun compose (f, g) = fn x => f (g x)

(* mutual recursion *)

fun f1 p1 = e1
and f2 p2 = e2
and f3 p3 = e3

(* useful for FSMs *)

fun match xs =
  let fun s_need_one xs =
    case xs of
         [] => true
       | 1::xs' => s_need_two xs'
       | _ => false
    and s_need_two xs =
    case xs of
         [] => false
       | 2::xs' => s_need_one xs'
       | _ => false
  in
    s_need_one xs
  end

(* mutually recursive datatypes *)

datatype t1 = ...
    and t2 = ...
    and t3 = ...

datatype t1 = Foo of int | Bar of t2
     and t2 = Baz of string | Quux of t1

(* alternative for mutual recursion *)

fun earlier (f,x) = ... f y ...

fun later x = earlier(x,y)

(* modules for namespaces *)

structure MyModule = 
struct 
  val a = 1
  (* more bindings here *)
end

ModuleName.bindingName (* using module funcs *)

structure MyMathLib =
struct
  fun fact x = if x=0 then 1 else x * fact (x-1)
  val half_pi = Math.pi / 2.0
  fun doubler y = y + y
end

val pi = MyMathLib.doubler MyMathLib.half_pi

(* use all bindings in module directly *)

open MyMathLib

val hp = MyMathLib.half_pi

(* modules for data hiding *)

signature MATHLIB =
sig
  val fact : int -> int
  val half_pi : int
  val doubler : int -> int
end

structure MyMathLib :> MATHLIB =
struct
  fun fact x = if x=0 then 1 else x * fact (x-1)
  val half_pi = Math.pi / 2.0
  fun doubler y = y + y
end

(* leave out private functions from the sig *)

signature MATHLIB =
sig
  val fact : int -> int
  val half_pi : int
end

(* larger example *)

structure Rational1
struct
  datatype rational = Whole of int | Frac of int*int
  exception BadFrac

  (* private *)

  fun gcd (x,y) =
    if x=y
    then x
    else if x < y
    then gcd(x, y-x)

  fun reduce r =
    case r of
         Whole _ => r
       | Frac(x,y) =>
           if x=0
           then Whole 0
           else let val d =gcd(abs x, y) in
             if d=y
             then Whole(x div d)
             else Frac(x div d, y div d)
                end

  fun make_frac (x,y) =
    if y = 0
    then raise BadFrac
    else if y < 0
    then reduce(Frac(~x,~y))
    else reduce(Frac(x,y))

  fun add (r1,r2) =
    case (r1,r2) of
         (Whole(i),Whole(j)) => Whole(i+j)
       | (Whole(i),Frac(j,k)) => Frac(j+k*i,k)
       | (Frac(j,k),Whole(i)) => Frac(j+k*i,k)
       | (Frac(a,b),Frac(c,d)) => Frac(a*d + b*c, b*d)

  fun toString r =
    case r of
         Whole i => Int.toString i
       | Frac(a,b) => (Int.toString a) ^ "/" ^ (Int.toString b)
end

val x = Rational1.make_fac(9,6)
val y = Rational1.make_frac(~8,~2)
Rational1.toString(Rational1.add(x,y))

(* 
  Properties [externally visible guarantees, up to library writer]
  - Disallow denominators of 0
  - Return strings in reduced form
  - No infinite loops or exceptions

  Invariants [part of the implementation, not the module's spec]
  - All denominators are greater than 0
  - All rational values returned form functions are reduced
*)

signature RATIONAL_A =
sig
  datatype rational = Whole of int | Frac of int*int
  exception BadFrac
  val make_frac : int * int -> rational
  val add : rational * rational -> rational
  val toString : rational -> string
end

(* this signature allows clients to violate our invariants, 
   because they know the rational datatype structure and can 
   call the Frac constructor directly instead of using make_frac *)

Rational1.Frac(1,0)
Rational1.Frac1(~3,~2)

signature RATIONAL_B =
sig
  type rational (* abstract type, no implementation provided *)
  exception BadFrac
  val make_frac : int * int -> rational
  val add : rational * rational -> rational
  val toString : rational -> string
end

signature RATIONAL_C =
sig
 (* constructor functions can be exposed explicitly, and have tighter type signatures *) 
  val Whole : int -> rational 
  exception BadFrac
  val make_frac : int * int -> rational
  val add : rational * rational -> rational
  val toString : rational -> string
end

(* equivalent structures *)

(* 
   Imagine Rational2 is same as Rational1 except fractions are reduced during
   toString.
    - non equivalent under RATIONAL_A
    - equivalent under RATIONAL_B and RATIONAL_C
*)

(* each signature implementation has a unique type *)

structure Rational1 : RATIONAL_C
structure Rational2 : RATIONAL_C
structure Rational3 : RATIONAL_C

Rational1.toString(Rational1.make_frac(9,~6));
Rational3.toString(Rational3.make_frac(9,~6));
Rational3.toString(Rational1.make_frac(9,~6)) (* NO NO NO *)

(* function equivalence *)

(* 
  Given equivalent args, they: *
  - produce equivalent results
  - have the same termination behavior
  - mutate memory in the same way
  - do the same input/output
  - raise the same exceptions
*)

(* equivalent *)

fun f x = x + x

val y = 2
fun f x = y * x

(* not equivalent *)

fun g (f,x) = 
  (f x) + (f x)

val y = 2
fun g (f,x) =
  y * (f x)

(* standard equivalences *)

(* syntactic sugar *)

fun f x = x andalso g x
fun f x = if x then g x else false

(* 1. consistently rename bound variables *)

val y = 14
fun f x = x+y+x

val z = 14
fun f x = z+y+z

(* 2. use a helper function or not *)

val y = 15
fun g z = (z+y+z)+z

val y = 14
fun f x = x+y+x
fun g z = (f z)+z

(* 3. unnecessary function wrapping *)

fun f x = x + x
fun g y = f y

fun f x = x+x
val g = f

(* if we ignore types then let bindings can be syntactic sugar for calling an
   anon function, in ML they are not because of the way the type system treats
   them *)

let val x = e1 in e2 end

(fn x => e2) e1
