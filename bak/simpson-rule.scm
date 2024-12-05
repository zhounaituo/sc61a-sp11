(define (simpson-rule f a b n)
    (define h (/ (- b a) (* 3 n)))
    (define (add-h x)
        (+ x h))
    (* (sum f (+ a (* k h)) add-h b) h))

(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a)
         (sum term (next a) next b))))

(define (cube x) (* x x x))
