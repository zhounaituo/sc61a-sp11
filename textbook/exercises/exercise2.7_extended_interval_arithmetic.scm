; Extended Exercise: Interval Arithmetic

; adding two intervals;
(define (add-Interval x y)
    (make-interval (+ (lower-bound x) (lower-bound y))
                   (+ (upper-bound x) (upper-bound y))))

; finding the minimum and the maximum of the products of the bounds
(define (mul-interval x y)
    (let ((p1 (* (lower-bound x) (lower-bound y)))
          (p2 (* (lower-bound x) (upper-bound y)))
          (p3 (* (upper-bound x) (lower-bound y)))
          (p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))

(define (div-interval x y)
    (mul-interval
     x
     (make-interval (/ 1.0 (upper-bound y))
                    (/ 1.0 (lower-bound y)) )))

; Exercise 2.7. Alyssa's program is incomplete because she 
; has not specified the implementation of the interval 
; abstraction. Here is a definition of the interval 
; constructor:

(define (make-interval a b) (cons a b))

; Define selectors upper-bound and lower-bound to complete 
; the implementation.

(define (lower-bound x)
    (min (cdr x) (car x)))

(define (upper-bound x)
    (max (car x) (cdr x)))

; Exercise 2.8. Using reasoning analogous to Alyssa's, 
; describe how the difference of two intervals may be 
; computed. Define a corresponding subtraction procedure, 
; called sub-interval.

(define (sub-interval x y)
    (let ((p1 (- (lower-bound x) (lower-bound y))) 
          (p2 (- (lower-bound x) (upper-bound y))) 
          (p3 (- (upper-bound x) (lower-bound y))) 
          (p4 (- (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))

; Exercise 2.9. The width of an interval is half of the 
; difference between its upper and lower bounds. The width 
; is a measure of the uncertainty of the number specified ;
; by the interval. For some arithmetic operations the 
; width of the result of combining two intervals is a 
; function only of the widths of the argument intervals, 
; whereas for others the width of the combination is not a 
; function of the widths of the argument intervals. Show 
; that the width of the sum (or difference) of two 
; intervals is a function only of the widths of the 
; intervals being added (or subtracted). Give examples to 
; show that this is not true for multiplication or 
; division.