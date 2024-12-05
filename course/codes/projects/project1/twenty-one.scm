

(define (twenty-one strategy)
  (define (play-dealer customer-hand dealer-hand-so-far rest-of-deck)
    (cond ((> (best-total dealer-hand-so-far) 21) 1)
	  ((< (best-total dealer-hand-so-far) 17)
	   (play-dealer customer-hand
			(se dealer-hand-so-far (first rest-of-deck))
			(bf rest-of-deck)))
	  ((< (best-total customer-hand) (best-total dealer-hand-so-far)) -1)
	  ((= (best-total customer-hand) (best-total dealer-hand-so-far)) 0)
	  (else 1)))

  (define (play-customer customer-hand-so-far dealer-up-card rest-of-deck)
    (cond ((> (best-total customer-hand-so-far) 21) -1)
	  ((strategy customer-hand-so-far dealer-up-card)
	   (play-customer (se customer-hand-so-far (first rest-of-deck))
			  dealer-up-card
			  (bf rest-of-deck)))
	  (else
	   (play-dealer customer-hand-so-far
			(se dealer-up-card (first rest-of-deck))
			(bf rest-of-deck)))))

  (let ((deck (make-deck)))
    (play-customer (se (first deck) (first (bf deck)))
		   (first (bf (bf deck)))
		   (bf (bf (bf deck))))) )

(define (make-ordered-deck)
  (define (make-suit s)
    (every (lambda (rank) (word rank s)) '(A 2 3 4 5 6 7 8 9 10 J Q K)) )
  (se (make-suit 'H) (make-suit 'S) (make-suit 'D) (make-suit 'C)) )

(define (make-deck)
  (define (shuffle deck size)
    (define (move-card in out which)
      (if (= which 0)
	  (se (first in) (shuffle (se (bf in) out) (- size 1)))
	  (move-card (bf in) (se (first in) out) (- which 1)) ))
    (if (= size 0)
	deck
    	(move-card deck '() (random size)) ))
  (shuffle (make-ordered-deck) 52) )

; The procedure is takes a hand (a sentence of card words) as argument,
; and returns the total number of points in the hand.
;
; The procedure should return the largest possible total that's less
; than or equal to 21, if possible.
; 
; (best-total '(ad 8s)) ; 19
; (best-total '(ad 8s 5h)) ; 14
; (best-total '(ad as 9h)) ; 21

(define (best-total hands)
  (define (the-rank hands)
    (every bl hands))

  ; (hand-worth '(8 9)) ;(17)
  ; (hand-worth '(a a 8)) ;(10 20 20 30)
  (define (hand-worth hands)
    (define (add num sent)
      (every (lambda (n) (+ n num)) sent))
    (cond ((empty? hands) 0)
          ((equal? 'a (first hands))
           (se (add 1 (hand-worth (bf hands)))
           (add 11 (hand-worth (bf hands)))))
          ((member? (first hands) '(j q k))
           (add 10 (hand-worth (bf hands))))
          (else (add (first hands) (hand-worth (bf hands))))) )
  
  ; (close-to-21 '(10 20 20 30)) ;20
  (define (close-to-21 sent)
    (define (close last next standard)
      (cond ((> last standard) next)
            ((> next standard) last)
            ((> (abs (- standard next))
                (abs (- standard last)))
             last)
            (else next)))
    
    (if (= (count sent) 1) 
        (first sent)
        (close (first sent) (first (bf sent)) 21)))
  
  (close-to-21 (hand-worth (the-rank hands))) )

; This procedure is a strategy named stop-at-17
; that's identical to the dealer's

(define (stop-at-17 customer-hand-so-far dealer-up-card)
  (<= (best-total customer-hand-so-far) 17))

; This procedure is a strategy that "hits" (takes a card) if (and only if)
; the dealer has an ace, 7, 8, 9, 10, or picture card showing, and the 
; customer has less than 17, or the dealer has a 2, 3, 4, 5, or 6 showing,
; and the customer has less than 12.

(define (dealer-sensitive customer-hand-so-far dealer-up-card)
  (define (include? sent1 sent2)
    (cond ((empty? sent1) #f)
          ((member? (first sent1) sent2) #t)
          (else (include? (bf sent1) sent2))) )
  (cond ((and (include? dealer-up-card '(7 8 9 10 j q k))
              (<= (best-total customer-hand-so-far) 17)) #t)
        ((and (include? dealer-up-card '(2 3 4 5 6))
              (<= (best-total customer-hand-so-far) 12)) #t)
        (else #f)) )

; This procedure plays n games with a given strategy
; and returns the number of games that the customer
; won minus the number that s/he lost.

(define (play-n strategy n)
  (define (keep-the-score strategy total count)
    (if (<= count 0) 
        total
        (keep-the-score strategy (+ total (twenty-one strategy)) (- count 1))))
  (keep-the-score strategy 0 n))

; Generalize part 2 above by defining a function stop-at.

(define (stop-at n)
  (lambda (customer-hand-so-far dealer-up-card) 
    (<= (best-total customer-hand-so-far) n)))

; If you win a round of 21 with a heart in your hand, they
; pay double.
; 
; The valentine strategy that stops at 17 unless you have
; a heart in your hand, in which case it stops at 19.

; (play-n valentine 20) ; -5
(define (valentine customer-hand-so-far dealer-up-card)
  (define (keep-suit hands)
    (every last hands))
  (if (member? 'h (keep-suit customer-hand-so-far))
      ((stop-at 19) customer-hand-so-far dealer-up-card)
      ((stop-at 17) customer-hand-so-far dealer-up-card)) )


; The suit-strategy takes three arguments:
;   a suit (h, s, d, or c),
;   a strategy to be used if you hand doesn't include that suit,
;   and a strategy to be used if your hand does include that suit.

; (play-n (suit-strategy 'h (stop-at 19) (stop-at 17)) 20)
(define (suit-strategy suit dont does)
  (define (keep-suit hands)
    (every last hands))
  (lambda (customer-hand-so-far dealer-up-card)
    (if (member? suit (keep-suit customer-hand-so-far))
        (dont customer-hand-so-far dealer-up-card)
        (does customer-hand-so-far dealer-up-card))) )
  
; The majority function is takes three strategies as arguments and 
; produces a strategy as a result, such that the result strategy
; always decides whether or not to "hit" by consulting the three
; argument strategies, and going with the majority. 
; 
; That is, the result strategy should return #t if and only if at 
; least two of the three argument strategies do. 

; (majority stop-at-17 dealer-sensitive valentine)
(define (majority strategy1 strategy2 strategy3)
  (>= (+ (twenty-one strategy1)
         (twenty-one strategy2)
         (twenty-one strategy3))
      2))

; The reckless procedure that takes a strategy as its argument
; and return another strategy. This new strategy should take
; one more card than the original would.

; (play-n (reckless (stop-at 17)) 20) ; -5
(define (reckless strategy)
  (lambda (customer-hand-so-far dealer-up-card)
          (not (strategy customer-hand-so-far dealer-up-card))) )


























;                                      32
