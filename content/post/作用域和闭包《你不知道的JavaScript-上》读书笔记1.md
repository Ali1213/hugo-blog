+++
date = "2017-10-08T00:28:58+08:00"
title = "作用域和闭包《你不知道的JavaScript-上》读书笔记1"
categories = ["读书笔记"]
tags = ["ES6","javascript","你不知道的JavaScript"]
toc = true
author = "ali"
author_homepage =  "http://ali1213.github.io/post/"
+++

## 前言

5月份的时候立了一个flag，然后就被打脸。
辞职，失恋。
新的工作，频繁的加班。
走三步退两步的减肥计划。
堕落……

今天看了电影《被嫌弃的松子的一生》
隐隐的害怕。

往前走吧。

<!--more-->

## 作用域

### 传统编译语言（执行前）

+ 分词/语法分析
    - 分解成词法单元
+ 解析/语法分析
    - 将词法单元流 --> AST树
+ 代码生成
    - AST树  --> 可执行代码


### LHS和RHS

赋值:LHS
取值和其他:RHS

### 作用域分类

#### 动态作用域

作用域作为运行时被动态确定的形式


```javascript

function foo(){
    console.log(a); //3
}

function bar(){
    var a = 3;
    foo();
}

var a = 2;

bar();

```

#### 词法作用域


```javascript

function foo(){
    console.log(a); //2
}

function bar(){
    var a = 3;
    foo();
}

var a = 2;

bar();

```

### 欺骗词法作用域

这样的写法均会导致浏览器内核对javascript编译时很多优化失效。从而降低性能。

#### `eval()`,`new Function()`

将对象的属性当做作用域的标识符，从而创建一个新的词法作用域。
老实讲，我也不太理解上面一句话是什么意思。

在严格模式下，eval无法修改当前词法作用域。

#### `with`

将一个对象的引用当做作用域来处理。

在严格模式下，with被禁用。

### 匿名函数表达式

#### 缺点

+ 错误栈难以追踪
+ 无法引用自身
+ 省略了描述性的名称

#### 解决方法:行内函数表达式

```javascript

(function aaa(){

})()

```

#### 解决全局undefined被赋值为true

```javascript
var undefined = true;

(function(undefined){

//do something
})()

```

### 块作用域

+ with
+ try/catch

#### 小应用

如果一段代码后面是异步操作，由于异步位于同一个作用域，用块作用域有利于垃圾回收机制

```javascript

//下面两行可用块作用域包裹，以便回收
var something = {/*...*/};
dosomething(something);

btn.addEventListener("click",function(evt){
    console.log("111");
})
```


### 提升

函数提升会高于变量提升，然后重复的var声明会被忽略
后面的函数提升会覆盖前面的函数提升

### 闭包

当函数可以记住并访问所在的词法作用域时，就产生了闭包，即便该函数是在当前词法作用域外执行。


