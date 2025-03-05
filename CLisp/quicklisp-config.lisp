;;; Quicklisp 包配置文件
;;; 放置于 ~/common-lisp/ 或项目根目录，通过 (load "quicklisp-config.lisp") 加载

(in-package :cl-user)

;; 确保 Quicklisp 已加载
(unless (find-package :ql)
  (load "~/Documents/Workspace/MyLearning/Lisp/CLisp/quicklisp.lisp")) ; 修改为你的 Quicklisp 安装路径

;; 定义常用软件包列表
(defparameter *required-packages*
  '(:alexandria     ; 通用工具库
    :cl-ppcre       ; 正则表达式
    :dexador        ; HTTP 客户端
    :jonathan       ; JSON 处理
    :closer-mop     ; MOP 兼容层
    :log4cl         ; 日志系统
    :bordeaux-threads ; 多线程支持
    :lparallel      ; 并行编程
    :uiop           ; 跨平台系统接口
    :str            ; 现代字符串处理
    :serapeum       ; 扩展工具库
    :rove           ; 测试框架
    :magic-edict    ; 中文分词
    :cl-ansi-term   ; 终端颜色输出
    :inferior-shell ; 跨平台 Shell 命令
    :sqlite         ; SQLite 数据库驱动
    :postmodern     ; PostgreSQL 接口
    :clx            ; X11 图形界面
    :ltk))          ; Tk 图形界面

;; 安装缺失的包
(defun install-required-packages ()
  (ql:update-all-dists :prompt nil) ; 静默更新 dists
  (dolist (pkg *required-packages*)
    (unless (ql:system-apropos (format nil "^~a$" pkg)) ; 精确匹配检测
      (format t "正在安装 ~a...~%" pkg)
      (ql:quickload pkg :silent t))))

;; 配置本地项目目录
(defun setup-local-projects (&optional (path #p"~/common-lisp/"))
  "添加本地开发目录到 Quicklisp 搜索路径"
  (pushnew path ql:*local-project-directories*
           :test #'equalp)
  (ql:register-local-projects)
  (format t "已加载本地项目目录: ~a~%" path))

;; 主配置函数
(defun configure-quicklisp ()
  (install-required-packages)
  (setup-local-projects)
  (format t "~%~%Quicklisp 配置完成！可用命令：~%")
  (format t "(ql:quickload :包名)    - 加载软件包~%")
  (format t "(ql:update-client)      - 更新客户端~%")
  (format t "(ql:update-all-dists)   - 更新所有 dist~%"))

;; 执行配置
(configure-quicklisp)
