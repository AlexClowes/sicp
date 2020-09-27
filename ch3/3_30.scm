(define (logical-not s) (- 1 s))

(define (inverter input output)
  (define (invert-input)
    (let ((new-value (logical-not (get-signal input))))
      (after-delay inverter-delay
                   (lambda () (set-signal! output new-value)))))
  (add-action! input invert-input)
  'ok)
; Delay is inverter-delay.

(define (logical-and x y) (* x y))

(define (and-gate a1 a2 output)
  (define (and-action-procedure)
    (let ((new-value (logical-and (get-signal a1) (get-signal a2))))
      (after-delay and-gate-delay
                   (lambda () (set-signal! output new-value)))))
  (add-action! a1 and-action-procedure)
  (add-action! a2 and-action-procedure)
  'ok)
; Delay is and-gate-delay.

(define (logical-or x y) (- (+ x y) (* x y)))

(define (or-gate o1 o2 output)
  (define (or-action-procedure)
    (let ((new-value (logical-or (get-signal o1) (get-signal o2))))
      (after-delay or-gate-delay
                   (lambda () (set-signal! output new-value)))))
  (add-action! o1 or-action-procedure)
  (add-action! o2 or-action-procedure)
  'ok)
; Delay is or-gate-delay.

(define (half-adder a b s c)
  (let ((d (make-wire))
        (e (make-wire)))
    (or-gate a b d)
    (and-gate a b c)
    (inverter c e)
    (and-gate d e s)
    'ok))
; Delay for s is and-gate-delay + max(or-gate-delay, and-gate-delay + inverter-delay).
; Delay for c is and-gate-delay.

(define (full-adder a b c-in sum c-out)
  (let ((s (make-wire))
        (c1 (make-wire))
        (c2 (make-wire)))
    (half-adder b c-in s c1)
    (half-adder a s sum c2)
    (or-gate c1 c2 c-out)
    'ok))
; Delay for sum is 2 * (and-gate-delay + max(or-gate-delay, and-gate-delay + inverter-delay)).
; Delay for c-out is or-gate-delay + 2 * and-gate-delay + max(or-gate-delay, and-gate-delay + inverter-delay).

(define (ripple-carry-adder A-list B-list C S-list)
  (if (not (null? A-list))
    (let ((intermediate-carry (make-wire)))
      (full-adder (car A-list) (car B-list) C (car S-list) intermediate-carry)
      (ripple-carry-adder (cdr A-list) (cdr B-list) intermediate-carry (cdr S-list)))))
; Delay for Sn is
; (n - 1) * or-gate-delay + 2n * and-gate-delay
; + (n + 1) * max(or-gate-delay, and-gate-delay + inverter-delay).
