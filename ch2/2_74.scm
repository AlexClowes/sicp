; Assume that each division has implemented two procedures:
; 1. get-record, which takes a personnel file and  employee name and returns
;    the record for that employee.
; 2. get-salary, which takes an employee record and returns the salary.
; Further assume that each division has stored these procedures in a table,
; indexed by the division name, and procedure name.

; Assume we have a procedure division that obtains the division corresponding
; to a personnel file
(define (get-record file employee-name)
  ((get (division file) 'get-record) employee-name))

; Assume that the division is a tag on the record.
(define (get-salary record)
  (let ((division (car record))
        (record-content (cdr record)))
    ((get division 'get-salary) record-content)))

(define (find-employee-record file-list employee-name)
  (if (null? file-list)
    #f
    (let ((get-record-proc (get (division (car file-list)) 'get-record)))
      (if get-record-proc
        (get-record-proc employee-name)
        (find-employee-record (cdr file-list) employee-name)))))

; A new division would need to implement the required procedures, and also a
; procedure to add these procedures to the table. No changes should be required
; to the code above however.
