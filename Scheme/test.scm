
(define (f n)
 (cond ((< n 3) n)
       (else (+ (f (- n 1)) (* 2 (f (- n 2))) (* 3 (f (- n 3)))))));递归
(define (fb n a b c)
  (cond ((= n 2) a)
        ((= n 1) b)
        (else (fb (- n 1) (+ a (* 2 b) (* 3 c)) a b))))
(define (ff n)
  (fb n 2 1 0));迭代

(define (* a b)
  (if (= b 0)
      0
      (+ a (* a (- b 1)))))
;1.18
(define (double n)
  (+ n n))
(define (halve n)
  (if (= (remainder n 2) 0)
      (/ n 2)
      n))
(define (fast-expt a b)
  (cond ((= b 1) a)
    ((= (halve b) b) (+ (fast-expt a (- b 1)) a))
    (else(fast-expt (double a) (halve b)))))

;1.19
(define (square a n)
  (cond ((= n 0) 1)
        ((= n 1) a)
        ((even? n) (square (* a a) (/ n 2)))
        (else (* a (square a (- n 1))))))
  
;欧几里得算法求最大公约数
(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))
;费马小定理判断素数
(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp) (remainder (square (expmod base (/ exp 2) m)) m))
        (else (remainder (* base (expmod base (- exp 1) m)) m))))
;寻找最小因子
(define (smallest-divisor n)
  (find-divisor n 2))
(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor 2) n)n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))
(define (divides? a b)
  (= (remainder b a) 0))


;;;;;1.22
(define (div n i)
  (cond ((= n i ) #t)
        ((= (remainder n i) 0) #f)
        (#t (div n (+ i 1)))))
(define (prime? n)
  (div n 2))

(define  (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (runtime)))
(define (start-prime-test n start-time)
  (if (prime? n)
      (report-prime (- (runtime) start-time))))
(define (report-prime elapsed-time)
  (display "*****")
  (display elapsed-time))
