1. 我们应该从强大的编程语言中要求的一件事是**能够通过为公共变量分配名称来构建抽象**的能力，然后直接根据抽象进行工作。这就是为什么几乎所有的基础编程语言都会包含定义过程的原因。
2. 高阶过程（_higher-order procedures_）：能够操作过程的过程被称为高阶过程。
## 1.3.1 Procedures as Arguments 
![[common-pattern.png]]
1. sum-integers/sum-cubes/pi-sum 被提取出相同的部分形成了上述的模板。这种方式描述了一种更加强大的抽象的存在。
### Exercise 
1. 1.29 辛普森法（_Simpson's Rule_）求近似值。

## 1.3.2. Constructing Procedures Using lambda
![[lambda.png]]
1. 使用 `lambda` 定义的函数和 `define` 是相同的，唯一不同的是，`lambda` 并没有像 `define` 那样，将过程联系环境中的名称。也就是说，`define` 和 `lambda` 的关系可以这样表示：
   ![[define-lambda.png]]
2. 语言上的 `lambda` 的理解如下：
   ![[lambda-expression-language.png]]
3. `lambda` 的组合使用：
   ![[lambda-combination.png]]
### Using let to create local variables 
1. `let` 用作程序中的局部变量声明。
   ![[let.png]]
   ![[let-for-language.png]]
2. `let` 的两个特点
	1. `let` 允许将变量绑定到尽可能局部的地方。
	2. `let` 中变量的值在 `let` 外计算。
### Exercise
- 1.34：（以应序求值理解）这个程序应该报错。因为 `(f f)` 求值时，优先替换掉后面的 f，也就是 `(f (g 2))`，然后对 `(g 2)` 求值，这时候 `g` 是未知的所以会报错。
## 1.3.3 Procedures as General Methods
### Finding roots of equations by the half-interval method
1. 这里写了 search.scm，之后又修改为了 half-interval-method.scm 通过给定函数和取值范围，获取函数结果的近似值。前所未有的体验。
### Finding fixed points of functions 
1. 平均阻尼（_average damping_）：一种无限逼近问题解决方法的技术。
2. 固定点（_fixed point_）：如果 x 满足 `f(x) = x`，那么就说 x 是 f 的固定点。
### Procedures as Returned Values
### Newton's method 
