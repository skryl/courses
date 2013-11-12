(* Homework3 Simple Test*)
(* These are basic test cases. Passing these tests does not guarantee that your code will pass the actual homework grader *)
(* To run the test, add a new line to the top of this file: use "homeworkname.sml"; *)
(* All the tests should evaluate to true. For example, the REPL should say: val test1 = true : bool *)

val test1 = only_capitals ["A","B","C"] = ["A","B","C"];
val test1a = only_capitals ["A","b","C","d","E"] = ["A","C","E"];

val test2 = longest_string1 ["A","bc","C"] = "bc";
val test2a = longest_string1 ["A","bc","Cdef","hi","hell"] = "Cdef";
val test2b = longest_string1 ["A","bc","Cdef","hi","hello","hey"] = "hello";

val test3 = longest_string2 ["A","bc","C"] = "bc"
val test3a = longest_string2 ["A","bc","Cdef","hi","hell"] = "hell";
val test3b = longest_string2 ["A","bc","Cdef","hi","hello","hey"] = "hello";

val test4a= longest_string3 ["A","B","C"] = "A";

val test4b= longest_string4 ["A","B","C"] = "C";

val test5 = longest_capitalized ["A","bc","C"] = "A";
val test5a = longest_capitalized ["a","bc","d"] = "";
val test5b = longest_capitalized ["a","Bc","d","Efg","h","Ij"] = "Efg";

val test6 = rev_string "abc" = "cba";

val test7 = first_answer (fn x => if x > 3 then SOME x else NONE) [1,2,3,4,5] = 4;
val test7a = first_answer (fn x => if x < 3 then SOME x else NONE) [1,2,3,4,5] = 1;

val test8 = all_answers (fn x => if x = 1 then SOME [x] else NONE) [2,3,4,5,6,7] = NONE;
val test8a = all_answers (fn x => if x = 1 then SOME [x] else NONE) [1,1] = SOME [1,1];

val test9a = count_wildcards Wildcard = 1;
val test9a1 = count_wildcards (Variable "x") = 0;
val test9a2 = count_wildcards (TupleP [Wildcard, Wildcard]) = 2;
val test9a3 = count_wildcards (TupleP [Wildcard, Variable "x", ConstructorP("Cons", Wildcard)]) = 2;

val test9b1 = count_wild_and_variable_lengths (Variable("a")) = 1;
val test9b2 = count_wild_and_variable_lengths (TupleP [Wildcard, Variable "x", ConstructorP("Cons", Variable "xyz")]) = 5;

val test9c = count_some_var ("x", Variable("x")) = 1;
val test9b2 = count_some_var ("x", (TupleP [Wildcard, Variable "x", ConstructorP("Cons", Variable "x")])) = 2;

val test10 = check_pat (Variable("x")) = true;
val test10a = check_pat (TupleP [Wildcard, Variable "x", ConstructorP("Cons", Variable "x")]) = false;
val test10a = check_pat (TupleP [Wildcard, Variable "x", ConstructorP("Cons", Variable "y]")]) = true;

val test11 = match (Const(1), UnitP) = NONE;
val test11a = match (Unit, Wildcard) = SOME [];
val test11b = match (Const 1, Wildcard) = SOME [];
val test11c = match (Tuple [], Wildcard) = SOME [];
val test11d = match (Constructor("c", Const 1), Wildcard) = SOME [];

val test11e = match (Unit, Variable "v") = SOME [("v", Unit)];
val test11f = match (Const 1, Variable "v") = SOME [("v", Const 1)];
val test11g = match (Tuple [], Variable "v") = SOME [("v", Tuple [])];
val test11h = match (Constructor("c", Const 1), Variable "v") = SOME [("v", Constructor("c", Const 1))];

val test11i = match (Unit, UnitP) = SOME [];
val test11j = match (Const 1, UnitP) = NONE;

val test11k = match (Const 1, ConstP 1) = SOME [];
val test11l = match (Const 2, ConstP 1) = NONE;
val test11m = match (Tuple [], ConstP 1) = NONE;

val test11n = match (Tuple [], TupleP []) = SOME []; 
val test11o = match (Const 1, TupleP []) = NONE;
val test11o = match (Tuple [Const 1], TupleP []) = NONE;
val test11p = match (Tuple [Const 1], TupleP [ConstP 1]) = SOME []; 
val test11p = match (Tuple [Const 1], TupleP [Variable "a"]) = SOME [("a", Const 1)]; 
val test11q = match (Tuple [Const 1], TupleP [UnitP]) = NONE; 
val test11r = match (Tuple [Const 1, Const 2], TupleP [Variable "a", Variable "b"]) = SOME [("b", Const 2),("a", Const 1)]; 

val test11s = match (Constructor ("a", Const 1), ConstructorP ("a", ConstP 1)) = SOME []; 
val test11t = match (Constructor ("a", Const 1), ConstructorP ("b", ConstP 1)) = NONE;
val test11u = match (Constructor ("a", Const 1), ConstructorP ("a", Variable "x")) = SOME [("x", Const 1)];
val test11v = match (Constructor ("a", Tuple [Const 1, Const 2]), ConstructorP ("a", TupleP [Variable "a", Variable "b"])) = SOME [("b", Const 2),("a", Const 1)];

val test12 = first_match Unit [UnitP] = SOME [];
val test12a = first_match (Tuple [Const 1, Const 2]) 
  [UnitP, ConstP 1, TupleP [], TupleP [Wildcard, Wildcard], TupleP [Variable "a", Variable "b"]] = SOME [];
val test12b = first_match (Tuple [Const 1, Const 2]) 
  [UnitP, ConstP 1, TupleP [], TupleP [Variable "a", Variable "b"]] = SOME [("b", Const 2), ("a", Const 1)];

