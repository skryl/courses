(* Homework2 Simple Test *)
(* These are basic test cases. Passing these tests does not guarantee that your code will pass the actual homework grader *)
(* To run the test, add a new line to the top of this file: use "homeworkname.sml"; *)
(* All the tests should evaluate to true. For example, the REPL should say: val test1 = true : bool *)

val test1 = all_except_option("string", ["string"]) = SOME [];

val test2 = get_substitutions1([["foo"],["there"]], "foo") = [];

val test3 = get_substitutions2([["foo"],["there"]], "foo") = [];

(* fail *)
val test4 = similar_names([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]], 
                          {first="Fred", middle="W", last="Smith"}) =
	    [{first="Fred", last="Smith", middle="W"}, {first="Fredrick", last="Smith", middle="W"},
	     {first="Freddie", last="Smith", middle="W"}, {first="F", last="Smith", middle="W"}];

val test5 = card_color((Clubs, Num 2)) = Black;

val test6 = card_value((Clubs, Num 2)) = 2;

val test7 = remove_card([(Hearts, Ace)], (Hearts, Ace), IllegalMove) = [];

val test8 = all_same_color([(Hearts, Ace), (Hearts, Ace)]) = true;

val test9 = sum_cards([(Clubs, Num 2),(Clubs, Num 2)]) = 4;

val test10 = score([(Hearts, Num 2),(Clubs, Num 4)],10) = 4;

val test11 = officiate([(Hearts, Num 2),(Clubs, Num 4)],[Draw], 15) = 6;

val test12 = officiate([(Clubs,Ace),(Spades,Ace),(Clubs,Ace),(Spades,Ace)],
                       [Draw,Draw,Draw,Draw,Draw],
                       42)
             = 3;

val test13 = ((officiate([(Clubs,Jack),(Spades,Num(8))],
                         [Draw,Discard(Hearts,Jack)],
                         42);
               false) 
              handle IllegalMove => true);
             
(* challenge 1 *)             

val cards = [(Diamonds, Ace), (Hearts, Jack), (Diamonds, Queen), (Spades, Ace), (Clubs, Num 4), (Spades, Num 9), (Hearts, Ace), (Clubs, Ace)];
remove_and_count_aces(cards) = ([(Hearts, Jack), (Diamonds, Queen), (Clubs, Num 4), (Spades, Num 9)], 4);

opt_ace_sum(1, 8) = 1;
opt_ace_sum(1, 9) = 11;
opt_ace_sum(1, 10) = 11;
opt_ace_sum(1, 11) = 11;
opt_ace_sum(1, 12) = 11;
opt_ace_sum(2, 8) = 2;
opt_ace_sum(2, 9) = 2;
opt_ace_sum(2, 10) = 12;
opt_ace_sum(2, 11) = 12;
opt_ace_sum(2, 12) = 12;
opt_ace_sum(2, 13) = 12;
opt_ace_sum(2, 19) = 12;
opt_ace_sum(2, 20) = 22;
opt_ace_sum(2, 21) = 22;
opt_ace_sum(2, 22) = 22;
opt_ace_sum(2, 23) = 22;
opt_ace_sum(3, 19) = 13;
opt_ace_sum(3, 20) = 13;
opt_ace_sum(3, 21) = 23;
opt_ace_sum(3, 22) = 23;
opt_ace_sum(3, 23) = 23;
opt_ace_sum(15, 10) = 15;
opt_ace_sum(10, 12) = 10;

opt_card_sum(cards, 33) = 37;
opt_card_sum(cards, 44) = 37;
opt_card_sum(cards, 45) = 47;
opt_card_sum(cards, 46) = 47;

score_challenge(cards, 33) = 12;
score_challenge(cards, 44) = 7;
score_challenge(cards, 45) = 6;
score_challenge(cards, 46) = 3;
score_challenge(cards, 47) = 0;
score_challenge(cards, 48) = 1;

val deck = [(Clubs, Num 4), (Hearts, Queen), (Hearts, Num 10), (Diamonds, Num 2),
            (Diamonds, Ace), (Hearts, Jack), (Diamonds, Queen), (Spades, Ace), 
            (Diamonds, Num 9), (Diamonds, Num 3), (Diamonds, Num 4), (Clubs, Num 3),
            (Clubs, Num 4), (Spades, Num 9), (Hearts, Ace), (Clubs, Ace),
            (Diamonds, Num 5), (Diamonds, Num 10), (Spades, Num 4), (Spades, Num 5)];

val moves = [Draw, Draw, Draw, Draw, 
             Discard (Clubs, Num 4), Discard (Hearts, Queen), 
             Discard (Hearts, Num 10), Discard (Diamonds, Num 2), 
             Draw, Draw, Draw, Draw, 
             Draw, Draw, Draw, Draw, 
             Discard (Diamonds, Num 9), Discard (Diamonds, Num 3), 
             Discard (Diamonds, Num 4), Discard (Clubs, Num 3),
             Draw, Draw, Draw, Draw, 
             Draw, Draw, Draw, Draw, 
             Discard (Diamonds, Num 5), Discard (Diamonds, Num 10), 
             Discard (Spades, Num 4), Discard (Spades, Num 5)];

officiate_challenge(deck, moves, 67) = 0;
officiate_challenge(deck, moves, 74) = 7;
officiate_challenge(deck, moves, 75) = 6;
officiate_challenge(deck, moves, 76) = 3;
officiate_challenge(deck, moves, 77) = 0;
officiate_challenge(deck, moves, 78) = 1;
officiate_challenge(deck, moves, 79) = 2;

val deck = [(Spades,Num 7),(Hearts,King),(Clubs,Ace),(Diamonds,Num 2)];
careful_player(deck, 18);
