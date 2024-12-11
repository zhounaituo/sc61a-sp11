;;;;;
(define (add-rat x y)
  (make-rat (+ (* (numer x) (denom y))
               (* (numer y) (denom x)))
            (* (denom x) (denom y))))

;;;;;
(define (sub-rat x y)
  (make-rat (- (* (numer x) (denom y))
               (* (numer y) (denom x))
            (* (denom x) (denom y)) )))

;;;;;
(define (mul-rat x y)
  (make-rat (* (numer x) (numer y))
            (* (denom x) (denom y))))

;;;;;
(define (div-rat x y)
  (make-rat (* (numer x) (denom y))
            (* (denom x) (numer y)) ))

;;;;;
(define (equal-rat? x y)
  (= (* (numer y) (denom y))
     (* (numer y) (denom x))))

;;;;;

; selector and constructor

(define (make-rat n d) 
  (let ((g (gcd n d)))
    (cons (/ n g) (/ d g)) ))
(define (numer x) (car x))
(define (denom x) (cdr x))

;;;;;

; display rational_numbers

(define (print-rat x)
  (newline)
  (display (numer x))
  (display "/")
  (display (denom x)))

;;;;;
(define (gcb a b)
  (if (= b 0)
      a
      (gcb b (remainder a b)) ))
