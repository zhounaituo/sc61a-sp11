; Write a procedure squares that takes a sentence of numbers as its argument and
; returns a sentence of the squares of the numbers:

; (squares '(2 3 4 5)) ; (4 9 16 25)
(define (squares sent)
  (define (square num)
    (* num num))
  (if (empty? sent)
      '()
      (se (square (first sent)) (squares (bf sent)))) )
