(defun position-of (lim)
  (loop for n = 1 then (+ n m)
        for p = 0 then (+ p (* m d))
        for d = #C(1 0) then (* d #C(0 1))
        for i from 0
        for m = (min (1+ (floor i 2)) (- lim n))
        while (< n lim)
        finally (return p)))

(defun manhattan-distance (c) (+ (abs (realpart c)) (abs (imagpart c))))

(defun part-1 (n) (manhattan-distance (position-of n)))

(defun neighbors (p)
  (loop for i in '(#C(-1 -1) -1 #C(-1 1) #C(0 -1) #C(0 1) #C(1 -1) 1 #C(1 1))
        collect (+ p i)))

(defun part-2 (limit)
  (let ((v (make-hash-table)))
    (setf (gethash 0 v) 1)
    (loop with p = 1
          for i from 1
          for d = #C(0 1) then (* d #C(0 1))
          do (loop repeat (1+ (floor i 2))
                   for sum = (loop for n in (neighbors p) sum (gethash n v 0))
                   do (setf (gethash p v) sum p (+ p d))
                   when (> sum limit) do (return-from part-2 sum)))))

(defun test ()
  (assert (= 31 (part-1 1024)))
  (assert (= 806 (part-2 805))))
