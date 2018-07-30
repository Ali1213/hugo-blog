+++
date = "2017-03-15T221:30:22+08:00"
title = "字符串和正则表达式-《understanding ECMAScipt6》读书笔记2"
categories = ["读书笔记"]
tags = ["javscript","ES6","understanding ECMAScipt6"]
toc = true
author = "ali"
author_homepage =  "http://ali1213.github.io/post/"
+++

ES6增加了对字符串和正则表达式更好的支持
<!--more-->
## 更好的unicode支持

一些UTF-16编码的文字在ES5中出现一些问题
+ 识别为两个字节
+ 正则表达式匹配单个字符无法匹配上
+ `charAt()`方法无法识别
+  `charCodeAt()`方法无法返回正确结果

### `String.prototype.charPointAt()`方法
与`charCodeAt()`不同，该方法会在识别UTF-16编码的第一个字节会返回正确的结果。
but，第二个字节上与`charCodeAt()`结果并无不同。

### `String.prototype.formCodePoint()`方法
会返回正确结果

### `String.prototype.normalize()`方法
为了方便对不同编码的结果统一化，如æ与ae其实是等价的，但只有在normalize之后才会等价
1参，为"NFC"、"NFD"、"NFKC"、"NFKD"中一个,默认为'NFC';

### 正则表达式的u特符

+ 可以识别Unicode
`/^.$/u.test(ஷ)`
+ 可以通过上面的例子变相的实现计算字符串的真实长度（不过效率低）

## 字符串其他的变化
ES5里面只增加了一个trim()方法，ES6则增加了很多

### `String.prototype.includes()`方法

2参，第二参可选
1参为搜索的字符串
2参为搜索的起始位置

如果找到，返回true，没有则返回false

### `String.prototype.startsWith()`方法

2参，第二参可选
1参为匹配的字符串
2参为搜索的起始位置

如果字符串是以匹配的字符串开头的，则返回true，否则则返回false;

### `String.prototype.endsWith()`方法

2参，第二参可选
1参为匹配的字符串
2参为搜索的起始位置

如果字符串是以匹配的字符串结束的，则返回true，否则则返回false;

### `String.prototype.repeat()`方法

1参
1参字符串重复的次数
参数不能为负数，如果为小数是，使用其整数部分
返回重复n次（n为参数）的字符串


## 正则表达式的其他变化

### y特符

相当于对每次匹配的字符都加个`^`
则可通过 /我是测试/y.sticky 返回true或false判断有没有.

### 兼容
以下代码在ES5报错，ES6中不会
```javascript
var re = /ab/i,
  re2 = new RegExp(re,'g')
```
g会替换掉i

### flags属性

```javascript
var re = /ab/i;
re.flags //i
```

## 模板字符串

### 特性
+ 支持多行字符串。要换行，在换行位置加上\n
+ 对字符串基本的格式化。 ${}神器
+ HTML 安全转义




文笔简陋，如有错误，还请指正！谢谢！

