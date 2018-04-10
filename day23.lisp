
(defun read-program (in)
  (coerce
   (loop for insn = (read in nil)
         while insn
         collect (list insn (read in) (read in)))
   'vector))

(defun interp-program (program &key (limit 1000) (initial-a 1))
  (let ((pc 0) (n-muls 0))
    (dolist (s '(a b c d e f g h)) (setf (symbol-value s) 0))
    (setf (symbol-value 'a) initial-a)
    (loop ;; for i below limit
          while (< -1 pc (length program))
          for insn = (aref program pc)
          do (incf pc)
             (when (= pc 24)
               (format t "~&~A: ~A: ~A ~A ~A ~A ~A ~A ~A ~A"
                       pc insn a b c d e f g h)
               (when (zerop (decf limit)) (return-from interp-program)))
             (destructuring-bind (op x y) insn
               (when (symbolp y) (setf y (symbol-value y)))
               (ecase op
                 (set (setf (symbol-value x) y))
                 (sub (decf (symbol-value x) y))
                 (mul
                  (setf (symbol-value x) (* y (symbol-value x)))
                  (incf n-muls))
                 (jnz
                  (unless (zerop (if (symbolp x) (symbol-value x) x))
                    (incf pc (1- y)))))))
    (values n-muls h)))

;; +/ 0 p: (108400 + 17*i.1001)
(defun it (init c)
  (loop for b from init upto c by 17
        sum (if (evenp b) 1
                (loop for d from 3 below b by 2
                      do (when (zerop (mod b d)) (return 1))
                      finally (return 0))) into s
        finally (return s)))
