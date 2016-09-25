; Helpers
(def p println)

; Problem 20
; Ans: 648

(defn fact [n]
  (defn fact-helper [n a]
    (if (<= n 1)
      a
      (recur (dec n) (*' n a))))
  (fact-helper n 1))

(defn parse-int [c] (Integer/parseInt (str c)))

(reduce + (map parse-int (str (fact 100))))

(defn fib [n c l]
   (if (>= (count (str c)) 1000)
     n
     (recur (inc n) (+' c l) c)))

; Problem 25
; Ans: 4787

; Proglem 31


