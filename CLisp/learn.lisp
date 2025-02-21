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
