(* Homework 2 *)

(* --------------------------------------------------------------------------------- *)

(* 1. This problem involves using rst-name substitutions to come up with alternate names. For example,
      Fredrick William Smith could also be Fred William Smith or Freddie William Smith. Only part (d) is
      specically about this, but the other problems are helpful. *)

fun same_string(s1 : string, s2 : string) = s1 = s2;

(* --------------------------------------------------------------------------------- *)

(* a. Write a function all_except_option, which takes a string and a string list. Return NONE if the
      string is not in the list, else return SOME lst where lst is identical to the argument list except the string
      is not in it. You may assume the string is in the list at most once. Use same_string, provided to you,
      to compare strings. Sample solution is around 8 lines. *)

fun all_except_option(s : string, lst : string list) = case lst of 
    []    => NONE 
  | x::xs => 
      if same_string(s,x) then SOME xs 
      else case all_except_option(s,xs) of 
           NONE => NONE 
         | SOME(xs) => SOME(x :: xs);

(* --------------------------------------------------------------------------------- *)

(* b. Write a function get_substitutions1, which takes a string list list (a list of list of strings, the
      substitutions) and a string s and returns a string list. The result has all the strings that are in
      some list in substitutions that also has s, but s itself should not be in the result. Example:

        get_substitutions1([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]], "Fred")
        (* answer: ["Fredrick","Freddie","F"] *)

      Assume each list in substitutions has no repeats. The result will have repeats if s and another string are
      both in more than one list in substitutions. Example:

        get_substitutions1([["Fred","Fredrick"],["Jeff","Jeffrey"],["Geoff","Jeff","Jeffrey"]], "Jeff")
        (* answer: ["Jeffrey","Geoff","Jeffrey"] *)

      Use part (a) and ML's list-append (@) but no other helper functions. Sample solution is around 6 lines. *)

fun get_substitutions1(subs : string list list, name : string) = case subs of
    [] => [] 
  | sub_lst :: rest => case all_except_option(name, sub_lst) of
      NONE => get_substitutions1(rest, name)
    | SOME(lst) => lst @ get_substitutions1(rest, name);

(* --------------------------------------------------------------------------------- *)

(* c. Write a function get_substitutions2, which is like get_substitutions1 except it uses a tail-recursive
      local helper function.

        get_substitutions2([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]], "Fred")
        (* answer: ["Fredrick","Freddie","F"] *)

        get_substitutions2([["Fred","Fredrick"],["Jeff","Jeffrey"],["Geoff","Jeff","Jeffrey"]], "Jeff")
        (* answer: ["Jeffrey","Geoff","Jeffrey"] *) *)

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

(* d. Write a function similar_names, which takes a string list list of substitutions (as in parts (b) and
     (c)) and a full name of type {first:string,middle:string,last:string} and returns a list of full
     names (type {first:string,middle:string,last:string} list). The result is all the full names you
     can produce by substituting for the rst name (and only the rst name) using substitutions and parts (b)
     or (c). The answer should begin with the original name (then have 0 or more other names). Example:

       similar_names([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]], {first="Fred", middle="W", last="Smith"})

       (* answer: [{first="Fred", last="Smith", middle="W"},
                   {first="Fredrick", last="Smith", middle="W"},
                   {first="Freddie", last="Smith", middle="W"},
                   {first="F", last="Smith", middle="W"}] *)

     Do not eliminate duplicates from the answer. Hint: Use a local helper function. Sample solution is
     around 10 lines. *)

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

(* 2. This problem involves a solitaire card game invented just for this question. You will write a program that
      tracks the progress of a game; writing a game player is a challenge problem. You can do parts (a){(e) before
      understanding the game if you wish.

      A game is played with a card-list and a goal. The player has a list of held-cards, initially empty. The player
      makes a move by either drawing, which means removing the rst card in the card-list from the card-list and
      adding it to the held-cards, or discarding, which means choosing one of the held-cards to remove. The game
      ends either when the player chooses to make no more moves or when the sum of the values of the held-cards
      is greater than the goal. *)

datatype suit = Clubs | Diamonds | Hearts | Spades;
datatype rank = Jack | Queen | King | Ace | Num of int;
type card = suit * rank;

datatype color = Red | Black;
datatype move = Discard of card | Draw; 

exception IllegalMove;

(* --------------------------------------------------------------------------------- *)

(* a. Write a function card_color, which takes a card and returns its color (spades and clubs are black,
      diamonds and hearts are red). Note: One case-expression is enough. *)

fun card_color(card : card) : color = case card of
    ((Clubs, _) | (Spades, _))   => Black
  | _                            => Red;

(* --------------------------------------------------------------------------------- *)

(* b. Write a function card_value, which takes a card and returns its value (numbered cards have their
      number as the value, aces are 11, everything else is 10). Note: One case-expression is enough. *)

fun card_value(card : card) = case card of
    (_, Num n)    => n
  | (_, Ace)      => 11
  | _             => 10;

(* --------------------------------------------------------------------------------- *)

(* c. Write a function remove_card, which takes a list of cards cs, a card c, and an exception e. It returns a
      list that has all the elements of cs except c. If c is in the list more than once, remove only the rst one.
      If c is not in the list, raise the exception e. You can compare cards with =. *)

fun remove_card(cs : card list, c : card, e) = case cs of
    []    => raise e
  | x::xs => 
      if c = x then xs 
      else case remove_card(xs,c,e) of xs => x :: xs;

(* --------------------------------------------------------------------------------- *)

(* d. Write a function all_same_color, which takes a list of cards and returns true if all the cards in the
      list are the same color. Hint: An elegant solution is very similar to one of the functions using nested
      pattern-matching in the lectures. *)

fun all_same_color(cs : card list) = case cs of
    [] => true
  | x :: [] => true
  | x :: y :: xs => card_color(x) = card_color(y) andalso all_same_color(y :: xs);

(* --------------------------------------------------------------------------------- *)

(* e. Write a function sum_cards, which takes a list of cards and returns the sum of their values. Use a locally
      defined helper function that is tail recursive. *)

fun sum_cards(cs : card list) =
  let
    fun sum_all(cs : card list, sum : int) = case cs of
      [] => sum
    | x :: xs => sum_all(xs, sum + card_value(x))
  in
    sum_all(cs, 0)
  end;

(* --------------------------------------------------------------------------------- *)

(* f. Write a function score, which takes a card list (the held-cards) and an int (the goal) and computes
the score as described above. *)

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

(* g. Write a function officiate, which \runs a game." It takes a card list (the card-list) a move list
      (what the player \does" at each point), and an int (the goal) and returns the score at the end of the
      game after processing (some or all of) the moves in the move list in order. Use a locally dened recursive
      helper function that takes several arguments that together represent the current state of the game. As
      described above:

        * The game starts with the held-cards being the empty list.
        * The game ends if there are no more moves. (The player chose to stop since the move list is empty.)
        * If the player discards some card c, play continues (i.e., make a recursive call) with the held-cards
          not having c and the card-list unchanged. If c is not in the held-cards, raise the IllegalMove
          exception.
        * If the player draws and the card-list is (already) empty, the game is over. Else if drawing causes
          the sum of the held-cards to exceed the goal, the game is over (after drawing). Else play continues
          with a larger held-cards and a smaller card-list.

      Sample solution for (g) is under 20 lines. *)

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

(* 3. Challenge Problems *)

(* a. Write score_challenge and officiate_challenge to be like their non-challenge counterparts except
      each ace can have a value of 1 or 11 and score_challenge should always return the least (i.e., best)
      possible score. (Note the game-ends-if-sum-exceeds-goal rule should apply only if there is no sum that
      is less than the goal.) Hint: This is easier than you might think. *)

fun remove_and_count_aces(cards : card list) = case cards of
    [] => ([], 0)
  | c :: cs => 
       let val (cards, count) = remove_and_count_aces(cs)
       in case c of
          (_, Ace) => (cards, 1 + count)
        | _        => (c :: cards, count)
       end;

(* finds the optimal sum of all aces given the distance to the goal *)

fun opt_ace_sum(num_aces : int, to_goal : int) =
  if num_aces = 0 then 0
  else if (num_aces * 11) <= to_goal + 2
    then 11 + opt_ace_sum(num_aces-1, to_goal-11)
    else 1  + opt_ace_sum(num_aces-1, to_goal-1);

(* finds the optimal hand value and can be used to get the minimum hand value
   if the score parameter is negative *)

fun opt_card_sum(cards : card list, goal : int) =
  let
    val (cards_no_aces, ace_count) = remove_and_count_aces(cards) 
    val sum_no_aces = sum_cards(cards_no_aces)
  in
    if sum_no_aces < goal 
    then sum_no_aces + opt_ace_sum(ace_count, goal - sum_no_aces)
    else sum_no_aces + ace_count
  end;

(* dentical to score(), except uses opt_card_sum to sum the cards *)

fun score_challenge(cards : card list, goal : int) =
  let
    val card_sum = opt_card_sum(cards, goal)
    val prelim_score = if card_sum < goal 
      then goal - card_sum
      else 3 * (card_sum - goal)
  in
    if all_same_color(cards) 
    then prelim_score div 2 
    else prelim_score
  end;

(* dentical to officiate(), except uses score_challenge to get the score *)

fun officiate_challenge(deck : card list, moves : move list, goal : int) =
  let
    fun run_game(deck_cs, player_cs, moves) = case moves of
        [] => score_challenge(player_cs, goal)
      | m :: ms => (case m of
          Draw => (case deck_cs of
              [] => score_challenge(player_cs, goal)
            | c :: cs => 
                if opt_card_sum(c :: player_cs, ~1) > goal
                then score_challenge(c :: player_cs, goal)
                else run_game(cs, c :: player_cs, ms)) 
        | Discard c => 
            run_game(deck_cs, remove_card(player_cs, c, IllegalMove), ms))
  in
    run_game(deck, [], moves)
  end;  

(* --------------------------------------------------------------------------------- *)

(* b. Write careful_player, which takes a card-list and a goal and returns a move-list such that calling
      officiate with the card-list, the goal, and the move-list has this behavior:

       * The value of the held cards never exceeds the goal.
       * A card is drawn whenever the goal is more than 10 greater than the value of the held cards.
       * If a score of 0 is reached, there must be no more moves.
       * If it is possible to discard one card, then draw one card to produce a score of 0, then this must be
         done. (Note careful_player will have to look ahead to the next card, which in many card games
         is considered \cheating.") *)

fun can_discard(hand : card list, value : int) = case hand of
    [] => NONE
  | c :: cs => if card_value(c) = value 
               then SOME c 
               else can_discard(cs, value); 
            
fun careful_player(deck : card list, goal : int) : move list = 
  let
    fun choose_cards(deck : card list, hand : card list) = case deck of
        [] => []
      | c :: cs => let
            val cur_score = score(hand, goal)
            val cur_value = sum_cards(hand)
            val (ratio, remain) = if cur_value = 0 then (11,0) 
                                  else (goal div cur_value, goal mod cur_value)
          in 
            if cur_score = 0 then []
            else if cur_value > goal then []
            else if (ratio > 10 orelse (ratio = 10 andalso remain > 0))
              then Draw :: choose_cards(cs, c :: hand)
            else (case can_discard(c :: hand, sum_cards(c :: hand) - goal) of
                NONE    => [] 
              | SOME(d) => Discard d :: choose_cards(cs, c :: hand)) 
          end
  in
    choose_cards(deck, [])
  end;

(* --------------------------------------------------------------------------------- *)
