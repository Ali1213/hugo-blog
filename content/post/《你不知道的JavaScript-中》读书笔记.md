+++
date = "2017-10-18T00:53:13+08:00"
title = "《你不知道的JavaScript-中》读书笔记"
categories = ["读书笔记"]
tags = ["node.js","javascript","你不知道的JavaScript"]
toc = true
author = "ali"
author_homepage =  "http://ali1213.github.io/post/"
+++

## 前言

这本书的中册还是相当值得推荐的。
就算对在异步流程中已经踩过很多坑的我来说，也还是有些可以值得学习的东西。

只把自己记下来的东西写一下，推荐大家还是可以看书。
<!--more-->

## `JSON.stringify(obj,arg1,arg2)`

对于符合的JSON会转换，对于不符合的JSON 格式会忽略。不符合的JSON格式如下:

+ `undefined`
+ `function`
+ `symbol`

arg1 可以是一个数组，包含序列化之后留下来的属性名称
```javascript
JSON.stringify({a:1,b:2},['a'])  //'{"a":1}'
```

arg1还可以是一个函数，函数有两参，一个是key，一个是value

arg2是一个正整数，表示格式化后的缩进。这个在某些时候比较好用。例如谷歌浏览器的console.log的实现是一个异步的过程。所以想要准确的获得某个点的对象值，一个是debugger，另一个就是该对象的副本。我最常用的实现方式`JSON.stringify(obj,null,2)`。

## 一些难以理解但又可以解释的操作

```javascript
//parseInt系列
parseInt(1/0,19) // parseInt("Infinity",19) => parseInt("I",19) => 18
parseInt(0.000008) //0
parseInt(0.0000008) // parseInt("8e-7") => 8
parseInt(false,16) //parseInt("fa",16) => 250
parseInt(parseInt,16)//parseInt("function",16) => 15

//如果一边是字符串或数字，一边是对象，则x == ToPrimitive(y)
"42" == true  //false
"42" == false //false

//下面都是对的
0 == []
"" == []
false == []

//
[] + {} //[object object]
{} + [] // 0
```

##  一些不常用的东东

try{}catch(){}finally{} 中finally里面的return会覆盖catch和try中的return
DOM中的ID会在全局创建一个同名变量
ASI自动纠错机制，会根据换行自动插入分号

## promise

promise比回调好的地方
+ 回调不可信任，永远不知道回调是否是异步，导致执行顺序问题，某些情况下还会产生竞价状态
+ 代码逻辑不符合人脑

学到一个promiseify,可以将拥有回调函数并且错误优先的函数包装成一个promise
```javascript
// 注：nodejs的util包里面已经包含了util.promiseify
const promiseify = function(fn){
    return function(...args){
          return new Promise((rs,rj)=>{
                fn.call(null,...args,function(err,data){
                      if(err){
                              return rj(err);
                      }
                      rs(data);
                });
          });
    };
};
```