; largest number
;
(defn max [& args] (reduce #(if (> %1 %2) %1 %2) 0 args) )

; interleave sequences
;
(defn inter [coll1 coll2] 
  (loop [both [] c1 coll1 c2 coll2] 
    (if (or (empty? c1) (empty? c2))
      (into both (into c1 c2))
      (recur (conj both (first c1) (first c2)) (rest c1) (rest c2)))))
    
; reducing empty collections
;
(defn [& args] (if (empty? args) 0 (+ (first args) (last args))))

; nil is treated as empty sequence
;
(defn foo [x] (when (> x 0) (conj (foo (dec x)) x)))

; thread macro
;
(-> [2 5 4 1 3 6] reverse rest sort last)
(->> [2 5 4 1 3 6] (drop 2) (take 3) (map inc))

; summing small vector
;
(apply + [1 2 3 4 5])

(defn check [key hmap] (and (contains? hmap key) (nil? (hmap key))))

;for
;
(for [x (range 40)
            :when (= 1 (rem x 4 ))]
  x)
  
(for [x (iterate #(+ 4 %) 0)
            :let [z (inc x )]
            :while (< z 40)]
  z)
  
(for [[x y] (partition 2 (range 20))]
  (+ x y))

; default map values
;
(defn defmap [dval coll] 
  (zipmap coll (repeat (count coll) dval)))

; palindromes
;
(defn pali [coll] (= (seq coll) (reverse coll)))

; fibbionacci gen
;
(defn fibgen [n] (map (fn f [n] (case n 1 1 2 1 (+ (f (- n 2)) (f (- n 1))))) (range 1 (+ n 1))))


















