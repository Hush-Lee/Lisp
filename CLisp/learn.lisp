(Defun hello-world()
  (format t "hello world"))


(defvar *db* nil)

(defun add-record(cd)
  (push cd *db*))

(defun make-cd(title artist rating ripped)
  (list :title title :artist artist :rating rating :ripped ripped))

(add-record (make-cd "Roses" "Kathy Matted" 7 t))

(add-record (make-cd "Fly" "Dixie Chicks" 8 t))

(add-record (make-cd "Home" "Dixie Chicks" 9 t))

(defun dump-db()
  (do-list (cd *db*)
    (format t "~{~a: ~10t~a~%~%}~%" cd)))

(defun prompt-read (prompt)
  (format *query-io* "~a: " prompt)
  (force-output *query-io*)
  (read-line *query-io*))

(defun prompt-for-cd ()
  (make-cd
   (prompt-read "Title")
   (prompt-read "Artist")
   (or (parse-integer (prompt-read "Rating") :junk-allowed t) 0)
   (y-or-n-P "Rippeed[y/n]")))

(defun save-db(filename)
  (with-open-file(out filename
		      :drection :output
		      :if-exists :spersede)
    (with-standard-io-syntax (print *db* out))))

(defun load-db (filename)
  (with-open-file (in filenam)
    (with-standard-io-syntax
      (setf *db* (read in)))))

(defun where (&key title artist rating (ripped nil ripped-p))
  #'(lambda (cd)
      (and
       (if title (equal (getf cd :title) title) t)
       (if artist (equal (getf cd :artist) artist) t)
       (if rating (equal (getf cd :ratinf) rating) t)
       (if ripped-p (equal (getf cd :ripped) ripped) t))))
(defun select (selector-fn)
  (remove-if-not selector-fn *db*))

(defun update (selector-fn &key title artist rating (ripped nil ripped-p))
  (setf *db*
	(mapcar
	 #'(lambda (row)
	     (when (funcall selector-fn row)
	       (if title (setf (getf row :title) title))
	       (if artist (setf (getf row :artist) artist))
	       (if rating (setf (getf row :rating) rating))
	       (if ripped-p (setf (get row :ripped) ripped)))
	     row) *db*)))

 (defun foo(x)
	   (format t "Parameter: ~a~%" x)
	   (let ((x 2))
	     (format t "Outer LET: ~a~%" x)
	     (let ((x 3))
	       (format t "Inner LET: ~a~%" x))
	     (format t "Outer LET :~a~%" x))
   (format t "Parameter: ~a~%" x))

;;do循环计算Fibonacci数列
(defun fib (f)
 (do ((n 0 (1+ n))
	      (cur 0 next)
	      (next 1 (+ cur next)))
	     ((= f n) cur)))

(defun primep (number)
  (when (> number 1)
    (loop for fac from 2 to (isqrt number) never (zerop (mod number fac)))))

(defun next-prime (number)
  (loop for n from number when (primep n) return n))

(defmacro my-do-primes (p from a to b &rest body)
  `(do ((,p (next-prime ,a) (next-prime (1+ ,p))))
       ((> ,p ,b))
     ,@body))

(defmacro do-primes (var-and-range &rest body)
  (let ((var (first var-and-range))
	(start (second var-and-range))
	(end (third var-and-range)))
    `(do ((,var (next-prime ,start) (next-prime (1+ ,var))))
	 ((> ,var ,end))
       ,@body)))
