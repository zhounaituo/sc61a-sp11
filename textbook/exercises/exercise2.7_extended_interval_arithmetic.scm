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

(define (get-width x)
    (avg (upper-bound x) (lower-bound x)))

(define (avg a b)
    (/ (+ a b) 2))

; [4,5] [9,18]
(define a (make-interval 4 5))
(define b (make-interval 9 18))

(define (equal-interval? a b)
    (and (= (upper-bound a) (upper-bound b)) (= (lower-bound a) (lower-bound b))))

(cond ((= (get-width (add-interval a b)) 
          (+ (get-width a) (get-width b))) (print #t))
      (else (print #f)))

(cond ((= (get-width (sub-interval a b)) 
          (- (get-width a) (get-width b))) (print #t))
      (else (print #f)))

(cond ((= (get-width (mul-interval a b)) 
          (* (get-width a) (get-width b))) (print #t))
      (else (print #f)))

(cond ((= (get-width (div-interval a b)) 
          (/ (get-width a) (get-width b))) (print #t))
      (else (print #f)))

; Exercise 2.10. Ben Bitdiddle, an expert systems 
; programmer, looks over Alyssa's shoulder and comments 
; that it is not clear what it means to divide by an 
; interval that spans zero. Modify Alyssa's code to check 
; for this condition and to signal an error if it occurs.

(define (div-interval x y)
    (if (iscontains? y 0) 
        (error "Error: Encounter interval contains zero.")
        (mul-interval
            x
            (make-interval (/ 1.0 (upper-bound y))
                           (/ 1.0 (lower-bound y)) ))))

(define (iscontains? z a)
   (and (<= (lower-bound z) a) (<= a (upper-bound z))))

; Exercise 2.11. In passing, Ben also cryptically 
; comments: ``By testing the signs of the endpoints of the 
; intervals, it is possible to break mul-interval into 
; nine cases, only one of which requires more than two 
; multiplications.'' Rewrite this procedure using Ben's 
; suggestion. 

(define (mul-interval x y)
    (let ((x1 (lower-bound x))
          (x2 (upper-bound x))
          (y1 (lower-bound y))
          (y2 (upper-bound y))
          (neg (num-of-negative (lower-bound x)
                                (upper-bound x)
                                (lower-bound y)
                                (upper-bound y)))
          (xn  (num-of-negative (lower-bound x) (upper-bound x)))
          (yn  (num-of-negative (lower-bound y) (lower-bound y))))
        (cond ((= neg 0) (make-interval (* x1 y1) (* x2 y2)))
              ((or (and (= neg 1) (= xn 1))
                   (and (= neg 2) (= xn 2)))
                (make-interval (* x1 y2) (* x2 y2)))
              ((or (and (= neg 1) (= yn 1))
                   (and (= neg 2) (= yn 2))) 
                (make-interval (* x2 y1) (* x2 y2)))
              ((= neg 2) (make-interval (min (* x1 y2) (* x2 y1)) 
                                        (max (* x1 y1) (* x2 y2))))
              ((and (= neg 3) (= nx 2)) 
                (make-interval (* x1 y2) (* x1 y1)))
              ((and (= neg 3) (= ny 2)) 
                (make-interval (* x2 y1) (* x1 y1)))
              (((= neg 4) (make-interval (* x2 y2) (* x1 y1)))) )))
            

(define (num-of-negative . args)
    (accumulate + (every (lambda (x) (if (< x 0) 1 0)) (se args))))

; After debugging her program, Alyssa shows it 
; to a potential user, who complains that her program 
; solves the wrong problem. He wants a program that can 
; deal with numbers represented as a center value and an 
; additive tolerance; for example, he wants to work with 
; intervals such as 3.5± 0.15 rather than [3.35, 3.65]. 
; Alyssa returns to her desk and fixes this problem by 
; supplying an alternate constructor and alternate 
; selectors: 

(define (make-center-width c w) 
    (make-interval (- c w) (+ c w))) 

(define (center i) 
    (/ (+ (lower-bound i) (upper-bound i)) 2)) 

(define (width i) 
    (/ (- (upper-bound i) (lower-bound i)) 2)) 

; Unfortunately, most of Alyssa's users are engineers. 
; Real engineering situations usually involve measurements 
; with only a small uncertainty, measured as the ratio of 
; the width of the interval to the midpoint of the 
; interval. Engineers usually specify percentage 
; tolerances on the parameters of devices, as in the 
; resistor specifications given earlier.

; 3.5±0.15 -> [3.35,3.65]
(define (to-interval c u)
    (make-interval (- c u) (+ c u)))

; [3.35,3.65] -> 3.5±0.15
(define (ct i)
    (display (center i))
    (display "±")
    (display (width i)))

; Exercise 2.12. Define a constructor make-center-percent 
; that takes a center and a percentage tolerance and 
; produces the desired interval. You must also define a 
; selector percent that produces the percentage tolerance 
; for a given interval. The center selector is the same as 
; the one shown above.

(define (make-center-percent center percentage)
    (to-interval center (percent center percentage)))

(define (percent center percentage)
    (* center percentage))

; Exercise 2.13. Show that under the assumption of small 
; percentage tolerances there is a simple formula for the 
; approximate percentage tolerance of the product of two 
; intervals in terms of the tolerances of the factors. You 
; may simplify the problem by assuming that all numbers 
; are positive.

;```makedown
;$I:interval;c:center;p:percent;t:tolerance$
;$I = c_i\pm c_i p_i,(i=1,2)$
;$I = [(1-p_1)c_1*(1-p_2)c_2,(1+p_1)c_1*(1+p_2)c_2)]$
;$I = [(1-(p_1+p_2)+p_1p_2)c_1c_2,(1+(p_1+p_2)+p_1p_2)c_1c_2]$
;$I=[c_1c_2\pm c_1c_2(p_1+p_2)]$
;```

; I = c±cp
;   = [(1-p1)c1*(1-p2)c2,(1+p1)c1*(1+p2)c2]
;   = [(1-(p1+p2)+p1p2)c1c2,(1+(p1+p2)+p1p2)c1c2]
; I = [c1c2±(p1p2)c1c2]
; p = (p1p2)