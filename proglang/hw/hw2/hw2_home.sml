(* Homework 2 *)

fun same_string(s1 : string, s2 : string) = s1 = s2;

(* --------------------------------------------------------------------------------- *)

fun all_except_option(s : string, lst : string list) = case lst of 
    []    => NONE 
  | x::xs => 
      if same_string(s,x) then SOME xs 
      else case all_except_option(s,xs) of 
           NONE => NONE 
         | SOME(xs) => SOME(x :: xs);

(* --------------------------------------------------------------------------------- *)

fun get_substitutions1(subs : string list list, name : string) = case subs of
    [] => [] 
  | sub_lst :: rest => case all_except_option(name, sub_lst) of
      NONE => get_substitutions1(rest, name)
    | SOME(lst) => lst @ get_substitutions1(rest, name);

(* --------------------------------------------------------------------------------- *)

fun get_substitutions2(subs : string list list, name : string) = 
  let
    fun get_subs_tr(subs, name, aliases) =  
      case subs of
        [] => aliases 
      | sub_lst :: rest => case all_except_option(name, sub_lst) of
          NONE => get_subs_tr(rest, name, aliases)
        | SOME(lst) => get_subs_tr(rest, name, lst @ aliases);
  in 
    get_subs_tr(subs,name,[])
  end;

(* --------------------------------------------------------------------------------- *)

fun similar_names(subs : string list list, full_name) = case full_name of
  {first=f,middle=m,last=l} => 
    let
      val aliases = f :: get_substitutions2(subs, f)
      fun gen_names(names : string list) = case names of
          [] => []
        | x :: xs => {first=x, middle=m, last=l} :: gen_names(xs)
    in
      gen_names(aliases)
    end;

(* --------------------------------------------------------------------------------- *)

datatype suit = Clubs | Diamonds | Hearts | Spades;
datatype rank = Jack | Queen | King | Ace | Num of int;
type card = suit * rank;

datatype color = Red | Black;
datatype move = Discard of card | Draw; 

exception IllegalMove;

(* --------------------------------------------------------------------------------- *)

fun card_color(card : card) : color = case card of
    ((Clubs, _) | (Spades, _))   => Black
  | _                            => Red;

(* --------------------------------------------------------------------------------- *)

fun card_value(card : card) = case card of
    (_, Num n)    => n
  | (_, Ace)      => 11
  | _             => 10;

(* --------------------------------------------------------------------------------- *)

fun remove_card(cs : card list, c : card, e) = case cs of
    []    => raise e
  | x::xs => 
      if c = x then xs 
      else case remove_card(xs,c,e) of xs => x :: xs;

(* --------------------------------------------------------------------------------- *)

fun all_same_color(cs : card list) = case cs of
    [] => true
  | x :: [] => true
  | x :: y :: xs => card_color(x) = card_color(y) andalso all_same_color(y :: xs);

(* --------------------------------------------------------------------------------- *)

fun sum_cards(cs : card list) =
  let
    fun sum_all(cs : card list, sum : int) = case cs of
      [] => sum
    | x :: xs => sum_all(xs, sum + card_value(x))
  in
    sum_all(cs, 0)
  end;

(* --------------------------------------------------------------------------------- *)

fun score(cs : card list, goal : int) =
  let
    val card_sum = sum_cards(cs)
    val prelim_score = if card_sum < goal 
      then goal - card_sum
      else 3 * (card_sum - goal)
  in
    if all_same_color(cs) 
    then prelim_score div 2 
    else prelim_score
  end;

(* --------------------------------------------------------------------------------- *)

fun officiate(deck : card list, moves : move list, goal : int) =
  let
    fun run_game(deck_cs, player_cs, moves) = case moves of
        [] => score(player_cs, goal)
      | m :: ms => (case m of
          Draw => (case deck_cs of
              [] => score(player_cs, goal)
            | c :: cs => 
                if sum_cards(c :: player_cs) > goal
                then score(c :: player_cs, goal)
                else run_game(cs, c :: player_cs, ms)) 
        | Discard c => 
            run_game(deck_cs, remove_card(player_cs, c, IllegalMove), ms))
  in
    run_game(deck, [], moves)
  end;  

(* --------------------------------------------------------------------------------- *)
