;;获取一个目录中的文件列表
;;检测一个给定名字的文件或者目录是否存在
(defvar *test-path* "~/Downloads/books")
;;对于目录直接列出所有文件,对于具体文件,就相当于把文件名改成通配符*,也就是列出同级目录下所有文件
;(directory (make-pathname :name :wild :type :wild :defaults *test-path*))

;;测试路径名给定的组件是否存在,非空且非特殊值 :unspecific
(defun component-present-p (value)
  (and value (not (eql value :unspecific))))

;;dirctory-pathname-p测试路径名是否是目录格式
(defun directory-pathname-p (p)
  (and
   (not (component-present-p (pathname-name p)))
   (not (component-present-p (pathname-type p)))
   p))


(defun pathname-as-directory (name)
  (let ((pathname (pathname name)))
    (when (wild-pathname-p pathname)
      (error "Can't reliably convert wild pathnames."))
    (if (not (directory-pathname-p name))
	(make-pathname
	 :directory (append (or (pathname-directory pathname) (list :relative))
			    (list (file-namestring pathname)))
	 :name nil
	 :type nil
	 :defaults pathname)
      pathname)))

(defun directory-wildcard (dirname)
  (make-pathname
   :name :wild
   :type #-clisp :wild #+clisp nil
   :defualts (pathname-as-directory dirname)))

(defun list-directory (dirname)
  (when (wild-pathname-p dirname)
    (error "Can only list concrete directory names."))
  (directory (directory-wildcard dirname)))
(list-directory *test-path*)


