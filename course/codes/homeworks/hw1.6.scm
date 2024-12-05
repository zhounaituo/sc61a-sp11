; The mission is to devise a test that will tell you whether Scheme's `and` 
; and `or` are special forms or ordinary functions.

(define x 0) 
(or (= x 0) (= y 0) (= z 0)) ; #t
(and (= x 1) (= y 0) (= z 0)) ; #f

; Why might it be advantageous for an interpreter to treat 
; or as a special form and evaluate its arguments one at a time?
; 
; Answer: Special forms can save computational resources.

; Can you think of reasons why it might be advantageous to
; treat or as an ordinary function?
; 
; Answer: The ordinary functions is more consistent with 
; the expectation of the user, for example, 
;  
; (or #t ...) 
; 
; As long as the first condition is true, no subsequent 
; conditions (i.e. syntax errors) are considered.
