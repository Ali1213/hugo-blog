+++
date = "2017-04-25T18:33:46+08:00"
title = "对象的功能扩展-《understanding ECMAScipt6》读书笔记4"
categories = ["读书笔记"]
tags = ["ES6","javascript","你不知道的JavaScript"]
toc = true
author = "ali"
author_homepage =  "http://ali1213.github.io/post/"
+++

## 对象分类
ES6将对象分为以下几类:
+ 普通对象
+ 外来对象
+ 标准对象
+ 内建对象

<!--more-->

## 对象字面量的扩展

### 当key的名与 （value的变量名）一样时可以简写

```javascript
function (name,age){
    return {
        name,
        age
    }
}
```

### 字面量里面的方法名称可以简写

```javascript
var obj = {
  getValue(){
      //这里是函数内部
  }
}
```

### 计算属性名
记得当初在公司环境还是ES5的时候我踩过这个坑，我以为官方肯定有支持这个，but...。
```javascript
var a = Symbol();
var obj = {
    [a] : 666
}
```

## 新的方法

### Object.is()

传统的`===`you两个问题:
+ `-0 === +0`
+ `NaN !== NaN`

Object.is() 解决了这两个问题。传入两个参数，分别是比较的两端

### Object.assign()

一直以来，经常要自己写入一个浅复制的函数，去把两个对象合并为一个对象。Object.assign()解决了这个问题。
可以传入n个参数,第一个参数为receiver，其他参数依次将属性和方法添加到receiver。

+ 当出现同名时，后面的会覆盖前面的。//注意上文中**依次**这两个字就好
+ 浅复制
+ 不复制存取器，如get，只会将存取器复制为单纯的数据属性

### 对象字面量的属性重名

```javascript
var obj = {
    'a': 1,
    'a': 2
}
```
上面这段代码在ES5严格模式会报错，ES6则默认用后面覆盖掉前面。
//个人感觉这样更符合逻辑.

### 属性的枚举顺序

排序规则
+ 按数字属性，字符串属性，Symbols属性依次排列
+ 数字属性按升序排列，越大的排后面
+ 字符串属性按照添加顺序排列，后添加的放后面
+ Symbols属性按照添加顺序排列，后添加的放后面

影响的方法
+ `Object.getOwnPropertyNames()`
+ `Reflect.ownKeys()`
+ `Object.assign()`

不受影响的方法
+ `for in`
+ `Object.keys()`
+ `JSON.stringify()`

### `Object.setPrototypeOf()`

ES5中提供了`Object.getPrototypeOf()`，是通过读取内部方法[[Prototype]]的值，ES6则更进一步，提供了`Object.setPrototypeOf()`方法。
两个参数，1参为 对象，2参为 原型

### super关键字

用于获取该对象的原型（通过`Object,getPrototypeOf()`）。
注：该关键字只能用于简写的方法内，如下所示，

```javascript
let person = {
  getSuper(){
    return Super;
  }
}
```
虽然通过`Object.getPrototypeOf(this)`，也可以达到`super`的效果，但是`Object.getPrototype(this)`依赖于`this`关键字，而`this`关键字在某些情况下并不指向自身。
`super`依赖于内部方法[[HomeObject]]存储的Prototype的名称。
