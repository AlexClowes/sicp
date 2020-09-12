; Exchanging the order of the nested mappings causes (queen-cols (- k 1)) to be
; evaluated board-size times when finding the possiblities for each column,
; instead of just once.
; So taking board-size to be 8, we ave to evaluate (queen-cols 8) once,
; (queen-cols 7) 8 times, (queen-cols 6) 64 times, and so on until
; (queen-cols 0), evaluated 8^8 = 1.6e7 times.
; So the puzzle is solved in time 8^8T.
