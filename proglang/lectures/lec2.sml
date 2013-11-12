(* records *)

val r = { a=1, b=2, c=3 };
#a(r)   (* -> 1 *)

(* tuples are sugared records *)

val tuple_rec2 = { 2=5, 1=6 }; (* -> (6,5) *)
val tuple_rec3 = { 3="hi", 2=5, 1=6 }; (* -> (6,5, "hi") *)

(* datatypes *)

datatype mytype = TwoInts of int * int
                | Str of string
                | Pizza;

TwoInts;   (* fn : int * int -> mytype *)
Str;       (* fn : Str -> mytype *)
Pizza;     (* mytype *)

val a = Str "hi";
val b = Str;
val c = Pizza;
val d = TwoInts(1+2, 3+4);
val e = a;

(* Case expressions - language construct for universal data extraction, better
   than extractor functions because compiler checks for missing/redundant cases. *)

fun f x = case x of
    Pizza => 3
  | Str s => 8
  | TwoInts(i1,i2) => i1 + i2;

(* useful datatypes *)

(* enumerations *)

datatype suit = Club | Diamond | Heart | Spade;
datatype rank = Jack | Queen | King | Ace | Num of int;

datatype id = StudentNum of int
            | Name of string * (string option) * string;

val s = Name("Alex", NONE, "Skryl");

datatype exp = Constant of int
             | Negate   of exp
             | Add      of exp * exp
             | Multiply of exp * exp;

fun eval e =
  case e of
       Constant i => i
     | Negate e2  => ~ (eval e2)
     | Add(e1,e2) => (eval e1) + (eval e2)
     | Multiply(e1,e2) => (eval e1) * (eval e2);

val e = (Add (Constant (10+9), Negate (Constant 4)));
eval e;

fun max_constant exp = 
  let fun biggest(e1, e2) = Int.max(max_constant e1, max_constant e2)
  in case exp of
      Constant c => c
    | Negate e2  => max_constant e2
    | Add(e1, e2) => biggest(e1, e2)
    | Multiply(e1, e2) => biggest(e1, e2)
  end;

(* type alias, just create a new name for an existing type *)

type aname = t;

type card = suit * rank;

type name_record = { student_num : int option, 
                     first       : string,
                     middle      : string option,
                     last        : string };

fun is_Queen_of_Spades (c : card) =
  #1 c = Spade andalso #2 c = Queen;

fun is_Queen_of_Spades2 c =
  case c of
       (Spade, Queen) => true
     | _ => false;

val c1 : card = (Diamond, Ace);
val c2 : suit * rank = (Heart, Ace);
val c3 = (Space, Ace);

(* lists and options are datatypes *)

datatype my_int_list = Empty | Cons of int * my_int_list
val l = Cons(4,Cons(23,Cons(2008,Empty)));

fun append_my_list (xs, ys) =
  case xs of
       Empty => ys
     | Cons(x, xs') => Cons(x, append_my_list(xs', ys));

fun append (xs, ys) =
  case xs of
       [] => ys
     | x::xs' => x :: append (xs', ys);

fun sum_list xs =
  case xs of
       [] => 0
     | x::xs' => x + sum_list xs';

fun inc_or_zero intoption =
  case intoption of
       NONE => 0
     | SOME i = i + 1;

(* polymorphic datatypes and type parameters *)

datatype 'a option = NONE | SOME of 'a;
datatype 'a mysist = Empty | Cons of 'a * 'a mylist;
datatype ('a,'b) tree = Node of 'a * ('a,'b) tree * ('a,'b) tree | Leaf of 'b;

(* type is (int,int) tree -> int *)
fun sum_tree tr =
  case tr of
       Leaf i => i
     | Node(i,lft,rgt) => i + sum_tree lft + sum_tree rgt;

(* type is ('a,int) tree -> int *)
fun sum_leaves tr =
  case tr of
       Leaft i => i
     | Node(i,lft,rgt) => sum_leaves lft + sum_leaves rgt;

(* type is ('a,'b) tree -> int *)
fun num_leaves tr =
  case tr of
       Leaft i => 1
     | Node(i,lft,rgt) => num_leaves lft + num_leaves rgt;

(* pattern matching also works for records and tuples *)

fun sum_triple triple =
  case triple of
       (x,y,z) => x + y + z;

fun full_name r =
  case r of
       {first=x, middle=y, last=z} =>
       x ^ " " ^ y ^ " " ^ z;

(* a more concise way, in ML every function takes exactly one argument! *)

val p = e (* p is a pattern, e is an expression *)

fun sum_triple triple =
  let val (x,y,z) = triple
  in x + y + z end;

(* function arguments can be patterns *)

fun f p = e

fun sum_triple (x,y,z) =
  x + y + z;

fun full_name {first=x, middle=y, last=z} =
  x ^ " " ^ y ^ " " ^ z;


(* equality types, types that can be compared using = *)

(* ''a * ''a -> string *)
fun same_thing (x,y) =
  if x = y then "yes" else "no";

(* nested patterns *)

exception ListLengthMismatch;

fun zip3 list_triple =
  case list_triple of
       ([],[],[]) => []
     | (hd1::tl1,hd2::tl2,hd3::tl3) => (hd1,hd2,hd3)::zip3(tl1,tl2,tl3)
     | _ => raise ListLengthMismatch;

fun unzip3 lst =
  case lst of
       [] => ([],[],[])
     | (a,b,c)::tl => let val (l1,l2,l3) = unzip3 tl
                      in 
                        (a::l1,b::l2,c::l3)
                      end;

fun nondecreasing lst =
  case lst of
       []         => true
     | _::[]      => true
     | x1::x2::xs => x1 < x2 andalso nondecreasing xs;


datatype sgn = N | Z | P;

fun multsign (x1,x2) =
  let fun sign x = if x = 0 then Z else if x > 0 then P else N
  in case (sign x2, sign x2) of
          (Z, _) => Z
        | (_, Z) => Z
        | (P, P) => P
        | _ => N
  end;

(* function patterns, syntactic sugar for case statements *)

fun eval (Constant i) = i
  | eval (Negate e2) = ~ (eval e2)
  | eval (Add(e1,e2)) = (eval e1) + (eval e2)
  | eval (Multiply(e1,e2)) = (eval e1) * (eval e2);

fun append ([],ys) = ys
  | append (x::xs', ys) = x :: append(xs',ys);

(* exceptions *)

fun hd xs = 
  case xs of
       []   => raise List.Empty
     | x::_ => x;

exception MyUndesirableCondition;
exception MyOtherException of int * int;

raise MyOtherException (3,4);

fun mydiv (x,y) =
  if y = 0
  then raise MyUndesirableCondition
  else x div y;

val x = mydiv (3,0) handle MyUndesirableCondition => 42;
