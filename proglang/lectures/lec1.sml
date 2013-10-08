(* THis is a comment. This is our first program. *)

(* value bindings *)

val x = 34; (* int *)
val y = 17;
val z = (x + y) + (y + 2);
val abs_of_z = if z < 0 then 0 - z else z;

(* function bindings *)

fun pow(x: int, y: int) = 
  if y = 0 then 1
  else x * pow(x, y - 1)

fun cube(x: int) = pow(x, 3)

pow(2,2);   (* -> 4 *)
pow (2,2);   (* -> 4 *)
pow 2,2;   (* illegal, unless only one arg *)
cube 7;    (* -> 343 *)
cube(7);   (* -> 343 *)

(* tuples and lists *)

val p = (1,2);
#1(p);   (* -> 1 *)
#2(p);   (* -> 2 *)
val nested = ((1,2), (3,4)) (* (int*int) * (int*int) *)

fun swap (pr : int*int) =
  (#2 pr, #1 pr);

fun div_mod (x : int, y : int) =
  (x div y, x mod y);

(* lists, all elements of the same type *)

val x = [];
[1,2,3,4];
val y = 1::2::3::x;

null x; (* -> true *)
hd y;   (* -> 1 *)
tl y;   (* -> [2,3] *)
hd [];  (* exception *)
tl [];  (* exception *)

[];     (* 'a list, any other type can be consed onto it. *)
[1,2];  (* int list *)


(* list functions *)

fun sum_list (xs : int list) =
  if null xs then 0
  else hd(xs) + sum_list(tl xs);

fun countdown(x : int) = 
  if x = 0 then []
  else x :: countdown(x - 1);

fun append(xs : int list, ys : int list) =
  if null xs then ys
  else hd(xs) :: append(tl(xs), ys);

(* let expressions *)

fun silly (z : int) = 
  let 
    val x = if z > 0 then z else 34
    val y = x + z + 9
  in
    if x > y then x * 2 else y * y
  end;

(* nested functions *)

fun count (from : int, to : int) = 
  if from = to
  then to :: []
  else from :: count(from + 1, to)

fun countup(x : int) = count(1,x)

(* or *)

fun countup(x : int) = 
  let
    fun count (from : int) = 
      if from = x
      then x :: []
      else from :: count(from + 1)
  in
    count(1)
  end;

(* options *)

NONE;   (* a' option *) 
SOME 1; (* int option *)

isSome(NONE);   (* -> false *)
isSome(SOME 1); (* -> true *) 
valOf(SOME 1);  (* 1 *)
valOf(NONE);    (* exception *)

fun max(xs : int list) =
  if null xs then NONE
  else
    let val tl_ans = max(tl xs)
    in
      if isSome tl_ans andalso valof tl_ans > hd xs
      then tl_ans
      else SOME (hd xs)
    end
