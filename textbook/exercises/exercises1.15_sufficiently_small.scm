(def (cube x) (* x x x))
(def (p x) (- (* 3 x) (* 4 (cube x))))
(def (sine angle)
  (if (not (> (abs angle) 0.1))
      angle
      (p (sine (/ angle 3.0))) ))

