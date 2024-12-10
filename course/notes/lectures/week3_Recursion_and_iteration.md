阅读：1.2 - 1.2.4 章（pages 31-72)

1. 这一周的关键是有关效率（_efficiency_），这里的效率是关于算法的（_algorithms_），而不是计算机的硬件。
$$
f(x) = \Theta(g(x)) \Leftrightarrow \exists k, N \, | \, \forall x > N, |f(x)| \leq k \cdot |g(x)|
$$
- 对公式解释说明：函数 f(x) 的渐进增长与 g(x) 是等价的。这种等价关系是指存在常数 k 和 N，使得对于所有 x>N， f(x) 的绝对值不超过 k 倍的 g(x) 的绝对值。
	- k 表示某个系数；x 表示函数的参数；N 通常情况下考虑较大的值。
	- **∃k, N** 表示存在常数 k 和 N，
	- **∀x > N** 表示对于所有 x 大于 N 的情况
	- **|f(x)| ≤ k · |g(x)|** 表示在这些 x 值上，f(x) 的绝对值被 g(x) 的绝对值乘以常数 k 所界定
	- **⇔** 表示逻辑符号，”当且仅当“（**if and only if**，缩写为 *iff*）。这个符号用于说明两个条件是完全等价的，意味着一个条件成立当且仅当另一个条件也成立。
	- **|** 表示存在某种关系。
	- 补充
		- $|f(x)|<=k*|g(x)|$ 只需要关注正数即可。

2. 效率主要考虑两方面：时间复杂度和空间复杂度。
	- 时间复杂度，考虑的是程序的**运行时间**。
	- 空间复杂度，考虑的是程序**所使用的内存**。

3. 通常情况下，迭代程序较好的空间复杂度，但是程序本身会变得过于复杂。比如：
```scheme
; 递归版本
(define (count sent)
  (if (empty? sent)
      0
      (+ 1 (count (bf sent))) ))
```

```scheme
; 迭代版本
(define (count sent)
  (define (iter wds result)
    (if (empty? wds)
        result
        (iter (bf wds) (+ 1 result)) ))
  (iter sent 0) )
```

4. 算法主要涉及以下几类问题
	1. 排序问题
		- $\theta(1)$
		- $\theta(\log N)$
		- $\theta(N)$
	2. 搜索问题
		- $\theta(N\log N)$
		- $\theta(N^2)$
	3. 先对晦涩的问题，如矩阵问题
		- $\theta(N^3)$
	4. 棘手的问题
		- $\theta(2^N)$
		- $\theta(N!)$
		- $\theta(N^N)$

5. 其他
	- 数学是计算机科学的核心。
