; Example 1.11: A function f is defined recursively as follows:
; f(n) = n if n < 3
; f(n) = f(n-1) + 2f(n-2) + 3f(n-3) if n >= 3
; Write a procedure that computes f by means of a recursive
; process. Write a procedure that computes f by means of an
; iterative process.


;;;;; recursion process
(define (f n)
  (if (< n 3) 
      n
      (+ (f (- n 1)) 
         (* 2 (f (- n 2))) 
         (* 3 (f (- n 3))) )))

;;;;; iterative process
(define (f n)
      (f-iter 2 1 0 0 n))
(define (f-iter a b c cou n)
  (if (= cou n)
      c
      (f-iter (+ a (* 2 b) (* 3 c))
              a
              b
              (+ cou 1)
              n)))
