; Procedure p is applied 5 times, since 12.15 / 3^4 > 0.1 > 12.15 / 3^5.

; The procedure p must be applied n times, where n is the smallest integer such
; that a / 3^n <= 0.01, i.e. n = ceil(log(10 * a) / log(3)). So the order of
; growth in space and the number of steps is O(log(a)).
