+++
date = "2017-05-31T13:04:41+08:00"
title = "iterators & generators-《understanding ECMAScipt6》读书笔记8"
categories = ["读书笔记"]
tags = ["ES6","javascript","你不知道的JavaScript"]
toc = true
author = "ali"
author_homepage =  "http://ali1213.github.io/post/"
+++


# 前言

果然不能立flag，上次文章都写完了，可是hexo出了点小问题，再加上正好回家，所以延后了几天。

发现之前一直提到 迭代器 和 生成器的字眼。其实一直没有讲这方面的东东。iterators 在es6中应用的还是挺广的，set，map，array，string都有这样的入口，generators是es7中async的基础。个人认为还是挺重要的。

<!--more-->

# iterators

很多语言都有iterators的概念。
在ES6中：
for-of循环基于iterators
...(扩散操作符)基于iterators
甚至异步程序也用到iterators

## 为什么需要iterators

### 循环存在的问题
 需要多个变量去标记它，通用的比如i,len；
（其实这点我个人还不是很能理解）

### iterators是什么

iterators是一个拥有next()方法的对象，每次调用next()方法，返回一个下面的结构

```javascript
{
  done: false, //表示是否到达循环的终点
  value: //该项的值
}
```


## ES6中内建的iterators

### 集合对象

ES6 有三个类型的集合对象
  + Arrays
  + Maps
  + Sets

他们都有以下的方法
  + entries(),返回一个[key,value]的iterators
    - Arrays返回的key为数字序号
    - Sets,返回的key和value一样的值
    - Maps，返回的key为正常的key
  + keys(),返回key的iterators
    - 跟entries()中返回key是一样的
  + values(),返回一个values的iterators
    - 跟entries()中返回value是一样的


如果不指定迭代器方法的话，
Arrays和Sets调用的是values(),Maps调用的是entries()

判断一个对象是不是迭代器  `typeoof Object[Symbol.iterator] === 'function'`

### String迭代器

ES5中string存在效率低，无法识别双字节字符的情况。
ES6中解决了无法识别双字节字符的bug

### NodeList迭代器

在ES5 中DOM的Nodelist和arrays区别很容易让人困惑
ES6为DOM的Nodelist也增加了一个默认的迭代器，同数组一样，所以也可以使用for-of去循环

### ...操作符

...操作符是从迭代器中读取数据并依次插入的

# generators

## 什么是generators

+ generators是一个返回值是iterators的函数
+ generators在function关键字后有*号并且内部有yield关键字，*号不一定要紧跟在function关键字后面
+ 生成器执行时会在每次yield后停止执行，注：yield关键字只能存在于generators内部
+ 书写在对象内部的方法

```javascript
let o1 = {
  createIterator:function*(){

  }
}

let o2 = {
  *createIterator(){

  }
}
//这两种都可以
```

## generator 传参

往next()内传参的话，会替换掉上次yield的返回值。
```javascript
function *createIterator(){
  let first = yield 1;
  let second = yield first + 2;
  yield second + 3;
}
let iterator = createIterator();

iterator.next() //{value:1,done:false}
iterator.next(4) //{value:6,done:false}
iterator.next(5)//{value:8,done:true}
```

## generator 抛异常

iterator.throw()

+ 在预计抛出异常的时候，可以用try..catch捕获
+ 如果异常被捕获，则throw()相当于next()返回的结果
+ 如果generator内有return ，则return 后面的代码均不会执行

## generator内可嵌套generator

# 异步任务执行

利用generator的特性执行多个异步任务，后续可以用Promise()进行改造

## 普通任务

该任务不需要利用上一步任务的返回值。
```javascript
function run (tasks){
  let task = tasks();
  let result = task.next();

  function step (){
    if(!result.done){
      result = task.next();
      step();
    }
  }

  step();
}


run(function * (){
  console.log(1);
  yield;
  console.log(2);
  yield;
  console.log(3);
})
```

## 带数据的任务

其实只变动了一处，将数据放在next()函数内部
```javascript
function run (tasks){
  let task = tasks();
  let result = task.next();

  function step (){
    if(!result.done){
      result = task.next(result.value);
      step();
    }
  }

  step();
}
```

## 异步运行任务

如果result.value是一个函数

```javascript
//假想的函数
function readFile(filename){
  return function(cb){
    fs.readFile(filename,cb);
  };
}

function run (tasks){
  let task = tasks();
  let result = task.next();

  function step(){
    if(!result.done){
      if(typeof result.value === 'function'){
        result.value(function(err,data){
          if(err){
            task.throw(err);
          }else{
            task.next(data);
            step();
          }
        })
      }

    }
  }

  step();
}
```

从上文代码中可以看的出来缺点:
+ 必须要求函数为err优先
+ 两个函数的参数传递依赖于next()