(defun hello-world()
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

