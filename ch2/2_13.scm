; Suppose quantities x and y lie in intervals with centres x_0, y_0 and
; percentage tolerances p_x, p_y respectively. Then
; (1 - p_x) * (1 - p_y) * x_0 * y_0 < x * y < (1 + p_x) * (1 + p_y) * x_0 * y_0
; If p_x and p_y are small, then p_x * p_y is very small and can be neglected.
; So approximately,
; (1 - p_x - p_y) * x_0 * y_0 < x * y < (1 + p_x + p_y) * x_0 * y_0.
; This is equivalent to x * y lying in an interval with center x_0 * y_0 and
; percentage tolerance p_x + p_y.
