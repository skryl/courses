#lang racket
;; Programming Languages Homework5 Simple Test
;; Save this file to the same directory as your homework file
;; These are basic tests. Passing these tests does not guarantee that your code will pass the actual homework grader

;; Be sure to put your homework file in the same folder as this test file.
;; Uncomment the line below and change HOMEWORK_FILE to the name of your homework file.
;;(require "HOMEWORK_FILE")

(require rackunit)

(define tests
  (test-suite
   "Sample tests for Assignment 5"
   
   ;; check racketlist to mupllist with normal list
   (check-equal? (racketlist->mupllist (list (int 3) (int 4))) (apair (int 3) (apair (int 4) (aunit))) "racketlist->mupllist test")
   
   ;; check mupllist to racketlist with normal list
   (check-equal? (mupllist->racketlist (apair (int 3) (apair (int 4) (aunit)))) (list (int 3) (int 4)) "racketlist->mupllist test")

   ;; tests if ifgreater returns (int 2)
   (check-equal? (eval-exp (ifgreater (int 3) (int 4) (int 3) (int 2))) (int 2) "ifgreater test")
   
   ;; mlet test
   (check-equal? (eval-exp (mlet "x" (int 1) (add (int 5) (var "x")))) (int 6) "mlet test")
   
   ;; call test
   (check-equal? (eval-exp (call (closure '() (fun #f "x" (add (var "x") (int 7)))) (int 1))) (int 8) "call test")
   
   ;;snd test
   (check-equal? (eval-exp (snd (apair (int 1) (int 2)))) (int 2) "snd test")
   
   ;; isaunit test
   (check-equal? (eval-exp (isaunit (closure '() (fun #f "x" (aunit))))) (int 0) "isaunit test")
   
   ;; ifaunit test
   (check-equal? (eval-exp (ifaunit (int 1) (int 2) (int 3))) (int 3) "ifaunit test")
   
   ;; mlet* test
   (check-equal? (eval-exp (mlet* (list (cons "x" (int 10))) (var "x"))) (int 10) "mlet* test")
   
   ;; ifeq test
   (check-equal? (eval-exp (ifeq (int 1) (int 2) (int 3) (int 4))) (int 4) "ifeq test")
   
   ;; mupl-map test
   (check-equal? (eval-exp (call (call mupl-map (fun #f "x" (add (var "x") (int 7)))) (apair (int 1) (aunit)))) 
                 (apair (int 8) (aunit)) "mupl-map test")
   
   ;; problems 1, 2, and 4 combined test
   (check-equal? (mupllist->racketlist
   (eval-exp (call (call mupl-mapAddN (int 7))
                   (racketlist->mupllist 
                    (list (int 3) (int 4) (int 9)))))) (list (int 10) (int 11) (int 16)) "combined test")
   
   ))

(require rackunit/text-ui)
;; runs the test
(run-tests tests)

(test-case "examples from the lecture"
    (check-equal? (fun-challenge-freevars
      (compute-free-vars (fun #f "_" (add (add (var "x") (var "y")) (var "z")))))
      (set "x" "y" "z"))
    (check-equal? (fun-challenge-freevars
      (compute-free-vars (fun #f "x" (add (add (var "x") (var "y")) (var "z")))))
      (set "y" "z"))
    (check-equal? (fun-challenge-freevars
      (compute-free-vars (fun #f "x" (ifgreater (var "x") (aunit) (var "y") (var "z")))))
      (set "y" "z"))
    (check-equal? (fun-challenge-freevars
      (compute-free-vars (fun #f "x"
        (mlet "y" (int 0) (add (add (var "x") (var "y")) (var "z"))))))
      (set "z"))
    (check-equal? (fun-challenge-freevars
      (compute-free-vars (fun #f "x" (fun #f "y" (fun #f "z"
        (add (add (var "x") (var "y")) (var "z")))))))
      (set))
    (check-equal? (fun-challenge-freevars
      (compute-free-vars (fun #f "x" 
        (add (var "y")
          (mlet "y" (var "z") (add (var "y") (var "y")))))))
      (set "y" "z")))

  (check-equal? (fun-challenge-freevars
                  (compute-free-vars (fun #f "x" (apair (mlet "y" (int 0) (add (var "y") (var "x")))
                                                        (var "y")))))
                 (set "y"))
   (check-equal? (fun-challenge-freevars
                  (compute-free-vars (fun #f "x" (ifgreater (var "x")
                                                            (int 0)
                                                            (mlet "y" (int 1) (add (var "y") (int 1)))
                                                            (var "y")))))
                 (set "y"))

   (check-equal? (eval-exp-c (call (fun "sum-1-n" "arg" 
                                        (ifgreater (var "arg") (int 1)
                                                   (add (var "arg") 
                                                        (call 
                                                         (var "sum-1-n") 
                                                         (add (var "arg") (int -1))))
                                                   (var "arg")))
                                   (int 4))) (int 10) "call test 4")

   (check-equal? (eval-exp-c (call
                              (fun "fib" "n"
                                   (call (call (call
                                                (fun "aux" "n0" (fun #f "a" (fun #f "b"
                                                                                 (ifgreater (add (var "n0") (int 1)) (var "n")
                                                                                            (var "a")
                                                                                            (call (call (call (var "aux") (add (var "n0") (int 1))) (var "b")) (add (var "a") (var "b")))))))
                                                (int 0)) (int 0)) (int 1))) (int 7))) (int 13) "call test 5")

(define expr (mlet "f2" (fun #f "y" (add (var "y") (int 1))) 
                   (call (var "f2") 
                         (call (fun #f "x" (add (var "x") (int 1))) 
                               (int 2)))))

(define expr2 (call (fun #f "x" (int 1)) (int 1)))

(define fib
  (fun "fib" "n"
    (ifgreater (var "n") (int 2)
      (add (call (var "fib") (add (var "n") (int -1)))
           (call (var "fib") (add (var "n") (int -2))))
      (int 1) )))