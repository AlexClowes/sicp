((lambda (n)
   ((lambda (fact)
      (fact fact n))
    (lambda (ft k)
      (if (= k 1)
        1
        (* k (ft ft (- k 1)))))))
 10)
; Evaluates to 3628800 = 10!

((lambda (n)
   ((lambda (fib)
      (fib fib n))
    (lambda (f k)
      (if (< k 2)
        k
        (+ (f f (- k 1))
           (f f (- k 2)))))))
 10)
; Analagous expression for Fibonacci numbers.

(define (f x)
  ((lambda (even? odd?)
     (even? even? odd? x))
   (lambda (ev? od? n)
     (if (= n 0) true (od? ev? od? (- n 1))))
   (lambda (ev? od? n)
     (if (= n 0) false (ev? ev? od? (- n 1))))))
