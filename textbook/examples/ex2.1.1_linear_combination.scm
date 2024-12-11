(define (line-combination a b x y)
    (+ (* a x) (* b y)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; version 2 

(define (line-combination a b x y)
    (add (mul a x) (mul b y)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;