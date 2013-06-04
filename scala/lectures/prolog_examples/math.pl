count(0, []).
count(Count, [H|T]) :- count(TCount, T), Count is TCount + 1.
 
sum(0, []).
sum(Sum, [H|T]) :- sum(TSum, T), Sum is TSum + H.

average(Average, List) :- sum(Sum, List), count(Count, List), Average is Sum/Count.

concat([], Y, Y).
concat([H|T1], List, [H|T2]) :- concat(T1, List, T2).

fact(0, 1).
fact(X, Y) :- X > 0, X1 is X - 1, fact(X1, YRest), Y is X * YRest.

fib(N, 1) :- N < 3.
fib(N, F) :- N > 2, fib(N - 1, F1), fib(N - 2, F2), F is F1 + F2.
