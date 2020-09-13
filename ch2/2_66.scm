(define (lookup given-key set-of-records)
  (if (null? set-of-records)
    false
    (let ((current-key (key (entry (set-of-records)))))
      (cond ((= given-key current-key) (entry (set-of-records)))
            ((< given-key current-key)
             (lookup given-key (left-branch set-of-records)))
            (else (lookup given-key (right-branch set-of-records)))))))
