(defun looop (bins)
  (let ((seen (make-hash-table)))
    (loop for hash = (reduce (lambda (h b) (logior (ash h 8) b)) bins)
          for next = (position (reduce #'max bins) bins)
          for count from 0
          until (shiftf (gethash hash seen) t)
          do (loop repeat (shiftf (aref bins next) 0)
                   for i from (1+ next)
                   do (incf (aref bins (logand i (1- (length bins))))))
          finally (return (values count bins)))))

(defun main (bins)
  (multiple-value-bind (count bins) (looop (copy-seq bins))
    (format t "~&part 1: ~A~&part 2: ~A~%" count (looop bins))))

(main (with-open-file (in "day6.in")
        (coerce (loop for x = (read in nil) while x collect x) 'vector)))
