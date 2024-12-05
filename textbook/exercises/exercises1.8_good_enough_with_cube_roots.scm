; Exercise 1.8: Newton’s method for cube roots is based on the fact that 
; if y is an approximation to the cube root of x , then a better 
; approximation is given by the value
; y = (x / y^2 + 2y) / 3
; Use this formula to implement a cube-root procedure anal ogous to the 
; square-root procedure. (In Section 1.3.4 we will see how to implement 
; Newton’s method in general as an abstraction of these square-root and 
; cube-root procedures.)

(define (cube-iter guess last-guess x)
  (if (enough? guess last-guess)
      guess 
      (cube-iter (improve guess x) guess x)))

(define (enough? guess last-guess)
  (< (abs (- guess last-guess)) 0.00001))
(define (improve y x)
  (/ (+ (/ x (quare y)) (* 2 y)) 3))
(define (quare x) (* x x))

(define (cube-root x)
  (cube-iter 1.0 x x))
