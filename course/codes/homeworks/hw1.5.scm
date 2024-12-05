; Write a procedure ends-e that takes a sentence as its argument and returns a sentence
; containing only those words of the argument whose last letter is E

; (ends-e '(please put the salami above the blue elephant))
; (please the above the blue)

(define (ends-e sent)
  (cond ((empty? sent) '())
        ((equal? 'e (last (first sent)))
          (se (first sent) (ends-e (bf sent))))
        (else (ends-e (bf sent))))) 

