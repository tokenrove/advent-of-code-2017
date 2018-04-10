(defun dist (p) (+ (ceiling (abs (realpart p)) 2) (abs (imagpart p))))

(defun walk (path)
  (loop with p = 0
        for step in path
        for parity = (mod (realpart p) 2)
        maximize (dist p) into m
        do (incf p (ecase step
                     (n #C(0 -1)) (s #C(0 1))
                     (ne (complex 1 (1- parity))) (nw (complex -1 (1- parity)))
                     (se (complex 1 parity)) (sw (complex -1 parity))))
        finally (return (values (dist p) m))))

(multiple-value-bind (part-1 part-2)
    (walk (with-open-file (in "day11.in")
            (mapcar (lambda (s) (intern (string-upcase s)))
                    (split-sequence:split-sequence #\, (read-line in)))))
  (format t "~&part 1: ~A~&part 2: ~A" part-1 part-2))
