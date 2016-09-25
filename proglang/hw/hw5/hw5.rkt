#lang racket

(provide (all-defined-out)) ;; so we can put tests in a second file

; Overview: This homework has to do with mupl (a Made Up Programming Language). mupl programs
; are written directly in Racket by using the constructors defined by the structs defined at the beginning of
; hw5.rkt. This is the definition of mupl's syntax:
;
;  - If s is a Racket string, then (var s) is a mupl expression (a variable use).
;  - If n is a Racket integer, then (int n) is a mupl expression (a constant).
;  - If e1 and e2 are mupl expressions, then (add e1 e2) is a mupl expression (an addition).
;  - If s1 and s2 are Racket strings and e is a mupl expression, then (fun s1 s2 e) is a mupl expression (a
;    function). In e, s1 is bound to the function itself (for recursion) and s2 is bound to the (one) argument.
;    Also, (fun #f s2 e) is allowed for anonymous nonrecursive functions.
;  - If e1, e2, and e3, and e4 are mupl expressions, then (ifgreater e1 e2 e3 e4) is a mupl expression.
;    It is a conditional where the result is e3 if e1 is strictly greater than e2 else the result is e4. Only one
;    of e3 and e4 is evaluated.
;  - If e1 and e2 are mupl expressions, then (call e1 e2) is a mupl expression (a function call).
;  - If s is a Racket string and e1 and e2 are mupl expressions, then (mlet s e1 e2) is a mupl expression
;    (a let expression where the value resulting e1 is bound to s in the evaluation of e2).
;  - If e1 and e2 are mupl expressions, then (apair e1 e2) is a mupl expression (a pair-creator).
;  - If e1 is a mupl expression, then (fst e1) is a mupl expression (getting the first part of a pair).
;  - If e1 is a mupl expression, then (snd e1) is a mupl expression (getting the second part of a pair).
;  - (aunit) is a mupl expression (holding no data, much like () in ML or null in Racket). Notice
;    (aunit) is a mupl expression, but aunit is not.
;  - If e1 is a mupl expression, then (isaunit e1) is a mupl expression (testing for (aunit)).
;  - (closure env f) is a mupl value where f is mupl function (an expression made from fun) and env
;    is an environment mapping variables to values. Closures do not appear in source programs; they result
;    from evaluating functions.
;
; A mupl value is a mupl integer constant, a mupl closure, a mupl aunit, or a mupl pair of mupl values.
; Similar to Racket, we can build list values out of nested pair values that end with a mupl aunit. Such a
; mupl value is called a mupl list.
;
; You should assume mupl programs are syntactically correct (e.g., do not worry about wrong things like (int
; "hi") or (int (int 37)). But do not assume mupl programs are free of type errors like (add (aunit)
; (int 7)) or (fst (int 7)).

(struct var  (string)              #:transparent) ;; a variable, e.g., (var "foo")
(struct int  (num)                 #:transparent) ;; a constant number, e.g., (int 17)
(struct add  (e1 e2)               #:transparent) ;; add two expressions
(struct ifgreater (e1 e2 e3 e4)    #:transparent) ;; if e1 > e2 then e3 else e4
(struct fun  (nameopt formal body) #:transparent) ;; a recursive(?) 1-argument function
(struct call (funexp actual)       #:transparent) ;; function call
(struct mlet (var e body)          #:transparent) ;; a local binding (let var = e in body) 
(struct apair (e1 e2)              #:transparent) ;; make a new pair
(struct fst  (e)                   #:transparent) ;; get first part of a pair
(struct snd  (e)                   #:transparent) ;; get second part of a pair
(struct aunit ()                   #:transparent) ;; unit value -- good for ending a list
(struct isaunit (e)                #:transparent) ;; evaluate to 1 if e is unit else 0
(struct closure (env fun)          #:transparent) ;; a closure is not in "source" programs 

;; Problem 1

; (a) Write a Racket function racketlist->mupllist that takes a Racket list (presumably of mupl
; values but that will not aect your solution) and produces an analogous mupl list with the same
; elements in the same order.

(define (racketlist->mupllist xs)
  (if (null? xs)
      (aunit)
      (apair (car xs) (racketlist->mupllist (cdr xs))) ))


; (b) Write a Racket function mupllist->racketlist that takes a mupl list (presumably of mupl
; values but that will not aect your solution) and produces an analogous Racket list (of mupl
; values) with the same elements in the same order.

(define (mupllist->racketlist xs)
  (if (aunit? xs)
      null
      (cons (apair-e1 xs) (mupllist->racketlist (apair-e2 xs))) ))


;; Problem 2

; Implementing the mupl Language: Write a mupl interpreter, i.e., a Racket function eval-exp
; that takes a mupl expression e and either returns the mupl value that e evaluates to under the empty
; environment or calls Racket's error if evaluation encounters a run-time mupl type error or unbound
; mupl variable.
;
; A mupl expression is evaluated under an environment (for evaluating variables, as usual). In your
; interpreter, use a Racket list of Racket pairs to represent this environment (which is initially empty)
; so that you can use without modification the provided envlookup function. Here is a description of
; the semantics of mupl expressions:
;
;  - All values (including closures) evaluate to themselves. For example, (eval-exp (int 17)) would
;    return (int 17), not 17.
;  - A variable evaluates to the value associated with it in the environment.
;  - An addition evaluates its subexpressions and assuming they both produce integers, produces the
;    integer that is their sum. (Note this case is done for you to get you pointed in the right direction.)
;  - Functions are lexically scoped: A function evaluates to a closure holding the function and the
;    current environment.
;  - An ifgreater evaluates its first two subexpressions to values v1 and v2 respectively. If both
;    values are integers, it evaluates its third subexpression if v1 is a strictly greater integer than v2
;    else it evaluates its fourth subexpression.
;  - An mlet expression evaluates its first expression to a value v. Then it evaluates the second
;    expression to a value, in an environment extended to map the name in the mlet expression to v.
;  - A call evaluates its first and second subexpressions to values. If the first is not a closure, it is an
;    error. Else, it evaluates the closure's function's body in the closure's environment extended to map
;    the function's name to the closure (unless the name field is #f) and the function's argument-name
;    (i.e., the parameter name) to the result of the second subexpression.
;  - A pair expression evaluates its two subexpressions and produces a (new) pair holding the results.
;  - A fst expression evaluates its subexpression. If the result for the subexpression is a pair, then the
;    result for the fst expression is the e1 field in the pair.
;  - A snd expression evaluates its subexpression. If the result for the subexpression is a pair, then
;    the result for the snd expression is the e2 field in the pair.
;  - An isaunit expression evaluates its subexpression. If the result is an aunit expression, then the
;    result for the isaunit expression is the mupl value (int 1), else the result is the mupl value
;    (int 0).
;
; Hint: The call case is the most complicated. In the sample solution, no case is more than 12 lines
; and several are 1 line.


(define (envlookup env str)
  (cond [(null? env) (error "unbound variable during evaluation" str)]
        [(equal? (car (car env)) str) (cdr (car env))]
        [#t (envlookup (cdr env) str)]))


(define (env-extend env name val)
  (cons (cons name val) env))


(define (eval-under-env e env)
  (cond [(int? e)     e] 

        [(aunit? e)   e]

        [(closure? e) e]

        [(fun? e) (closure env e)]

        [(var? e) (envlookup env (var-string e))]

        [(isaunit? e)
          (let ([val (eval-under-env (isaunit-e e) env)])
            (if (aunit? val) (int 1) (int 0)) )]

        [(mlet? e)
          (let ([name (mlet-var e)]
                [val  (eval-under-env (mlet-e e) env)])
            (eval-under-env (mlet-body e) (env-extend env name val)) )]

        [(apair? e) 
          (let ([v1 (eval-under-env (apair-e1 e) env)]
                [v2 (eval-under-env (apair-e2 e) env)])
            (apair v1 v2) )]

        [(fst? e)
          (let ([val (eval-under-env (fst-e e) env)])
            (if (apair? val)
                (apair-e1 val)
                (error "MUPL fst requires a pair") ))]

        [(snd? e)
          (let ([val (eval-under-env (snd-e e) env)])
            (if (apair? val)
                (apair-e2 val)
                (error "MUPL snd requires a pair") ))]

        [(add? e) 
          (let ([v1 (eval-under-env (add-e1 e) env)]
                [v2 (eval-under-env (add-e2 e) env)])
            (if (and (int? v1) (int? v2))
                (int (+ (int-num v1) (int-num v2)))
                (error "MUPL addition applied to non-number") ))]

        [(ifgreater? e) 
          (let ([v1 (eval-under-env (ifgreater-e1 e) env)]
                [v2 (eval-under-env (ifgreater-e2 e) env)])
            (if (and (int? v1) (int? v2))
              (if (> (int-num v1) (int-num v2))
                (eval-under-env (ifgreater-e3 e) env)
                (eval-under-env (ifgreater-e4 e) env)) 
              (error "MUPL ifgreater applied to non-numbers") ))]

        [(call? e)
          (let  ([clos (eval-under-env (call-funexp e) env)])
            (if (closure? clos)
              (let* ([fun  (closure-fun clos)]
                     [cenv (closure-env clos)]
                     [nameopt (fun-nameopt fun)]
                     [body    (fun-body fun)]
                     [formal  (fun-formal fun)]
                     [arg  (eval-under-env (call-actual e) env)])
                (if nameopt
                  (eval-under-env body (env-extend (env-extend cenv formal arg) nameopt clos))
                  (eval-under-env body (env-extend cenv formal arg)) ))
              (error "MUPL call requires a closure") ))]

        [#t (error (format "bad MUPL expression: ~v" e))] ))


(define (eval-exp e)
  (eval-under-env e null))
        

;; Problem 3

; Expanding the Language: mupl is a small language, but we can write Racket functions that act like
; mupl macros so that users of these functions feel like mupl is larger. The Racket functions produce
; mupl expressions that could then be put inside larger mupl expressions or passed to eval-exp. In
; implementing these Racket functions, do not use closure (which is used only internally in eval-exp).
; Also do not use eval-exp (we are creating a program, not running it).

; (a) Write a Racket function ifaunit that takes three mupl expressions e1, e2, and e3. It returns a
; mupl expression that when run evaluates e1 and if the result is mupl's aunit then it evaluates e2
; and that is the overall result, else it evaluates e3 and that is the overall result. Sample solution:
; 1 line.

(define (ifaunit e1 e2 e3) 
  (ifgreater (isaunit e1) (int 0) e2 e3))


; (b) Write a Racket function mlet* that takes a Racket list of Racket pairs
; '((s1 . e1) . . . (si . ei) . . . (sn . en)) and a final mupl expression en+1.
; In each pair, assume si is a Racket string and ei is a mupl expression. mlet*
; returns a mupl expression whose value is en+1 evaluated in an environment where
; each si is a variable bound to the result of evaluating the corresponding ei
; for 1  i  n. The bindings are done sequentially, so that each ei is evaluated
; in an environment where s1 through si-1 have been previously bound to the
; values e1 through ei-1.

(define (mlet* lstlst e2) 
  (if (null? lstlst)
    e2
    (let* ([binding (car lstlst)] 
           [var (car binding)] 
           [body (cdr binding)])
      (mlet var body (mlet* (cdr lstlst) e2)) )))


; (c) Write a Racket function ifeq that takes four mupl expressions e1, e2, e3, and e4 and returns
; a mupl expression that acts like ifgreater except e3 is evaluated if and only if e1 and e2 are
; equal integers. Assume none of the arguments to ifeq use the mupl variables _x or _y. Use this
; assumption so that when an expression returned from ifeq is evaluated, e1 and e2 are evaluated
; exactly once each.

(define (ifeq e1 e2 e3 e4) 
  (mlet* (list (cons "_x" e1) (cons "_y" e2))
    (ifgreater (var "_x") (var "_y") e4 
               (ifgreater (var "_y") (var "_x") e4 e3))))


;; Problem 4

; Using the Language: We can write mupl expressions directly in Racket using the constructors for
; the structs and (for convenience) the functions we wrote in the previous problem.

; (a) Bind to the Racket variable mupl-map a mupl function that acts like map (as we used extensively
; in ML). Your function should be curried: it should take a mupl function and return a mupl
; function that takes a mupl list and applies the function to every element of the list returning a
; new mupl list. Recall a mupl list is aunit or a pair where the second component is a mupl list.

(define mupl-map 
  (fun #f "f" 
     (fun "mmap-l" "xs" 
        (ifaunit (var "xs")
                 (aunit)
                 (apair (call (var "f") (fst (var "xs"))) 
                        (call (var "mmap-l") (snd (var "xs")) ))))))

; (b) Bind to the Racket variable mupl-mapAddN a mupl function that takes an mupl integer i and
; returns a mupl function that takes a mupl list of mupl integers and returns a new mupl list of
; mupl integers that adds i to every element of the list. Use mupl-map (a use of mlet is given to
; you to make this easier).

(define mupl-mapAddN 
  (mlet "map" mupl-map
    (fun #f "i"
      (fun #f "xs"
        (call (call (var "map") 
          (fun #f "n" (add (var "n") (var "i")))) 
          (var "xs")) ))))


;; Challenge Problem

; Write a second version of eval-exp (bound to eval-exp-c) that builds closures
; with smaller environments: When building a closure, it uses an environment that is like the current
; environment but holds only variables that are free variables in the function part of the closure. (A free
; variable is a variable that appears in the function without being under some shadowing binding for the
; same variable.)
; 
; Avoid computing a function's free variables more than once. Do this by writing a function compute-free-vars
; that takes an expression and returns a dierent expression that uses fun-challenge everywhere in
; place of fun. The new struct fun-challenge (provided to you; do not change it) has a field freevars
; to store exactly the set of free variables for the function. Store this set as a Racket set of Racket strings.
; (Sets are predefined in Racket's standard library; consult the documentation for useful functions such
; as set, set-add, set-member?, set-remove, set-union, and any other functions you wish.)
; 
; You must have a top-level function compute-free-vars that works as just described | storing the
; free variables of each function in the freevars field | so the grader can test it directly. Then write a
; new \main part" of the interpreter that expects the sort of mupl expression that compute-free-vars
; returns. The case for function definitions is the interesting one.


(struct fun-challenge (nameopt formal body freevars) #:transparent) ;; a recursive(?) 1-argument function

; Replace all instances of fun with fun-challenge and add freevar lists to each
;
(define (compute-free-vars e) 

  ; return type for compute-free-vars-rec, a MUPL expression and a set of the
  ; freevars for that expression
  ;
  (struct eclos (expr vars)       #:transparent) 

  ; return type for compute-helper, a list of MUPL expressions and the set of all
  ; free vars in those expressions
  ;
  (struct exprs-vars (exprs vars) #:transparent)

  ; takes a list of MUPL expressions and returns a list of MUPL expressions with every fun
  ; replaced with fun-challenge and the union of the free vars in those epxressions
  ;
  (define (compute-helper exprs) 
    (foldr (lambda (e evars) 
             (match (compute-free-vars-rec e)
               [(eclos expr vars) (exprs-vars
                                  (cons expr (exprs-vars-exprs evars)) 
                                  (set-union vars (exprs-vars-vars evars)))])) 
           (exprs-vars null (set)) 
           exprs))

  ; takes a MUPL expression and returns an eclos, with a new MUPL expression that uses fun-challenge
  ; and the list of freevars in that expression
  ;
  (define (compute-free-vars-rec e)
    (cond [(int? e)       (eclos e (set))]
          [(aunit? e)     (eclos e (set))]
          [(var? e)       (eclos e (set-add (set) (var-string e) ))]

          [(fun? e)        (match (compute-helper (list (fun-body e)))
                             [(exprs-vars (list expr) vars) 
                              (let ([fvars (set-remove vars (fun-formal e))])
                                (eclos (fun-challenge (fun-nameopt e) (fun-formal e) expr fvars) fvars) )])]

          [(isaunit? e)    (match (compute-helper (list (isaunit-e e)))
                             [(exprs-vars (list expr) vars) 
                              (eclos (isaunit expr) vars) ])]

          [(fst? e)        (match (compute-helper (list (fst-e e)))
                             [(exprs-vars (list expr) vars) 
                              (eclos (fst expr) vars) ])]

          [(snd? e)        (match (compute-helper (list (snd-e e)))
                             [(exprs-vars (list expr) vars) 
                              (eclos (snd expr) vars) ])]

          [(call? e)       (match (compute-helper (list (call-funexp e) (call-actual e)))
                             [(exprs-vars (list expr1 expr2) vars) 
                              (eclos (call expr1 expr2) vars) ])]

          [(mlet? e)       (match (compute-helper (list (mlet-e e) (mlet-body e)))
                             [(exprs-vars (list expr1 expr2) vars) 
                              (let ([fvars (set-remove vars (mlet-var e))])
                                (eclos (mlet (mlet-var e) expr1 expr2) fvars) )])]

          [(apair? e)      (match (compute-helper (list (apair-e1 e) (apair-e2 e)))
                             [(exprs-vars (list expr1 expr2) vars) 
                              (eclos (apair expr1 expr2) vars) ])]

          [(add? e)        (match (compute-helper (list (add-e1 e) (add-e2 e)))
                             [(exprs-vars (list expr1 expr2) vars) 
                              (eclos (add expr1 expr2) vars) ])]

          [(ifgreater? e)  (match (compute-helper (list (ifgreater-e1 e) (ifgreater-e2 e) 
                                                        (ifgreater-e3 e) (ifgreater-e4 e)))
                             [(exprs-vars (list expr1 expr2 expr3 expr4) vars) 
                              (eclos (ifgreater expr1 expr2 expr3 expr4) vars) ])]

        [#t (error (format "bad MUPL expression ~v" e))] ))
  (eclos-expr (compute-free-vars-rec e)))


; Only the fun-challenge case is modified to support env filtering
;
(define (eval-under-env-c e env)
  (cond [(int? e)     e] 

        [(aunit? e)   e]

        [(closure? e) e]

        [(fun-challenge? e) 
         (let* ([freevars  (fun-challenge-freevars e)]
                [freevar?  (lambda (b) (set-member? freevars (car b)))]
                [small-env (filter freevar? env)])
                  (closure small-env e))]

        [(var? e) (envlookup env (var-string e))]

        [(isaunit? e)
          (let ([val (eval-under-env-c (isaunit-e e) env)])
            (if (aunit? val) (int 1) (int 0)) )]

        [(mlet? e)
          (let ([name (mlet-var e)]
                [val  (eval-under-env-c (mlet-e e) env)])
            (eval-under-env-c (mlet-body e) (env-extend env name val)) )]

        [(apair? e) 
          (let ([v1 (eval-under-env-c (apair-e1 e) env)]
                [v2 (eval-under-env-c (apair-e2 e) env)])
            (apair v1 v2) )]

        [(fst? e)
          (let ([val (eval-under-env-c (fst-e e) env)])
            (if (apair? val)
                (apair-e1 val)
                (error "MUPL fst requires a pair") ))]

        [(snd? e)
          (let ([val (eval-under-env-c (snd-e e) env)])
            (if (apair? val)
                (apair-e2 val)
                (error "MUPL snd requires a pair") ))]

        [(add? e) 
          (let ([v1 (eval-under-env-c (add-e1 e) env)]
                [v2 (eval-under-env-c (add-e2 e) env)])
            (if (and (int? v1) (int? v2))
                (int (+ (int-num v1) (int-num v2)))
                (error "MUPL addition applied to non-number") ))]

        [(ifgreater? e) 
          (let ([v1 (eval-under-env-c (ifgreater-e1 e) env)]
                [v2 (eval-under-env-c (ifgreater-e2 e) env)])
            (if (and (int? v1) (int? v2))
              (if (> (int-num v1) (int-num v2))
                (eval-under-env-c (ifgreater-e3 e) env)
                (eval-under-env-c (ifgreater-e4 e) env)) 
              (error "MUPL ifgreater applied to non-numbers") ))]

        [(call? e)
          (let  ([clos (eval-under-env-c (call-funexp e) env)])
            (if (closure? clos)
              (let* ([fun  (closure-fun clos)]
                     [cenv (closure-env clos)]
                     [nameopt (fun-challenge-nameopt fun)]
                     [body    (fun-challenge-body fun)]
                     [formal  (fun-challenge-formal fun)]
                     [arg  (eval-under-env-c (call-actual e) env)])
                (if nameopt
                  (eval-under-env-c body (env-extend (env-extend cenv formal arg) nameopt clos))
                  (eval-under-env-c body (env-extend cenv formal arg)) ))
              (error "MUPL call requires a closure") ))]

        [#t (error (format "bad MUPL expression: ~v" e))] ))

(define (eval-exp-c e)
  (eval-under-env-c (compute-free-vars e) null))
