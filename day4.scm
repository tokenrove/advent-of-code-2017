(use-modules (ice-9 rdelim) (srfi srfi-1))

(define (valid-line? line f)
  (reduce (lambda (x y) (and y (not (equal? x y)) x)) #f
          (f (string-split line #\Space))))

(define (valid-lines f)
  (call-with-input-file "day4.in"
    (lambda (port)
      (let loop ((sum 0) (line (read-line port)))
        (if (eof-object? line) sum
            (loop (+ sum (if (valid-line? line f) 1 0)) (read-line port)))))))

(define (sort-chars s) (list->string (sort (string->list s) char<?)))

(format #t "~A~%~A~%"
        (valid-lines (lambda (words) (sort words string<)))
        (valid-lines (lambda (words) (sort (map sort-chars words) string<))))
