; Datatype programming without structs
; - can mix types so cons cells can hold pretty much anything

; constructor helpers
(define (Const i) (list 'Const i))
(define (Negate i) (list 'Negate i))
(define (Add e1 e2) (list 'Add e1 e2))
(define (Multiply e1 e2) (list 'Multiply e1 e2))

; testing types
(define (Const? x) (eq? (car x) 'Const))
(define (Negate? x) (eq? (car x) 'Negate))
(define (Add? x) (eq? (car x) 'Add))
(define (Multiply? x) (eq? (car x) 'Multiply)) 

; data extraction helpers
(define Const-int cadr)
(define Negate-e cadr)
(define Add-e1 cadr)
(define Add-e2 caddr)
(define Multiply-e1 cadr)
(define Multiply-e2 caddr)

(define (eval-exp e)
  (cond [(Const? e) e] ; note returning an exp, not a number
        [(Negate? e) (Const (- (Const-int (eval-exp (Negate-e e)))))]
        [(Add? e) (let ([v1 (Const-int (eval-exp (Add-e1 e)))]
                        [v2 (Const-int (eval-exp (Add-e2 e)))])
                    (Const (+ v1 v2)))]
        [(Multiply? e) (let ([v1 (Const-int (eval-exp (Multiply-e1 e)))]
                             [v2 (Const-int (eval-exp (Multiply-e2 e)))])
                         (Const (* v1 v2)))]
        [#t (error "eval-exp expected an exp")]))

(define a-test (eval-exp (Multiply (Negate (Add (Const 2) (Const 2))) (Const 7))))

; Datatype programming with structs

(struct foo (bar baz quux) #:transparent)

; adds the following functions to the environment (constructor, tester, accessors)
; - (foo e1 e2 e3) that returns "a foo"
; - (foo? e) #t if result of e was made using (foo)
; - (foo-bar e) accessor, error if e is not "a foo"
; - (foo-baz e)
; - (foo-quux e)

(struct const (int) #:transparent)
(struct negate (e) #:transparent)
(struct add (e1 e2) #:transparent)
(struct multiply (e1 e2) #:transparent)

(define (eval-exp e)
  (cond [(const? e) e] ; note returning an exp, not a number
        [(negate? e) (const (- (const-int (eval-exp (negate-e e)))))]
        [(add? e) (let ([v1 (const-int (eval-exp (add-e1 e)))]
                        [v2 (const-int (eval-exp (add-e2 e)))])
                    (const (+ v1 v2)))]
        [(multiply? e) (let ([v1 (const-int (eval-exp (multiply-e1 e)))]
                             [v2 (const-int (eval-exp (multiply-e2 e)))])
                         (const (* v1 v2)))]
        [#t (error "eval-exp expected an exp")]))

(define a-test (eval-exp (multiply (negate (add (const 2) (const 2))) (const 7))))

; struct attributes
; - #:transparent - REPL prints struct contents
; - #:mutable     - generates mutator functions for all fields (my-mutator! val)
;   - mcons is just a predefined mutable struct

; Advantages of structs
; - struct types are treated like new primitive types (pair?, list?, ...)
; - can't call wrong accessor on a specific type (multiply-e1 (add (const 1) (const 2))) ERRORS!
; - fails sooner when misusing
; - structs are a special construct
;   - a function cannot introduce multiple bindings
;   - neither functions nor macros can create a new kind of data

; Implementing programming languages
;   1. concerete syntax sent to parser, produces AST
;   2. type checker confirms correctness, forwards AST
;   3. a. interpret code using interpreter written in lang A
;      b. compile the code to lang C using a compiler written in lang A

; Evaluation vs Compilation
; - modern languages do both (Java compiles to bytecode, which is interpreted, and sometimes parts are compiled to machine code for speed)
; - the chip itself is an interpreter for machine code, x86 has a hardware translater to more primitive micro ops that get executed
; - intepreter or a compiler is a language implementation detail, no such thing as compiled or interpreted language
;   - sayings such as "C is faster because it is compiled" makes no sense

; add expression type checking

(define (eval-exp e)
  (cond [(const? e) 
         e] 
        [(negate? e) 
         (let ([v (eval-exp (negate-e1 e))])
           (if (const? v)
               (const (- (const-int v)))
               (error "negate applied to non-number")))]
        [(add? e) 
         (let ([v1 (eval-exp (add-e1 e))]
               [v2 (eval-exp (add-e2 e))])
           (if (and (const? v1) (const? v2))
               (const (+ (const-int v1) (const-int v2)))
               (error "add applied to non-number")))]
        [(multiply? e) 
         (let ([v1 (eval-exp (multiply-e1 e))]
               [v2 (eval-exp (multiply-e2 e))])
           (if (and (const? v1) (const? v2))
               (const (* (const-int v1) (const-int v2)))
               (error "multiply applied to non-number")))]
        [(bool? e) 
         e]
        [(eq-num? e) 
         (let ([v1 (eval-exp (eq-num-e1 e))]
               [v2 (eval-exp (eq-num-e2 e))])
           (if (and (const? v1) (const? v2))
               (bool (= (const-int v1) (const-int v2))) ; creates (bool #t) or (bool #f)
               (error "eq-num applied to non-number")))]
        [(if-then-else? e) 
         (let ([v-test (eval-exp (if-then-else-e1 e))])
           (if (bool? v-test)
               (if (bool-b v-test)
                   (eval-exp (if-then-else-e2 e))
                   (eval-exp (if-then-else-e3 e)))
               (error "if-then-else applied to non-boolean")))]
        [#t (error "eval-exp expected an exp")] ; not strictly necessary but helps debugging
        ))

; Racket Functions as Macros for Interpreted Language

(define (double e)
  (multiply e (const 2)))

; this one takes a Racket list of language-being-implemented syntax 
; and makes language-being-implemented syntax
(define (list-product es)
  (if (null? es)
      (const 1)
      (multiply (car es) (list-product (cdr es)))))

(define test (andalso (eq-num (double (const 4))
                              (list-product (list (const 2) (const 2) (const 1) (const 2))))
                      (bool #t)))

; notice we have not changed our interpreter at all
(define result (eval-exp test))

; Racket from an ML perspective

datatype theType = Int of int |
                   String of string |
                   Pair of theType * theType |
                   Fun of theType -> theType |
                   ...

; constructors are applied implicitly
; 42 is really Int 42

; primitives check tags and extract data, raising errors for wrong constructors

fun car v = case v of Pair(a,b) => a | _ => raise ...
fun pair? v = case v of Pair _ => true | _ => false

; Eval and Quote
; - need an in-memory language implementation to support eval
; - can be a compiler, but most are interpreted

(define (make-some-code1 y)
  (if y
    (list 'begin (list 'print "hi") (list '+ 4 2))
    (list '+ 5 3)))

(make-some-code1 #t)
(eval (make-some-code1 #f))

 
; quoting
; quasiquote and unquoting can unquote elements in quoted lists
(list 'begin (list 'print "hi") (list '+ 4 2))
(quote (begin (print "hi") (+ 4 2)))
