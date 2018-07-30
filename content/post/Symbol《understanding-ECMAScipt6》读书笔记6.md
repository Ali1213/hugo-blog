+++
date = "2017-04-27T18:08:30+08:00"
title = "Symbol《understanding ECMAScipt6》读书笔记6"
categories = ["读书笔记"]
tags = ["ES6","javascript","understanding ECMAScipt6"]
toc = true
author = "ali"
author_homepage =  "http://ali1213.github.io/post/"
+++

## 什么是Symbol

+ ES6 新增的类型
+ 原始类型

<!--more-->
## 如何创建Symbol

+ 可以通过`new Object( Symbol() )`创建

注: 由于是原始类型，所以不能通过`new Symbol()`来创建

+ 通过`Symbol()`来创建
+ 可以加一段描述符，例如`Symbol("descrbe")`,描述符存储在内部的`[[Description]]`
+ 可以用`typeof`判断，结果是`"symbol"`
+ 可以用在`Object.defineProperty()`和`Object.defineProperties()`

```javascript
Object.defineProperty(person,{
    [Symbol()]:{
        value: "随便",
        writeable: false
    }
})
```

## 全局共享Symbols

ES6提供了一个全局可查的Symbol

### Symbol.for(key)

key为识别字符串
```
Symbol.for("uid") === Symbol.for("uid")  //true
```

### Symbol.keyFor(Symbol)

用于根据Symbol对象 找到对应的key

## Symbol强制类型转换

JavaScript中经常会有很多强制类型转换。
但是Symbol对象不行。
除非是`cosole.log()`和`String()`(默认调用Symbol.toString())。
其他的都会直接报错

## 检索对象的Symbol属性/方法

```javascript
//目前只有一个方法
Object.getOwnPropertySymbols()
```

## Symbol的一些方法

### Symbol.hasInstance

作用
```javascript
let arr = [];
arr instanceof Array;
Array[Symbol.hasInstance](arr)
//上面两句话是等价的
//是个函数
//1个参数
```


+ 每个函数都有这个方法
+ 该方法定义在`Function.prototype`,以便保证所有的函数都可以继承这一方法
+ 该方法不可写，不可配置，不可枚举
+ 可以用`Object.defineProperty()`重写

### Symbol.isConcatSpreadable

决定在`Array.prototype.concat()`作用时是否展开
```javascript
//属性，值为true or false
let a = [1,2,3];
a[Symbol.isConcatSpreadable] = false;
[].concat(a)
//[[1,2,3]]
```

### Symbol.match

调用match()方法时会调用的方法

### Symbol.replace

调用replace()方法时会调用的方法

### Symbol.search

调用search()方法时会调用的方法

### Symbol.split

调用split()方法时会调用的方法

注：可以通过上面的四种方法创建一个对象，实现一些特殊效果

### Symbol.toPrimitive

当需要转为原始值时，调用该方法，

1参，参数有三个值，

+ 当参数是`"number"`, 返回数字
+ 当参数是`"string"`，返回字符串
+ 当参数是`"default"`，根据类型返回不同
    - 对大部分类型，先调用`valueOf()`，如果得到原始值，返回。否则调用`toString()`，如果得到原始值，返回，否则报错
    - Date对象，先调用`toString()`，如果得到原始值，返回。否则调用`valueOf()`，如果得到原始值，返回，否则报错
    
    
仅当`==`、`+`、传参入Date构造函数时使用`"default"`模式，


### Symbol.toStringTag

在ES5中，有的时候会用到下面的方法

```javascript
Object.prototype.toString.call([]) === "[Object Array]";
//接下来是见证奇迹的时刻

Array.prototype[Symbol.toStringTag] = "shenme"
Object.prototype.toString.call([]);
//"[object shenme]"
```

### Symbol.unscopables

js有一个各种人都不推荐用的方法叫做with
ES6还是在兼容它
但是一些方法在with内部是不会暴露出来的

```javascript
//ES6默认配置
Array.prototype[Symbol.unscopables] = Object.assign(Object.create(null), {
    copyWithin: true,
    entries: true,
    fill: true,
    find: true,
    findIndex: true,
    keys: true,
    values: true
});
```

Symbol虽然在我目前的工作中基本上没有用到过，个人觉得主要可以用来定义私有变量和属性

