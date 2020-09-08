; Suppose x ∈ [x_0 - w_x, x0 + w_x], y ∈ [y_0 - w_y, y0 + w_y].
; So x, y lie in intervals with widths w_x, w_y respectively.

; Then the width of the interval containing x + y is
; ((x_0 + w_x + y_0 + w_y) - (x_0 - w_x + y_0 - w_y)) / 2
; = w_x + w_y

; The width of the interval containing x - y is
; ((x_0 + w_x - y_0 + w_y) - (x_0 - w_x - y_0 - w_y)) / 2
; = w_x + w_y

; The width of the interval containing x * y is
; ((x_0 + w_x) * (y_0 + w_y) - (x_0 - w_x) * (y_0 - w_y)) / 2
; = x_0 * w_y + y_0 * w_x

; The width of the interval containing x / y is
; ((x_0 + w_x) / (y_0 - w_y) - (x_0 - w_x) / (y_0 + w_y)) / 2
; = (x_0 * w_y + y_0 * w_x) / (2 * (y_0^2 - w_x^2))
