# standard 
笔记和代码组织的逻辑和标准。
## 笔记
1. 命名规范：
```bash
[类别]_[主题]_[子主题].md
```
例如：
- `week1_ch1.1_functions_and_abstraction.md`
- `week2_ch1.2_elements_programming.md`

2. 笔记notes目录结构：
```bash
notes/
├── lectures/                # 课程笔记
│   ├── week1_lecture1_intro.md
│   ├── week1_lecture2_functions.md
│   └── ...
├── concepts/               # 概念笔记
│   ├── concept_recursion.md
│   ├── concept_higher_order_functions.md
│   └── ...
├── summaries/             # 总结笔记
│   ├── summary_week1.md
│   ├── summary_midterm1.md
│   └── ...
├── textbook/              # 教材笔记
│   ├── ch1_functions.md
│   ├── ch2_recursion.md
│   └── ...
├── journal/               # 学习日志
│   ├── learning_journal_week1.md
│   └── ...
└── README.md             # 笔记目录说明
```

3. 笔记头信息
```markdown
---
title: "函数式编程基础"
date: 2024-01-15
week: 1
lecture: 2
topics: ["函数", "抽象", "组合"]
related: ["高阶函数", "Lambda表达式"]
---
```

## 代码
1. 命名规范：
```bash
[来源]_[周次/章节]_[类型]_[描述].scm
```
例如：
- `lecture_w01_demo_higher_order.py`
- `book_ch1.2_example_newton_method.py`