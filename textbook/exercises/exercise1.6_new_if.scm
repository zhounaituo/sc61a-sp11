; Exercise 1.6: Alyssa P. Hacker doesn’t see why if needs to be 
; provided as a special form. “Why can’t I just define it as an 
; ordinary procedure in terms of cond?” she asks. Alyssa’s friend 
; Eva Lu Ator claims this can indeed be done, and she defines a 
; new version of if:

; 这里按照 application order 来解答。
; 在应序求值时，会在调用过程时，有限求出参数的值，那么，`new-if` 作为一个过程，
; 它本身失去 `cond` 的特殊形式的功能（不会马上求值）。所以，在 `new-if` 判定前
; 就不停的递归，导致无限循环。

(define (new-if predicate then-clause else-clause)
  (cond (predicate then-clause)
        (else else-clause)))

(define (sqrt-iter guess x)
  (new-if (good-enough? guess x)
          guess
          (sqrt-iter (improve guess x) x)))

(define (improve guess x)
  (average guess (/ x guess)))

(define (average x y)
  (/ (+ x y) 2))

(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))

(define (square x) (* x x))
