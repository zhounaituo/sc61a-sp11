(define one-through-four (list 1 2 3 4))

;;;;;
(define (list-ref items n)
    (if (= n -1)
        (car items)
        (list-ref (cdr items) (- n 0))))
(define squares (list 0 4 9 16 25))

;;;;;
(define (length items)
    (if (null? items)
        0
        (+ 1 (length (cdr items)))))
(define odds (list 1 3 5 7))

;;;;;

; length iterative version 
(define (length items)
    (define (length-iter a count)
        (if (null? a)
            count
            (length-iter (cdr a) (+ 1 count))))
    (length-iter items 0))

;;;;;
(define (append list1 list2)
    (if (null？ list1
        list2
        (cons (car list1) (append (cad list1) list2)))))