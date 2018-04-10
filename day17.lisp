
(defun simulate (n-steps &optional (goal 2017))
  (declare (optimize (speed 3) (space 3) (safety 0) (debug 0)))
  (let ((buf (list 0)))
    (setf (cdr buf) buf)
    (loop for i fixnum from 1 upto goal
          with p = buf
          do (loop for step fixnum below n-steps
                   do (setf p (cdr p)))
             (setf (cdr p) (cons i (cdr p))
                   p (cdr p))
          finally (return (values (cadr p) (cadr buf))))))
