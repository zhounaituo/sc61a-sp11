```english
The acts of the mind, wherein it exerts its power over simple ideas, are chiefly these three: 1. Combining several simple ideas into one compound one, and thus all complex ideas are made. 2. The second is bringing two ideas, whether simple or complex, together, and setting them by one another so as to take a view of them at once, without uniting them into one, by which it gets all its ideas of relations. 3. The third is separating them from all other ideas that accompany them in their real existence: this is called abstraction, and thus all its general ideas are made.
—John Locke, An Essay Concerning Human Understanding (1690)
```

## 计算机科学的定义
- 计算机科学（_computer science_）并不是关于计算机结构的知识（这是电气工程学的内容），也根本不是科学（我们创造事物要比发现事物多得多）。计算机科学是形式科学的一部分，也是艺术的一部分。对于形式科学来说，计算机科学有关于“如何构建高效的、可靠的软件”。对于艺术形式来说，计算机科学有关于使用编程的方式来创造表达式。[[notes.pdf#page=3&selection=2,0,5,97|notes, page 3]]
- 关于如何对抗复杂系统：从程序的整体结构出发，忽略掉一些细节，从而获得程序整体的结构。这种对整体分块的方式被称为编程范式：
	- 函数式编程（functional programming）
	- 面向对象编程（object-oriented programming）
	- 客户端和服务端编程（client-server programming）
	- 逻辑编程（logic programming）
## 关于编程语言
- **编程语言**的作用不仅在于指导计算机完成任务，更重要的是**帮助我们组织思考**。因此，我们要注重语言提供的能力——将简单的思想结合形成更加复杂思想的能力。[[sicp.pdf#page=34&selection=5,39,6,61|sicp, page 34]]
- 编程语言的三个重要的机制：1. **基础表达式**(_primitive expressions_): 语言所涉及的最简单实体，包括_基础数据_和_基础过程_。2. **结合的手段**(_means of combination_): 可以将简单的元素结合成结合体。3. **抽象的手段**(_means of abstraction_): 可以把结合体作为一个单元，对它命名和操作。[[sicp.pdf#page=34&selection=9,20,25,25|sicp, page 34]]
- 强大语言的一些要素：
	1. 数字和算术运算是基本的数据和过程。
	2. 内嵌组合提供了一种组合过程的方法。
	3. 关联名称和值的定义，提供了一种限制性抽象。

> 在编程中，我们主要处理两个元素：过程(_procedures_)和数据(_data_)。

> 有关描述性语言和指令式语言的区别：**描述性语言**（_declarative_）会说明事物“是什么”，但不会给出“怎么做”。而**指令式语言**（_imperative descriptions_）会给出“怎么做”。这个区别也体现在数学和计算机科学上，高级语言试图实现将描述性语言自动转换成指令式语言，但一般很难。[[sicp.pdf#page=57&selection=63,0,75,55|sicp, page 57]]

> 关于语法糖（_syntactic sugar_）：又叫特殊语法形式（_special syntactic forms_），可以轻易的改变一个事物的表面结构。是一种比较危险的语法，使得程序更大更复杂。

## 关于表达式（_expressions_）
![[expressions 1.png]]
- 表达式的种类：
	- 前缀表达式（_prefix notation_），如 `sin 30`。
		- 相对于其他表达式的优点：
			- 适应过程，可以给任意多个参数
			- 允许内嵌表达式
	- 中缀表达式（_infix notation_），如 `2 + 3`
	- 后缀表达式（_suffix notation_），如`7!`
	- 环绕式表达式，如 `√2`
## 关于抽象（_abstraction_）
- 一门语言是为了让我们在讨论问题时，用更接近于问题本身的术语，而不是用计算机的机制或能力。
- 有关于计算机的抽象结构如下：
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
## 关于过程（_procedure_）
- 计算过程(_computational process_) 是存在于计算机中的抽象存在。过程操作的其他抽象事物成为数据（_data_)。过程的演变被一种称为程序(_program_)的模式规则(_a pattern of rules_)所指导。
- 过程定义（_procedure definitions_）：一种强大的抽象技术，将一个名字和一个单元组合起来。
	1. 过程定义的通用定义：
		![[procedure-definition 1.png]]![[terminology.png]]
	2. 注意过程定义有两个操作：
		i. 创建一个过程。
		ii. 将过程和名字联系起来。
	3. 这里展示的是英语和 lisp 语法的关联。同时，这和中文的语序是不同的。
		![[procedure-definitions-example 1.png]]
- 一般求值的规则：
	- 数字的值就是他们的名字。
	- 内置操作的值，就是对应操作的有序机器码
	- 其他名字的值就是环境中的相应名字的对象。
- 关于求值的顺序：
	- 常序求值（Normal order）：就是先求出参数的值，然后再替换调用方法中的形式参数。SCIP 上的**树累计**（_tree accumulation_）就是一种常序求值。
	- 应序求值（Application order）：就是先替换参数，然后再对函数求值。
> 🚨注意，无论常序求值或是应序求值中的替换的目的是为了帮助我们理解求值过程，而不是程序的实际运行的过程。

> 关于模块化设计：模块化程序的每个部分都可以被构建、替换以及单独测试。

## 关于函数（_function_）
- 函数需要满足一下的要求：
	1. 函数可以有任意多个参数，但是有且只有一个精确的返回值。
	2. 函数可以组合成更大的函数，但是这些组合函数之间不会相互影响。
	3. 不同的求值顺序，并不影响函数的结果。
- 关于递归（_recursion_）：一个调用自身的函数。

> 关于特殊形式：除了一般求值规则以外的就是特殊形式。

> 🚨不要编写只适合一个特定参数的函数。

## 其他
1. 情景分析（_case analysis_）：为不同结果做出不同操作的思想。
	1. `cond` 是 lisp 中的一种情景分析的特殊形式。
		![[cond1.png]]
		![[cond2.png]]
		- 条件表达式的求值思路：1. 先求 p1，如果值为 false，则求 p2；如果 p2 值为 false，则求 p3。直到找到 true，解释器返回相应的 `<e>` 2. 如果没有 `<p>` 的值为 true，cond 的值为 undefined.
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

## 番外
1. Unix Shell Programming：查询并识别文章中的错误单词。
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
1. 关于课程管理方面的问题
	1. 在听课的时候去思考，而不是记笔记。
	2. 不要错过小组学习。
	3. 不要作弊，人的一生中的大部分决策都是受到习惯的影响，你的任何行为都有可能形成习惯。
	4. 关于人体工程学的知识，看 [Volume 2](https://people.eecs.berkeley.edu/~bh/61a-pages/Volume2/CS%2061A%20Course%20Reader,%20Volume%202.html) 的最后两篇。