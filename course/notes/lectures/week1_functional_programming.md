阅读：书 1.1 章（1-31页）

1. cs 61a 使用 scheme 作为课程的语言。Scheme 是一种解释性语言（interactive language），这意味着你不需要一次编写一个很大的程序，然后一次性全部运行。而是一次编写一个很小的表达式就可以先看一下它的结果。
![[terminology.png]]
2. 递归（_recursion_）：一个调用自身的函数。
3. 课程概述
	1. 计算机科学并不是关于计算机本身的知识（这是电气工程学的内容），也不是基础的科学（我们创造事物比发现事物要多得多）。
	2. 计算机是形式工程的一部分，也是艺术的一部分。对于形式工程来说，它有关于通过软件方式来构建可靠的，高效的机制。对于艺术来说，它有关于使用编程作为媒介来创造表达式。
	3. 只要你一直去解决一个一个的小问题，那么编程就是简单的。
	4. 本节课有 3 个大的程序风格/方法/范式：
		1. 函数式编程（functional programming）
		2. 面向对象编程（object-oriented programming）
		3. 客户端和服务端编程（client-server programming）
		4. 逻辑编程（logic programming）
	5. 本节课的主要思想是抽象（abstraction）：发明语言，让我们更接近于用问题本身的术语，而不是计算机的机制或能力来讨论问题。
	6. 抽象的层次：
	   ```shell
		Application programs 
		High-level language (Scheme)
		Low-level language (C)
		Machine language
		Architecture (registers, memory, arithmetic unit, etc)
		circuit elements (gates)
		transistors
		solid-state physics
		quantum mechanics
		```
	7. 函数是什么？
		1. 一个函数可以有任何多个参数，但是必须包含一个精确的返回值。
		2. 如果每个小计算都独立于整个计算的历史记录，那么我们可以重新排序这些小计算。这个思想特别适合处理并行计算。
		3. 函数的定义提供了一个形式参数（formal parameter），并且函数的调用提供了一个实际参数（actual argument）。不要编写只适合一个特定参数值的函数。
		4. 这里没有一系列的事件，而是函数的组合。我们可以用功能机器和管道图直观地表示这一点。
	8. 递归：将一个问题拆分为两个主要问题。
		1. 如何处理其中一个条件，第一个或是其他特殊的情况。
		2. 如何处理剩余的条件，并且剩余的条件于第一个问题处理方式相似，只是拥有更小的条件。
4. normal vs. applicative order
	1. 这里使用 stk-scheme 加载 order 来获取宏 def/normal/applic。
	2. 常序求值（Normal order）：就是先求出参数的值，然后再替换调用方法中的形式参数。
	```scheme
(normal (zero (random 10)))

(zero (random 10)) ---->
(- (random 10) (random 10))
   (random 10) ==> 8
   (random 10) ==> 5
(- 8 5) ==> 3
3
```
	3. 应序求值（Application order）：就是先替换参数，然后再对函数求值。
	```scheme
(applic (zero (random 10)))

(zero (random 10))
   (random 10) ==> 7
(zero 7) ---->
(- 7 7) ==> 0
0
```
5. 对于函数式编程，求值的顺序不影响其结果。同时也说明，上述的 `(zero (random 10))`在常序结果的求值为 3，所以它并不是函数(function)
6. Unix Shell Programming：查询并识别文章中的错误单词。
	1. `tr -d '.,;:"\!\[]() < summary > nopunct`
		1. `tr -d` 可以用于处理文档中的标点符号 
		2. `>` 重定向标准输出流
		3. `<` 重定向标准输入流
	2. `tr '    ' '' < nopunct > notab` 
	3. `tr ' ' '\n' < notab > oneword` 
	4. `tr '[A-Z]' '[a-z]' < oneword > lowcase`
	5. `sort < lowcase > sorted` 
		1. `sort` 用于排序
	6. `uniq < sorted > nodup`
		1. `uniq` 去除相邻重复项。
	7. `join -v1 nodup words > errors`
		1. `join -v1` 对比并保留对象1中的差异。
	8. 合并到 spell 中
	   ```bash
	   # ./spell
	   tr -d ’.,;:"\!\[]()’ | tr ’ ’ ’ ’ | tr ’ ’ ’\n’ \ | tr ’[A-Z]’ ’[a-z]’ | sort | uniq | join -v1 - words
```
	9. `chmod +x spell`