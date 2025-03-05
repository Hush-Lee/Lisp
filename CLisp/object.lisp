(defparameter *account-numbers* 0)


(defclass bank-account()
   ((customer-name
    :initarg :customer-name
    :initform (eeror "Must supply a cutomer name."))
    (balance
     :initarg :balance
     :initform 0)
    (account-number
     :initform  (incf *account-numbers*))
    account-type))

(defmethod initialize-instance :after((account bank-account) &key)
	   (let ((balance (slot-value account 'balance)))
	     (setf (slot-value account 'account-type)
		   (cond
		    ((>= balance 100000) :gold)
		    ((>= balance 50000) :sliver)
		    (t :bronze)))))
;; 定义基类 Animal
(defclass animal ()
  ((name
    :initarg :name
    :accessor name
    :documentation "The animal's name")))

;; 定义 Dog 子类
(defclass dog (animal)
  ((breed
    :initarg :breed
    :accessor breed
    :documentation "Dog breed")))

;; 定义 Cat 子类
(defclass cat (animal)
  ((color
    :initarg :color
    :accessor color
    :documentation "Fur color")))

;; 定义泛型函数（类似接口）
(defgeneric make-sound (animal)
  (:documentation "Produce animal's sound"))

(defgeneric described (animal)
  (:documentation "Describe the animal"))

;; 为 Animal 类实现方法
(defmethod make-sound ((a animal))
  "Some generic animal sound!")

(defmethod described ((a animal))
  (format t "Animal named ~a" (name a)))

;; 为 Dog 类重写方法
(defmethod make-sound ((d dog))
  "Woof!")

(defmethod described ((d dog))
  (format t "~a: ~a dog (~a)"
          (name d)
          (breed d)
          (call-next-method)))  ;; 调用父类方法

;; 为 Cat 类重写方法
(defmethod make-sound ((c cat))
  "Meow!")

(defmethod described ((c cat))
  (format t "~a: ~a cat (~a)"
          (name c)
          (color c)
          (call-next-method)))

;; 使用示例
(let ((my-pet1 (make-instance 'dog
                              :name "Rex"
                              :breed "Husky"))
      (my-pet2 (make-instance 'cat
                              :name "Luna"
                              :color "Black")))
  ;; 多态行为演示
  (dolist (animal (list my-pet1 my-pet2))
    (terpri)
    (format t "Sound: ~a" (make-sound animal))
    (terpri)
    (described animal)))
