; Write a procedure **substitute** that takes three arguments: a 
; list, an old word, and a new word. It should return a copy of 
; the list, but with every occurrence of the old word replaced 
; by the new word, even in sublists. For example:

; > (substitute 
;       '((lead guitar) (bass guitar) (rhythm guitar) drums)
;       'guitar 'axe)

; ((lead axe) (bass axe) (rhythm axe) drums)

;;;;;
; substitute 1st version
(define (substitute ls old new)
    (rec (lambda (x) (if (equal? x old) new x)) ls))


(define (rec fx ls)
    (cond ((null? ls) nil)
          ((list? ls) (cons (rec fx (car ls)) (rec fx (cdr ls))))
          (else (fx ls))))

; Now write substitute2 that takes a list, a list of old words, 
; and a list of new words; the last two lists should be the same 
; length. It should return a copy of the first argument, but 
; with each word that occurs in the second argument replaced by 
; the corresponding word of the third argument:

; > (substitute2 
;       '((4 calling birds) (3 french hens) (2 turtle doves))
;       '(1 2 3 4) '(one two three four))

; ((four calling birds) (three french hens) (two turtle doves))

;;;;;
(define (substitute2 ls old new)
    (rec (lambda (x) (if (member? x old)
                         (find (index x old) new)
                         x)) ls))

; return the index of member
(define (index m ls)
    (if (equal? m (car ls))
        0
        (+ 1 (index m (cdr ls)))))

; find member by index
(define (find i ls)
    (cond ((null? ls) nil)
          ((= i 0) (car ls))
          (else (find (- i 1) (cdr ls)))))

; Write the procedure cxr-function that takes as its argument a 
; word starting with c, ending with r, and having a string of ;
; letters a and/or d in between, such as cdddadaadar. It should 
; return the corresponding function.
