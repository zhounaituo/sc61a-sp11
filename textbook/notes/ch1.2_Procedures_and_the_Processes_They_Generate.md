#### Exercise 1.6

他们打算用以下这个程序替换 if：
```scheme 
(define (new-if predicate then-clause else-clause)
  (cond (predicate then-clause)
	    (else else-clause)))
```
但是，在下面这个程序中出现了问题：
```scheme
(define (sqrt-iter guess x)
  (new-if (good-enough? guess x)
          guess
          (sqrt-iter (improve guess x) x)))   
```

```scheme
*** Error:
    Segmentation violation: Returning to toplevel
Current eval stack:
__________________
  0    (string? arg)
  1    (if (string? arg) (let ((num (string->number arg))) (if num num arg)) arg)
  2    (map maybe-num args)
  3    (apply fn (map maybe-num args))
  4    (- (square guess) x)
  5    (abs (- (square guess) x))
  6    (< (abs (- (square guess) x)) 0.001)
  7    (new-if (good-enough? guess x) guess (sqrt-iter (improve guess x) x))
  8    (new-if (good-enough? guess x) guess (sqrt-iter (improve guess x) x))
  9    (new-if (good-enough? guess x) guess (sqrt-iter (improve guess x) x))
 10    (new-if (good-enough? guess x) guess (sqrt-iter (improve guess x) x))
...
```

解释以下，程序运行出现的错误。
答：这里按照 application order 来解答。在应序求值时，会在调用过程时，有限求出参数的值，那么，`new-if` 作为一个过程，它本身失去 `cond` 的特殊形式的功能（不会马上求值）。所以，在 `new-if` 判定前就不停的递归，导致无限循环。

#### Exercise 1.7

- 解释以下文中的 sqrt 为什么不适用于较大或较小的数字？
	- 因为，其中的测试结果是否足够精确时，使用的时乘法和求平方，较大或较小的数字会有巨大的计算量。
下列是修订后的，适用于大小数组的 square-root:
```scheme 
(define (square-root x)
  (sqrt-iter 1.0 x x))                                        
(define (sqrt-iter guess last-guess x)
  (if (enough? guess last-guess)
      guess
      (sqrt-iter (improve guess x) guess x)) )

(define (enough? guess last-guess)
  (< (abs (- guess last-guess)) 0.00001))

(define (improve guess x)
  (average guess (/ x guess)))

(define (average x y)
  (/ (+ x y) 2)) 
```

#### Exercise 1.8
```scheme
(define (cube-iter guess last-guess x)
  (if (enough? guess last-guess)
      guess
      (cube-iter (improve guess x) guess x)))                 
(define (enough? guess last-guess)
  (< (abs (- guess last-guess)) 0.00001))
(define (improve y x)
  (/ (+ (/ x (quare y)) (* 2 y)) 3))
(define (quare x) (* x x))

(define (cube-root x)
  (cube-iter 1.0 x x))   
```

## 1.1.8 Procedures as Black-Box Abstractions
1. 程序抽象（_procedural abstraction_）：忽略程序的实现细节，只关注如何使用程序的思考方式。
### Local name
1. 约束变量（_bound variable_）：定义过程时所用的形式参数变量名。
2. 绑定（_bind_）：表示变量名和形式参数绑定的过程。
3. 非约束变量（_free_）：没有绑定的变量。
4. 作用域（_scope_）：定义变量的表达是，就是该变量的作用域。

例如，在 `good-enough?` 中，`guess` 和 `x` 就是限定变量，`<`、`-`、`abs` 就是非约束变量。
```scheme
(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))
```

> 如果把，`guess` 改为 abs，那么在这个方法体内的所有 `abs` 都会从 free 变成 bound variable。

### Internal definitions and block structure
1. 其他使用限制变量的方式，内部定义。
2. 块结构编写程序的方式用于简化大型程序的开发，最早源自 ALGOL 60。
## 1.2 Procedures and the Processes They Generate 
1. 称为一名有经验的程序员，应该学会形象的思考程序的问题。
### 1.2.1 Linear Recursion and Iteration
1. 递归程序（_recursive process_）：包含一系列的延迟操作特征。
	1. 线性递归程序（_linear recursive process_）：延迟操作的长度与计算值的增长成线性关系的程序。
2. 迭代程序（_iterative process_）：程序所有需要跟踪的数据，都在当前操作中。
	1. 状态变量（_state variables_）：迭代程序的固定变化量。
	2. 线性迭代程序（_linear iterative process_）：有固定的状态量并且有固定的规则，这个规则将当前状态变更为下一个状态，并且一个结束测试。
3. 对比递归和迭代：
	1. 迭代在每一个点上提供了程序所有的状态信息。
4. procedure 和 process 的区别。
	1. procedure 考虑的是语法。
	2. process 考虑的范式。
5. 尾部递归（_tail-recurisive_）： 一种迭代的递归写法 。
#### Exercise 1.9
答：这两个既不是迭代也不是递归，他们每个点不包含当前程序的所有状态，也没有结束条件。他们应该是死循环。
```scheme
(define (+ a b) 
  (if (= a 0) b (inc (+ (dec a) b))))
(define (+ a b) 
  (if (= a 0) b (+ (dec a) (inc b))))
```

#### Exercise 1.10
```scheme
(A 1 10) 1024
(A 2 4) 65536
(A 3 3) 65536
```

```scheme
(define (f n) (A 0 n)) ; 2n
(define (g n) (A 1 n)) ; 2^n
(define (h n) (A 2 n)) ; 2^(2^n)
(define (k n) (* 5 n n)) ; 5n^2 
```

### 1.2.2 Tree Recursion
#### Exercise 1.11
```scheme 
(define (f n)
  (if (< n 3)
      n
      (+ (f (- n 1))
         (* 2 (f (- n 2)))
         (* 3 (f (- n 3))) )))

;;;;;
(define (f n)
      (f-iter 2 1 0 0 n))
(define (f-iter a b c cou n)
  (if (= cou n)
      c
      (f-iter (+ a (* 2 b) (* 3 c))
              a
              b
              (+ cou 1)
              n)))
```

#### Exercise 1.12
```scheme 
(define (pascal row col)
  (if (or (= col 1)
          (= row col))
      1
      (+ (pascal (- row 1) (- col 1))
         (pascal (- row 1) col))))
```

#### Exercise 1.13 证明不会

$$
设\frac{\phi = (1 + \sqrt{5})}{2}
$$

### 1.2.4 Orders of Growth 

1. 增长级（_order of growth_）：用来描述算法和计算资源利用关系。
2. 下面的公式描述为，对于程序的 n 个参数，它的计算资源利用率为`R(n)`，其结果等于 `\theta(f(n))`。
   $$
   R(n)=\theta(f(n))
   $$
3. `Θ(n)` 的作用有哪些？
	1. 粗略的描述程序的行为。
	2. 方便思考和调整程序的大小的问题。
#### Exercise 1.14
#### Exercise 1.15
$$
sin x = 3sin\frac{x}{3}-4sin^3\frac{x}{3}
$$
a. 5次
b. 

	1. for examples 和 for instance 有什么区别。
	2. the number of 的意思
	3. a/the number of 的区别
	4. 有关哪个女人的事情。--
	5. 有关于对她的态度的问题。
	6. 单独一个 say 是什么意思？
	7. 门禁数据库的密码记一下。
	8. 测试一下，让 AI 去绘制一朵没有花瓣的花。
	9. overall 和 global 有什么区别。
	10. 加息为什么会虹吸世界的财富呢？

### 1.2.4 Exponentiation 
#### Exercise 1.16 我给的答案可能有误