; SLIME 2.31
CL-USER> (defclass circle ()
  ((radius :initarg :radius :accessor radius)))

(defmethod area ((shape circle))
  (* 3.14 (expt (radius shape) 2)))

(let ((c (make-instance 'circle :radius 5)))
  (area c)) 
78.5
CL-USER> (plusp)
; Evaluation aborted on #<SB-INT:SIMPLE-PROGRAM-ERROR "invalid number of arguments: ~S" {100205CA63}>.
CL-USER> (evel (plusp))
; in: EVEL (PLUSP)
;     (PLUSP)
; 
; caught WARNING:
;   The function PLUSP is called with zero arguments, but wants exactly one.
; in: EVEL (PLUSP)
;     (EVEL (PLUSP))
; 
; caught STYLE-WARNING:
;   undefined function: COMMON-LISP-USER::EVEL
; 
; compilation unit finished
;   Undefined function:
;     EVEL
;   caught 1 WARNING condition
;   caught 1 STYLE-WARNING condition
; Evaluation aborted on #<SB-INT:SIMPLE-PROGRAM-ERROR "invalid number of arguments: ~S" {100265D853}>.
CL-USER> (let ((x 10))
	   (plusp x))
T
CL-USER> (let ((x 11))
	   (plusp x))
T
CL-USER> (let ((x -11))
	   (plusp x))
NIL
CL-USER> (let ((x 0))
	   (plusp x))
NIL
CL-USER> (incf 4 3)
; in: INCF 4
;     (SETQ 4 #:NEW222)
; 
; caught ERROR:
;   Variable name is not a symbol: 4.

;     (#:NEW222 (+ 3 4))
; 
; caught STYLE-WARNING:
;   The variable #:NEW222 is defined but never used.
; 
; compilation unit finished
;   caught 1 ERROR condition
;   caught 1 STYLE-WARNING condition
; Evaluation aborted on #<SB-INT:COMPILED-PROGRAM-ERROR {10045181D3}>.
CL-USER> (let ((x 10))
	   (incf x 2))
12
CL-USER> (let ((x 10))
	   (incf x 2))
12
CL-USER> (let ((x 10))
	   (incf x 2))
12
CL-USER> (let ((x 10))
	   (incf x 2) )
12
CL-USER> (let ((x 10))
	   (incf x 2)
	   (format t "~d " x))
12 
NIL
CL-USER> (defclass shape()
	   (color
	    :initarg :color
	    :initform :black
	    :accessor color))
; Evaluation aborted on #<SB-INT:SIMPLE-PROGRAM-ERROR "~@<In DEFCLASS ~S, the slot name ~S is ~A.~@:>" {1004EDA6E3}>.
CL-USER> (defclass shape()
	   ((color
	    :initarg :color
	    :initform :black
	    :accessor color)))
#<STANDARD-CLASS COMMON-LISP-USER::SHAPE>
CL-USER> (defclass circle(shape)
	   ((radius
	     :initarg :radius
	     :type number
	     :reader radius)))
#<STANDARD-CLASS COMMON-LISP-USER::CIRCLE>
CL-USER> (defclass rectangle(shape)
	   ((width :initarg :width :accessor width)
	    (height :initarg :height :accessor height)))
#<STANDARD-CLASS COMMON-LISP-USER::RECTANGLE>
CL-USER> (defgeneric area(shape)
	   (:documentation "计算图形面积"))
WARNING: redefining COMMON-LISP-USER::AREA in DEFGENERIC
#<STANDARD-GENERIC-FUNCTION COMMON-LISP-USER::AREA (1)>
CL-USER> (defmethod area((s circle))
	   (* pi (* radius radius)))
; in: DEFMETHOD AREA (CIRCLE)
;     (* RADIUS RADIUS)
; 
; caught WARNING:
;   undefined variable: COMMON-LISP-USER::RADIUS
; 
; compilation unit finished
;   Undefined variable:
;     RADIUS
;   caught 1 WARNING condition
WARNING:
   redefining AREA (#<STANDARD-CLASS COMMON-LISP-USER::CIRCLE>) in DEFMETHOD
#<STANDARD-METHOD COMMON-LISP-USER::AREA (CIRCLE) {1000BF3EA3}>
CL-USER> (defmethod area((s circle))
	   (* pi (expt (radius s) 2)))
WARNING:
   redefining AREA (#<STANDARD-CLASS COMMON-LISP-USER::CIRCLE>) in DEFMETHOD
#<STANDARD-METHOD COMMON-LISP-USER::AREA (CIRCLE) {1000CBB1B3}>
CL-USER> (defmethod area((r rectangle))
	   (* (width r) (height r)))
#<STANDARD-METHOD COMMON-LISP-USER::AREA (RECTANGLE) {1000D7A883}>
CL-USER> (defgeneric intersection-area (shape1 shape2))
#<STANDARD-GENERIC-FUNCTION COMMON-LISP-USER::INTERSECTION-AREA (0)>
CL-USER> (defmethod intersection-area ((c circle) (s rectangle))
	   (* 0.8 (area c)))
#<STANDARD-METHOD COMMON-LISP-USER::INTERSECTION-AREA (CIRCLE RECTANGLE) {1000EA4CB3}>
CL-USER> (defmethod intersection-area ((r rectangle) (c circle))
	   (intersection-area c r))
#<STANDARD-METHOD COMMON-LISP-USER::INTERSECTION-AREA (RECTANGLE CIRCLE) {1000F1FB53}>
CL-USER> (defparameter *my-circle*
	   (make-instance 'circle :color red :radius 4.0))
; Evaluation aborted on #<UNBOUND-VARIABLE RED {1001116793}>.
CL-USER> (defvar *my-circle*
	   (make-instance 'circle :color red :radius 4.0))
; Evaluation aborted on #<UNBOUND-VARIABLE RED {10016D46F3}>.
CL-USER> (defparameter *my-circle*
	   (make-instance 'circle :color :red :radius 4.0))
*MY-CIRCLE*
CL-USER> (defparameter *my-rect*
	   (make-instance 'rectangle :color :black :width 3 :height 8))
*MY-RECT*
CL-USER> (defmethod area :around((s shape))
	   (format t "计算面积开始~%")
	   (let ((result (call-next-method)))
	     (format t "计算结果:~a~%" result)
	     result))
#<STANDARD-METHOD COMMON-LISP-USER::AREA :AROUND (SHAPE) {100201E793}>
CL-USER> (defclass shape()
	   ((created-time
	     :initform (get-universal-time)
	     :reader created-time)))
#<STANDARD-CLASS COMMON-LISP-USER::SHAPE>
CL-USER> (defun main()
	   (dolist (s shape)
	     (format t "~a的面积是 ~$,颜色 ~a,时间 ~d~%"
		     (type-of s)
		     (area s)
		     (color s)
		     (created-time s)))
	   (format t "交集面积 ~$~%"
		   (intersection-area *my-circle* *my-rectangle*)))
; in: DEFUN MAIN
;     (INTERSECTION-AREA *MY-CIRCLE* *MY-RECTANGLE*)
; 
; caught WARNING:
;   undefined variable: COMMON-LISP-USER::*MY-RECTANGLE*

;     (DOLIST (S SHAPE)
;       (FORMAT T "~a的面积是 ~$,颜色 ~a,时间 ~d~%" (TYPE-OF S) (AREA S) (COLOR S)
;               (CREATED-TIME S)))
; --> LET SB-KERNEL:THE* 
; ==>
;   SHAPE
; 
; caught WARNING:
;   undefined variable: COMMON-LISP-USER::SHAPE
; 
; compilation unit finished
;   Undefined variables:
;     *MY-RECTANGLE* SHAPE
;   caught 2 WARNING conditions
MAIN
CL-USER> (defun main()
	   (dolist (s shape)
	     (format t "~a的面积是 ~$,颜色 ~a,时间 ~d~%"
		     (type-of s)
		     (area s)
		     (color s)
		     (created-time s)))
	   (format t "交集面积 ~$~%"
		   (intersection-area *my-circle* *my-rectangle*)))
; in: DEFUN MAIN
;     (INTERSECTION-AREA *MY-CIRCLE* *MY-RECTANGLE*)
; 
; caught WARNING:
;   undefined variable: COMMON-LISP-USER::*MY-RECTANGLE*

;     (DOLIST (S SHAPE)
;       (FORMAT T "~a的面积是 ~$,颜色 ~a,时间 ~d~%" (TYPE-OF S) (AREA S) (COLOR S)
;               (CREATED-TIME S)))
; --> LET SB-KERNEL:THE* 
; ==>
;   SHAPE
; 
; caught WARNING:
;   undefined variable: COMMON-LISP-USER::SHAPE
; 
; compilation unit finished
;   Undefined variables:
;     *MY-RECTANGLE* SHAPE
;   caught 2 WARNING conditions
WARNING: redefining COMMON-LISP-USER::MAIN in DEFUN
MAIN
CL-USER> (defun main()
	   (let ((shapes (list *my-circle* *my-rect*)))
	   (dolist (s shapes)
	     (format t "~a的面积是 ~$,颜色 ~a,时间 ~d~%"
		     (type-of s)
		     (area s)
		     (color s)
		     (created-time s)))
	   (format t "交集面积 ~$~%"
		   (intersection-area *my-circle* *my-rectangle*))))
; in: DEFUN MAIN
;     (INTERSECTION-AREA *MY-CIRCLE* *MY-RECTANGLE*)
; 
; caught WARNING:
;   undefined variable: COMMON-LISP-USER::*MY-RECTANGLE*
; 
; compilation unit finished
;   Undefined variable:
;     *MY-RECTANGLE*
;   caught 1 WARNING condition
WARNING: redefining COMMON-LISP-USER::MAIN in DEFUN
MAIN
CL-USER> (defun main()
	   (let ((shapes (list *my-circle* *my-rect*)))
	   (dolist (s shapes)
	     (format t "~a的面积是 ~$,颜色 ~a,时间 ~d~%"
		     (type-of s)
		     (area s)
		     (color s)
		     (created-time s)))
	   (format t "交集面积 ~$~%"
		   (intersection-area *my-circle* *my-rect*))))
WARNING: redefining COMMON-LISP-USER::MAIN in DEFUN
MAIN
CL-USER> (main)
计算面积开始
计算结果:50.26548245743669d0
; Evaluation aborted on #<SB-PCL::NO-APPLICABLE-METHOD-ERROR {1003E3C623}>.
CL-USER> (main)
计算面积开始
计算结果:50.26548245743669d0
; Evaluation aborted on #<SB-PCL::NO-APPLICABLE-METHOD-ERROR {1003F22B83}>.
CL-USER> (load "object.lisp")
WARNING:
   Cannot find type for specializer COMMON-LISP-USER::BANK-ACCOUNT when
   executing SB-PCL:SPECIALIZER-TYPE-SPECIFIER for a STANDARD-METHOD of a
   STANDARD-GENERIC-FUNCTION.
While evaluating the form starting at line 7, column 0
  of #P"/home/hush-lee/Documents/Workspace/MyLearning/Lisp/CLisp/object.lisp":; Evaluation aborted on #<SB-PCL:CLASS-NOT-FOUND-ERROR BANK-ACCOUNT {1005068423}>.
CL-USER> (load "object.lisp")
WARNING: redefining COMMON-LISP-USER::AREA in DEFGENERIC
WARNING:
   redefining AREA (#<STANDARD-CLASS COMMON-LISP-USER::CIRCLE>) in DEFMETHOD
WARNING:
   redefining AREA (#<STANDARD-CLASS COMMON-LISP-USER::RECTANGLE>) in DEFMETHOD
WARNING: redefining COMMON-LISP-USER::INTERSECTION-AREA in DEFGENERIC
WARNING:
   redefining INTERSECTION-AREA (#<STANDARD-CLASS COMMON-LISP-USER::CIRCLE>
                                 #<STANDARD-CLASS COMMON-LISP-USER::RECTANGLE>) in DEFMETHOD
WARNING:
   redefining INTERSECTION-AREA (#<STANDARD-CLASS COMMON-LISP-USER::RECTANGLE>
                                 #<STANDARD-CLASS COMMON-LISP-USER::CIRCLE>) in DEFMETHOD
WARNING:
   redefining AREA :AROUND (#<STANDARD-CLASS COMMON-LISP-USER::SHAPE>) in DEFMETHOD
WARNING: redefining COMMON-LISP-USER::MAIN in DEFUN
计算面积开始
计算结果: 50.26548245743669d0
While evaluating the form starting at line 128, column 0
  of #P"/home/hush-lee/Documents/Workspace/MyLearning/Lisp/CLisp/object.lisp":
T
CL-USER> (radius *my-rect*)
* ; Evaluation aborted on #<SB-PCL::NO-APPLICABLE-METHOD-ERROR {1001D0CDB3}>.
CL-USER> (load "object.lisp")
圆的颜色: BLACK, 半径: 4.0
矩形的颜色: BLACK, 宽度: 3, 高度: 8
计算面积开始
计算结果: 50.26548245743669d0
圆面积: 50.26548245743669
计算面积开始
计算结果: 24
矩形面积: 24
T
CL-USER> (main)
计算面积开始
计算结果: 50.26548245743669d0
; Evaluation aborted on #<SB-PCL::NO-APPLICABLE-METHOD-ERROR {1003ECDDA3}>.
CL-USER> (color *my-circle*)
:BLACK
CL-USER> (main)
计算面积开始
计算结果: 50.26548245743669d0
; Evaluation aborted on #<SB-PCL::NO-APPLICABLE-METHOD-ERROR {1003F567C3}>.
CL-USER> (defmethod out1 ()
	   (format t "Hello "))
#<STANDARD-METHOD COMMON-LISP-USER::OUT1 () {10047D0FA3}>
CL-USER> (defmethod out :before out1())
WARNING:
   Invalid qualifiers for STANDARD method combination in method
   #<STANDARD-METHOD COMMON-LISP-USER::OUT :BEFORE OUT1 () {10047D6423}>:
     (:BEFORE OUT1).
#<STANDARD-METHOD COMMON-LISP-USER::OUT :BEFORE OUT1 () {10047D6423}>
CL-USER> (defmethod out :before out1())
WARNING: redefining OUT :BEFORE OUT1 NIL in DEFMETHOD
WARNING:
   Invalid qualifiers for STANDARD method combination in method
   #<STANDARD-METHOD COMMON-LISP-USER::OUT :BEFORE OUT1 () {1004D32673}>:
     (:BEFORE OUT1).
#<STANDARD-METHOD COMMON-LISP-USER::OUT :BEFORE OUT1 () {1004D32673}>
CL-USER> (defmethod out :before out1()
	   (format t "world!"))
WARNING: redefining OUT :BEFORE OUT1 NIL in DEFMETHOD
WARNING:
   Invalid qualifiers for STANDARD method combination in method
   #<STANDARD-METHOD COMMON-LISP-USER::OUT :BEFORE OUT1 () {1004D37EB3}>:
     (:BEFORE OUT1).
#<STANDARD-METHOD COMMON-LISP-USER::OUT :BEFORE OUT1 () {1004D37EB3}>
CL-USER> (out)
; Evaluation aborted on #<SB-PCL::NO-PRIMARY-METHOD-ERROR {1004E17DB3}>.
CL-USER> (defgeneric out ())
WARNING: redefining COMMON-LISP-USER::OUT in DEFGENERIC
#<STANDARD-GENERIC-FUNCTION COMMON-LISP-USER::OUT (1)>
CL-USER> (defmethod out :before out1()
	   (format t "world!"))
WARNING: redefining OUT :BEFORE OUT1 NIL in DEFMETHOD
WARNING:
   Invalid qualifiers for STANDARD method combination in method
   #<STANDARD-METHOD COMMON-LISP-USER::OUT :BEFORE OUT1 () {1005441243}>:
     (:BEFORE OUT1).
#<STANDARD-METHOD COMMON-LISP-USER::OUT :BEFORE OUT1 () {1005441243}>
CL-USER> (defmethod out1 ()
	   (format t "Hello "))
WARNING: redefining OUT1 NIL in DEFMETHOD
#<STANDARD-METHOD COMMON-LISP-USER::OUT1 () {1005445D93}>
CL-USER> (defmethod out :before out1()
	   (format t "world!"))
WARNING: redefining OUT :BEFORE OUT1 NIL in DEFMETHOD
WARNING:
   Invalid qualifiers for STANDARD method combination in method
   #<STANDARD-METHOD COMMON-LISP-USER::OUT :BEFORE OUT1 () {10054AAEB3}>:
     (:BEFORE OUT1).
#<STANDARD-METHOD COMMON-LISP-USER::OUT :BEFORE OUT1 () {10054AAEB3}>
CL-USER> (defgeneric compute (x)
  (:documentation "计算函数"))
#<STANDARD-GENERIC-FUNCTION COMMON-LISP-USER::COMPUTE (0)>
CL-USER> (defmethod out :after out1()
	   (format t "world!"))
WARNING:
   Invalid qualifiers for STANDARD method combination in method
   #<STANDARD-METHOD COMMON-LISP-USER::OUT :AFTER OUT1 () {10055C9793}>:
     (:AFTER OUT1).
#<STANDARD-METHOD COMMON-LISP-USER::OUT :AFTER OUT1 () {10055C9793}>
CL-USER> (defmethod out1 :after ()
	   (format t "world!"))
#<STANDARD-METHOD COMMON-LISP-USER::OUT1 :AFTER () {10055CE0A3}>
CL-USER> (out)
; Evaluation aborted on #<SB-PCL::NO-PRIMARY-METHOD-ERROR {100562F643}>.
CL-USER> (out1)
Hello world!
NIL
CL-USER> (defmethod out1 :before)_
; Evaluation aborted on #<UNBOUND-VARIABLE _ {1005C60803}>.
CL-USER> (defmethod out1 :before ()
	   (format t "Say:"))
WARNING: redefining OUT1 :BEFORE NIL in DEFMETHOD
#<STANDARD-METHOD COMMON-LISP-USER::OUT1 :BEFORE () {10061C9FA3}>
CL-USER> (out1)
Say:Hello world!
NIL
CL-USER> (defmethod out1 :around ()
	   (call-next-method)
	   (format t "~% byebye!"))
#<STANDARD-METHOD COMMON-LISP-USER::OUT1 :AROUND () {10017B12C3}>
CL-USER> (out1)
Say:Hello world!
 byebye!
NIL
CL-USER> 