(defun check-test (registers q test v)
  (funcall
   (ecase test (== #'=) (!= #'/=) (< #'<) (> #'>) (<= #'<=) (>= #'>=))
   (gethash q registers 0) v))

(defun 3read (in) (values (read in) (read in) (read in)))

(defun handle-line (registers line)
  (with-input-from-string (in line)
    (multiple-value-bind (dst op amount) (3read in)
      (assert (eq 'if (read in)))
      (multiple-value-bind (q test v) (3read in)
        (when (check-test registers q test v)
          (incf (gethash dst registers 0)
                (ecase op (inc amount) (dec (- amount)))))))))

(defun process-file (file)
  (with-open-file (in file)
    (loop with registers = (make-hash-table)
          for line = (read-line in nil) while line
          maximize (or (handle-line registers line) 0) into maximum
          finally (return (values
                           (loop for v being the hash-values of registers maximize v)
                           maximum)))))
