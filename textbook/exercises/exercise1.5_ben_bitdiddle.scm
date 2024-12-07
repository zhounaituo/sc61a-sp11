; Exercise 1.5: 

(define (p) (p))
(define (test x y)
  (if (= x 0) 0 y))
(test 0 (p))

; 如果是 applicative-order 求值，会得到无限递归
; 如果是 normal-order 求值，会得到 0