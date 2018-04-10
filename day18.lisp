
(defun read-program (in)
  (coerce
   (loop for line = (read-line in nil)
         while line
         collect (with-input-from-string (in line)
                   (loop for sym = (read in nil)
                         while sym
                         collect sym)))
   'vector))

(defun lookup (sym &optional (which 'registers))
  (if (symbolp sym)
      (get which sym 0)
      sym))

(defun interpret-1 (program)
  (setf (symbol-plist 'registers) nil)
  (loop for pc = 0 then (1+ pc)
        while (< -1 pc (length program))
        for (op . args) = (aref program pc)
        do (ecase op
             (set (setf (get 'registers (car args)) (lookup (cadr args))))
             (snd (setf (get 'registers 'snd) (lookup (car args))))
             (add (incf (get 'registers (car args) 0) (lookup (cadr args))))
             (mul (setf (get 'registers (car args))
                        (* (get 'registers (car args) 0)
                           (lookup (cadr args)))))
             (mod (setf (get 'registers (car args))
                        (mod (get 'registers (car args) 0)
                             (lookup (cadr args)))))
             (rcv (unless (zerop (lookup (car args)))
                    (return-from interpret-1 (get 'registers 'snd 0))))
             (jgz (unless (zerop (lookup (car args)))
                    (incf pc (1- (lookup (cadr args)))))))))

(defun make-queue ()
  (let ((it (cons nil nil)))
    (setf (car it) it)))
(defun enqueue (item q)
  (prog1 q
    (setf (car q) (setf (cdar q) (cons item nil)))))
(defun dequeue (q)
  (prog1 (pop (cdr q))
    (unless (cdr q) (setf (car q) q))))
(defun queue-empty? (q) (null (cdr q)))
(defun queue-length (q) (length (cdr q)))

(defun interpret-2 (program)
  (declare (optimize (speed 3)))
  (setf (symbol-plist 'registers-0) (list 'pc 0 'p 0 'q (make-queue) 'blocked nil)
        (symbol-plist 'registers-1) (list 'pc 0 'p 1 'q (make-queue) 'blocked nil))
  (let ((reg-circle (list 'registers-0 'registers-1)))
    (setf (cddr reg-circle) reg-circle)
    (loop with n-sends = 0
          with reg-set = reg-circle
          for which = (car reg-set)
          for pc = (1- (incf (get which 'pc 0)))
          while (< -1 pc (length program))
          for (op . args) = (aref program pc)
          do (ecase op
               (set (setf (get which (car args)) (lookup (cadr args) which)))
               (snd
                (when (eql which 'registers-1) (incf n-sends)
                      (when (zerop (mod n-sends 1000000))
                        (format t "~&~A ~A ~A" n-sends
                                (queue-length (get 'registers-0 'q))
                                (queue-length (get 'registers-1 'q)))))
                (enqueue (lookup (car args) which) (get (cadr reg-set) 'q))
                (when (shiftf (get (cadr reg-set) 'blocked) nil)
                  (setf reg-set (cdr reg-set))))
               (add (incf (get which (car args) 0) (lookup (cadr args) which)))
               (mul
                (setf (get which (car args))
                          (* (get which (car args) 0)
                             (lookup (cadr args) which))))
               (mod (setf (get which (car args))
                          (mod (get which (car args) 0)
                               (lookup (cadr args) which))))
               (rcv
                (block rcv
                  (when (queue-empty? (get which 'q))
                    (decf (get which 'pc))
                    (when (and (get which 'blocked) (get (cadr reg-set) 'blocked))
                      (format t "~&deadlocked!")
                      (return-from interpret-2 n-sends))
                    (setf (get which 'blocked) t)
                    (setf reg-set (cdr reg-set))
                    (return-from rcv))
                  (setf (get which (car args)) (dequeue (get which 'q)))))
               (jgz
                (when (plusp (lookup (car args) which))
                  (incf (get which 'pc 0) (1- (lookup (cadr args) which))))))
          finally (return n-sends))))
