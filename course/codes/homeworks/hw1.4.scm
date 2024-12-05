; Write a predicate ordered?  takes a sentence of numbers as its argument and
; returns a true value if the numbers are in ascending order, or a false value otherwise.

; (ordered? '(1 2 3 4 5 6 7))
; (ordered? '(1 2 4 5 3 8 7))
(define (ordered? sent)
  (if (<= (count sent) 1)
      #t
      (and (>= (first (bf sent)) (first sent))
           (ordered? (bf sent)))) )

