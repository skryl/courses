#lang racket

; opens included modules, makes testing easier 
(provide (all-defined-out))

; basic definitions
(define s "hello")

(define x 3) ; val x = 3
(define y (+ 2 x))

(define cube1
  (lambda (x) 
    (* x (* x x)) ))

; * takes any number of args
(define cube2
  (lambda (x)
    (* x x x) ))

; syntactic sugar for function define
(define (cube3 x)
  (* x x x))

; x to the yth
(define (pow1 x y)
  (if (= y 0)
    1
    (* x (pow1 x (- y 1))) ))

(pow1 2 3)

; curried version (not as common)
(define pow2
  (lambda (x)
    (lambda (y)
      (pow1 x y)) ))

; nice for partial application
(define three-to-the (pow2 3))

; ehh
((pow2 4) 5)

; Lists

; empty list: null
; cons constructor: cons
; head of list: car
; tail of list: cdr
; check for empty: null?
; () doesn't work for null, '() does
; (list e1 ... en) for building lists

; sum all nums in list
(define (sum xs)
  (if (null? xs)
    0
    (+ (car xs) (sum (cdr xs))) ))

(sum (list 3 4 5 6))

(define (my-append xs ys)
  (if (null? xs)
    ys
    (cons (car xs) (my-append (cdr xs) ys)) ))

(define (my-map f xs)
  (if (null? xs)
    '()
    (cons (f (car xs)) (my-map f (cdr xs))) ))

; Racket syntax

; A term is either
; - an atom, #t, #f, 34, "hi", null, 4.0,x ...
; - a special form, define, lambda, if
;   - macros will let us define our own
; - A sequence of terms in parens: (t1 t2 ... tn)
; - if t1 is a special form, semantics of sequence is special
; - else a function call
; can use [ instead of ( anywhere

(+ 3 (car xs))
(lambda (x) (if x "hi" #t))

; Why are parens good?
; - converting to a tree is trivial
;   - atoms are leaves
;   - sequences are nodes with elements as children

(define (fact n) (if (= n 0) 1 (* n (fact (- n 1)))))

; Dynamic Typing

; can't do this in ML without defining a recursive type
(define (sum_deep xs)
  (if (null? xs) 
    0
    (if (list? (car xs))
      (+ (sum_deep (car xs)) (sum_deep (cdr xs)))
      (+ (car xs) (sum_deep (cdr xs))) )))

(sum_deep (list 1 2 (list 3 4) 5))

; skip invalid elements
(define (sum_deep xs)
  (if (null? xs) 
    0
    (if (list? (car xs))
      (+ (sum_deep (car xs)) (sum_deep (cdr xs)))
      (if (number? (car xs))
        (+ (car xs) (sum_deep (cdr xs))) 
        (sum_deep (cdr xs)) ))))

(sum_deep (list 1 "hi" (list 3 4) #f))

; Cond

(define (sum_deep xs)
  (cond [(null? xs) 0]
        [(number? (car xs)) (+ (car xs) (sum_deep (cdr xs)))]
        [#t (+ (sum_deep (car xs)) (sum_deep (cdr xs)))]))

; all but #f is truthy

(if 34 14 15)
(if #f 14 15)

; local bindings

(define (max-of-list xs)
  (cond [(null? xs) (error "max-of-list given empty list")]
        [(null? (cdr xs)) (car xs)]
        [#t (let ([tlans (max-of-list (cdr xs))])
                  (if (> tlans (car xs))
                    tlans
                    (car xs)))]))

; let syntax, e1 and e2 are evaled in env before let exp! Not how ML works!

(let ([v1 e1]
      [v2 e2])
        body)

(define (silly-double x)
  (let ([x (+ x 3)]
        [y (+ x 2)])
    (+ x y -5)))

; let* syntax, this IS how ML works, Clojure's let works this way also.

(define (silly-double x)
  (let* ([x (+ x 3)]
        [y (+ x 2)])
    (+ x y -8)))

; letrec syntax, like ML's 'and' for mutual recursion, all let bindings are
; defined ahead of time

(define (silly-triple x)
  (letrec ([y (+ x 2)]
           [f (lambda(z) (+ z y w x))]
           [w (+ x 7)])
        (f -9)))

; careful, not to reference undefined vars using letrec

(define (bad-letrec x)
  (letrec ([y z]
           [z 13])
    (if x y z) ))

; local define semantics are the same as letrec

(define (silly-triple x)
  (define y (+ x 2))
  (define f (lambda(z) (+ z y w x)))
  (define w (+ x 7))
        (f -9))

; Top Level Bindings work like letrec, bindings can refer to later bindings,
; unlike ML. This means, cannot shadow

(define (f x) (+ x (* x b)))
(define b 3)
(define c (+ b 4))
(define d (+ e 4)) ; ERROR!
(define f 17) ; ERROR! f already defined

; REPL works differently, try not to define own recursive functions

; Mutation

(set! x e)

; sequencing of side effects

(begin e1 e2 ... en)

; Cons, it actually just makes pairs, lists are nested pair with a null terminator
; Without static types, why distinguish between the two?
;  - propper lists used for collections of unknown size
;  - use cons to build pairs when length of list is small and known

; not a list
(define pr (cons 1 (cons #t "hi")))

; a list
(define lst (cons 1 (cons #t (cons "hi" null))))

(list? pr) ; #f
(pair? pr) ; #t
(list? lst) ; #t
(pair? lst) ; #t
(list? '()) ; #t
(pair? '()) ; #f

(length lst)
(length pr) ; ERROR!

; mutable cons cells, can't mutate regular cons cells, different from scheme!
; - list aliasing is irrelevant
; - makes list? cells since it can be computed at creation.

(define mpr (mcons 1 (mcons #t "hi")))
(car mpr)  ; ERROR!
(mcar mpr) 
(mcdr mpr) 

(set-mcdr! mpr 47)
mpr

(mpair? mpr)
(length (mcons 1 (mcons 2 null))) ; ERROR!


; Delayed Evaluation

(define (my-if-bad e1 e2 e3)
  (if e1 e2 e3))

; never terminates
(define (factorial-bad x)
  (my-if-bad (= x 0)
             1 
             (* x (factorial-bad (- x 1)))))

; delay evaluation by using Thunks (zero argument functions for delaying evaluation)

(define (my-if-delayed e1 e2 e3)
  (if e1 (e2) (e3)))

(define (factorial-ok x)
  (my-if-delayed (= x 0)
                 (lambda () 1) 
                 (lambda () (* x (factorial-ok (- x 1))))))

; lazy evaluation, delay/force, promises

(define (my-delay th)
  (mcons #f th))

(define (my-force p)
  (if (mcar p)
      (mcdr p)
      (begin (set-mcar! p #t)
             (set-mcdr! p ((mcdr p)))
             (mcdr p))))

; using promises

(define (my-mult x y-thunk)
  (cond [(= x 0) 0]
        [(= x 1) (y-thunk)]
        [#t (+ (y-thunk) (my-mult (- x 1) y-thunk))] ))

(my-mult 10 (let ([x (my-delay (lambda () (slow-add 3 4)))])
            (lambda () (my-force x))))

; Streams, thunks that evaluate to pairs

'(next-answer . next-thunk)

(powers-of-two)

(car (powers-of-two))

(car ((cdr (powers-of-two))))

(define (number-until stream tester)
  (letrec ([f (lambda (stream ans)
                (let ([pr (stream)])
                  (if (tester (car pr))
                    ans
                    (f (cdr pr) (+ ans 1)))))])
    (f stream 1)))

; 1 1 1 1 1...

(define ones (lambda () (cons 1 ones)))

(car (ones))

(car ((cdr (ones))))

; 1 2 3 4 5

(define (f x) (cons x (lambda () (f (+ x 1)))))

(define nats (lambda () (f 1)))

(car ((cdr (nats))))

; 2 4 8 16...

(define (f x) (cons x (lambda () (f (* x 2)))))

(define powers-of-two (lambda () (f 1)))

; Memoization, beneficial if maintaining and computing a cache is cheaper than
; re-computing the results

(fibonacci1 x)
  (if (or (= x 1) (= x 2))
    1
    (+ (fibonacci1 (- x 1))
       (fibonacci1 (- x 2)))))

; could go bottom up

(define (fibonacci2 x)
  (letrec ([f (lambda (acc1 acc2 y)
                (if (= y x)
                  (+ acc1 acc2)
                  (f (+ acc1 acc2) acc1 (+ y 1))))])
    (if (or (= x 1) (= x 2))
            1
            (f 1 1 3))))

; or memoize the top down version

(define fibonacci3
  (letrec([memo null] 
          [f (lambda (x)
               (let ([ans (assoc x memo)])                                                                              
                 (if ans 
                     (cdr ans)
                     (let ([new-ans (if (or (= x 1) (= x 2))
                                        1
                                        (+ (f (- x 1))
                                           (f (- x 2))))])
                       (begin 
                         (set! memo (cons (cons x new-ans) memo))
                         new-ans)))))])
    f))

; Macros, expansion happens before type checking and evaluation, basically a code pre-pass
; - hygienic
;   1. secretly renames local variables in macros with fresh names
;   2. looks up vars used in macros where the macro is defined

; syntax-rules specifies other tokens
;
(define-syntax my-if
  (syntax-rules (then else)
    [(my-if e1 then e2 else e3)
     (if e1 e2 e3)]))

; make it easier to tunk expressions
;
(define-syntax my-delay
  (syntax-rules ()
    [(my-delay e)
     (mcons #f (lambda() e))]))

; a for loop
;
(define-syntax for
  (syntax-rules (to do)
    [(for lo to hi do body)
     (let ([l lo] [h hi])
        (letrec ([loop (lambda (it)
                         (if (> it h)
                            #t
                            (begin body (loop (+ it 1)))))])
          (loop l)))]))

(for 7 to 11 do (print "hi"))

; a better let
;
(define-syntax let2
  (syntax-rules ()
    [(let2 () body) body]
    [(let2 (var val) body) (let ([var val]) body)]
    [(let2 (var1 val1 var2 val2) body) (let ([var1 val1]) (let ([var2 val2]) body))] ))

(let2 (x 1 y 2) (+ x y))

; recursive macros
;
(define-syntax my-let*
  (syntax-rules ()
    [(my-let* () body) body]
    [(my-let* ([var0 val0] [var-rest val-rest] ...) body)
     (let ([var0 val0])
       (my-let* ([var-rest val-rest] ...) body))]))

(my-let* ([x 1] [y (+ x 1)] [z (+ y 1)]) (+ x y z))
