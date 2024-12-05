1. 编程语言的作用不仅在于指导计算机完成任务，更重要的是帮助我们组织思考。因此，我们要注重语言提供的能力——将简单的思想结合形成更加复杂思想的能力。
2. 语言的三个重要的机制：
	- 基础表达式(_primitive expressions_): 语言所涉及的最简单实体，包括 _基础数据_ 和 _基础过程_ 。
	- 结合的手段(_means of combination_): 可以将简单的元素结合成结合体
	- 抽象的手段(_means of abstraction_): 可以把结合体作为一个单元，对它命名和操作。
3. 在编程中，我们主要处理两个元素：过程(_procedures_)和数据(_data_)。
## 1.1.1. Expressions
![[expressions 1.png]]

1. 前缀表达式（_prefix notation_）：将操作符放置在最左边。
	1. 优点：1. 适应过程，可以给任意多个参数。2. 允许内嵌表达式。
2. Lisp 编译器的基础操作：_read-eval-print_
## 1.1.2. Naming and the Environment
1. 用 `define` 定义变量，它是 Lisp 中最简单的抽象。
2. 环境（_environment_ or _global environment_) ：由 Lisp 编译器在内存中维护。
	1. 作用：1. 跟踪定义的 name-object 对。
## 1.1.3 Evaluating Combinations
1. 组合求值的行为：
	1. 对子表达式求值。
	2. 将最左边的操作应用与第一步中子表达式的值。
2. 树累计（_tree accumulation_）: 求值规则的一般过程的例子。
3. 一般求值规则：
	1. 数字的值就是他们的名字。
	2. 内置操作的值，就是对应操作的有序机器码
	3. 其他名字的值就是环境中的相应名字的对象。
4. 特殊形式（_special forms_）：除了一般求值规则以外的就是特殊形式。
	1. define 是一种特殊形式。
5. 语法糖（_syntactic sugar_）：又叫特殊语法形式（_special syntactic forms_），可以轻易的改变一个事物的表面结构。是一种比较危险的语法，使得程序更大更复杂。
## 1.1.4. Compound Procedures
1. 强大语言的一些要素：
	1. 数字和算术运算是基本的数据和过程。
	2. 内嵌组合提供了一种组合过程的方法。
	3. 关联名称和值的定义，提供了一种限制性抽象。
2. 过程定义（_procedure definitions_）：一种强大的抽象技术，将一个名字和一个单元组合起来。
	1. 过程定义的通用定义：
		![[procedure-definition 1.png]]
	2. 注意过程定义有两个操作：
		- 创建一个过程。
		- 将过程和名字联系起来。
	3. 这里展示的是英语和 lisp 语法的关联。同时，这和中文的语序是不同的。
		![[procedure-definitions-example 1.png]]
## 1.1.5. The Substitution Model for Procedure Application
1. 组合过程（_compound procedures_）的应用过程: 将过程主体中的形式参数替换为相应的参数并求值。
2. 两个需要注意的点：1. 替换的目的是为了帮助我们理解过程的应用，这并不是程序的实际运行过程。2. 替换模型只是思考求值过程的形式之一。(Page 19-20)
3. 求值方法：
	1. 常序求值（_normal-order evaluation_）：先将表达值中的所有子表达式展开，至仅包含数字和基础过程时，再求值。
	2. 应序求值(_applicative-order evaluation_)：求出各子表达式的值，后再计算过程。
## 1.1.6. Conditional Expressions and Predicates 
1. 情景分析（_case analysis_）：为不同结果做出不同操作的思想。
	1. `cond` 是 lisp 中的一种情景分析的特殊形式。
		![[cond1.png]]
		![[cond2.png]]
		1. 条件表达式的求值思路：1. 先求 p1，如果值为 false，则求 p2；如果 p2 值为 false，则求 p3。直到找到 true，解释器返回相应的 `<e>` 2. 如果没有 `<p>` 的值为 true，cond 的值为 undefined.
	2. `if` 一种特殊形式，在情景分析中只有两个条件时使用。
		![[if.png]]
2. `cond` 和 `if` 的不同在于，`cond` 的从句是有序表达式。
3. 3 种不同的绝对值 procedure 的写法：

| ![[abs1.png]] | ![[abs2.png]] | ![[abs3.png]] |
|--|--|--|
4. 其他常用判断
	1. `and`，一次只求一个 _\<e>_ 值 , 从左到右的顺序，如果某个 _\<e>_ 为 _false_，那么整个表达式的结果就是 false，而后面的表达式不会运行。如果，所有的 _\<e>_ 都是 true，那么表达式的结果就是最后一个 _\<e>_ 的值。
		![[and.png]]
	2. `or`，从左往右求值，一次只运行一个 _\<e>_，如果某个 _\<e>_ 为 true，那么整个表达式的结果就是 true，之后的表达式不会运行。如果，所有的 _\<e>_ 都是 false，那么表达式的结果就是 false。
		![[or.png]]
	3. `not`, _\<e>_ 结果为 true 时，表达式返回 flase，反之，返回 true。
		![[not.png]]
	>注意，`and` 和 `or` 并不是过程(_procedures_)，而是特殊形式(_special forms_)。因为他们的子表达式并不必须全部运行。`not` 是一个普通的过程。

5. 描述性语言和指令式语言的区别，描述性语言会说明这事物“是什么”，但不会给出怎么做。而指令式语言会给出“怎么做”。这个区别也体现在数学和计算机科学上，高级语言试图实现将描述性语言自动转换成命令式语言，但是一般不太可能实现。
## Exercise 
1.1. 写出下列表达式的结果
```scheme 
10 ; 10
(+ 5 3 4) ; 12
(- 9 1) ; 8
(+ 5 3 4) ; 12
(+ (* 2 4) (- 4 6)) ; 6
(define a 3) ; a
(define b (+ a 1)) ; b
(+ a b (* a b)) ; 19
(= a b) ; #f
(if (and (> b a) (< b (* a b)))
	b
	a) ; 4
(cond ((= a 4) 6)
	  ((= b 4) (+ 6 7 a))
	  (else 25)) ; 16
(+ 2 (if (> b a) b a)) ; 6
(* (cond ((> a b) a)
		 ((< a b) b)
		 (else -1))
	(+ a 1)) ; 16
```

1.2. 翻译为前缀表达式：
![[ex1.2.png]]
```scheme
(/ (+ 5 4 (- 2 (- 3 (+ 6 (/ 4 5)))))
   (* 3 (- 6 2) (- 2 7)))
```
1.3. 定义一个过程，接受 3 个参数，返回其中两个最大参数的平方和。
```scheme
(define (sum-of-square x y z)
  (- (+ (square x) (square y) (square z)) 
	 (square (minor (minor x y) z))))
(define (minor x y)
  (if (< x y) x y))
(define (square x)
  (* x x))
```
1.4. 用组合操作符来解释下列过程：
```scheme 
(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))
```

在过程 `a-plus-abs-b` 中，将 `(if (> b 0) + -)` 这个混合表达式作为了该组合的一个操作符。该表示式表示，如果 b 大于 0 时就算 ab 之和，否则算它的差值。

1.5. 解释一下 Ben Bitdiddle 的测验方式
```scheme
(define (p) (p))
(define (test x y)
  (if (= x 0) 0 y))
(test 0 (p))
```

1. 如果是 applicative-order 求值：
```scheme
(test 0 (p))
...
(test 0 (p))
```
它会陷入不停求解 `(P)` 的死循环。
1. 如果是 normal-order 求值
```scheme
(test 0 (p))
(if (= 0 0) 0 (p)) ; 0
```
它会结果会返回为 0。

## Exaple: Square Roots by Newton's Method
```scheme
(define (sqrt-iter guess x)
  (if (good-enough? guess x)
      guess
      (sqrt-iter (improve guess x) x)))
(define (improve guess x)
  (average guess (/ x guess)))
(define (average x y)
  (/ (+ x y) 2))
(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))
(define (sqrt x)
  (sqrt-iter 1.0 x))
```
> 注意，1. sqrt 中的 1.0 而不是 1 的起始 guess 的选择，在于保证结果的计算过程中的值为小数类型，而不是整数类型。2. 程序的开发顺序，是构建一个核心过程 sqrt-iter，并玩上核心部件。之后，将核心过程应用于主过程中（也就是对 sqrt）。3. 这个程序使用的是牛顿法就平方根，是以猜测值不断逼近的方式求值。

1.7. 实例说明 good-enough? 的缓慢原因。
```scheme
(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))
```
这里会先求出 guess 的平方，然后和 x 做减法。取这个商的绝对值后，于 0.001 做比较。所以我认为，较大或较小的数据会增加内部过程 square、- 、abs 的计算量，进而变得缓慢。

修改后的 good-enough?：
```scheme 
(define (good-enough? guess x)
  (< (abs (- guess (/ x guess))) 0.001))
```
完整如下：
```scheme
(define (sqrt-iter guess x)
  (if (good-enough? guess x)
          guess
          (sqrt-iter (improve guess x) x)))
(define (improve guess x)
  (average guess (/ x guess)))
(define (average x y)
  (/ (+ x y) 2))
(define (good-enough? guess x)
  (< (abs (- guess (/ x guess))) 0.001))
(define (sqrt x)
  (sqrt-iter 1.0 x))
```

1.8. 
```scheme 
(define (cube-iter guess x)
  (if (good-enough? guess x)
      guess
      (cube-iter (improve guess x) x)))
(define (improve guess x)
  (/ (+ (/ x (square guess)) (* 2 guess)) 3))
(define (square x)
  (* x x))
(define (good-enough? guess x)
  (< (abs (- guess (/ x guess guess))) 0.001))
(define (cube x)
  (cube-iter 1.0 x))
```

## 1.1.8 Procedures as Black-Box Abstractions
1. 过程抽象（_procedural abstraction_）：
	1. 程序设计时，将关注点放置在如何实现结果上，而忽略过程中怎样获取值的细节的思考方式。
	2. 使用者为了使用这些过程，并不需要自己重写过程或是了解过程是如何实现的。
	3. 比如，_square_
```scheme
(define (sqrt x)
  (sqrt-iter 1.0 x))
```
> _sqrt_ 并不算是一个过程，而是整个过程的过程抽象。
2. 过程的一些实现细节：
	1. 内部名（_local names_）：实现过程是，不需要担心形式参数名的选择。
	2. 形式参数（_formal parameter_）形式参数在过程实现中扮演着特殊的角色，它并不关心形式参数在过程中的名字。
		1. 限制性变量（_bound variable_）：变量的意义并不绑定在名字中。