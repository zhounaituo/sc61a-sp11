; Exercise 2.5. Show that we can represent pairs of 
; nonnegative integers using only numbers and arithmetic 
; operations if we represent the pair a and b as the 
; integer that is the product 2^a*3^b. Give the corresponding 
; definitions of the procedures cons, car, and cdr.

; The cons function constructs a pair by computing 2^a * 3^b.
(define (cons a b)
    (* (expt 2 a) (expt 3 b)))

; The car function retrieves the first element a from the pair
; by extracting the exponent of 2.
(define (car x)
    (exponent 2 x))

; The car function retrieves the first element a from the pair
; by extracting the exponent of 3.
(define (cdr x)
    (exponent 3 x))

; The exponent function calculates the exponent of the given 
; base in the result.
(define (exponent base res)
    (exponent-helper base res 0))

(define (exponent-helper base res i)
    (if (> (remainder res base) 0)
        0
        (+ 1 i (exponent-helper base (/ res base) i) )))