+++
date = "2017-10-10T21:33:28+08:00"
title = "对象、类、原型和委托《你不知道的JavaScript-上》读书笔记2"
categories = ["读书笔记"]
tags = ["ES6","javascript","你不知道的JavaScript"]
toc = true
author = "ali"
author_homepage =  "http://ali1213.github.io/post/"
+++

## 前言

这本书类和行为委托的部分忍不住看了第二遍。觉得观点很新颖，很有意思。

<!--more-->

## new调用函数的步骤

+ 创建一个全新的对象
+ 为新对象执行[[prototype]]连接
+ 为新对象绑定函数调用的this
+ 如果函数没有返回其他对象，new表达式的函数调用会自动返回这个新对象

## 绑定的优先级

从弱到强

+ 默认绑定
+ 隐式绑定  上下文对象中函数调用等
+ 显式绑定  call,apply,bind
+ new调用

绑定的例外

如果显示绑定中传入null 或者undefined作为this，则该显示绑定被忽略。
用null可能会出问题，更安全的做法是使用`{}`，或者`Object.create(null)`，后者比前者少一个Object.prototype的委托

## 一些新方法备忘

+ `Object.preventExtensions()`
    - 禁止添加新属性
+ `Object.seal()`
    - 在现有对象上调用`Object.preventExtensions()`，并把所有属性的`configurable`设置成`false`
+ `Object.freeze()`
    - 在现有对象上调用`Object.seal()`，并把所有属性的`writable`设置成`false`
+ `Object.propertyIsEnumerable`
    - 检查属性名是否存在于对象（而不是对象的原型链上），且`enumerable`为`true`

## 类风格的继承

设置原型时推荐 `child.prototype = Object.create(super.prototype)`;

查阅高级程序设计上是`child.prototype = new Super()`;

书上的解释其实我不太能理解

## 类和委托

作者推崇委托的概念。

传统的类在被实例化的时候，它的行为（方法）会被复制到实例中去，当类被继承的时候，行为（方法）会被复制到子类中去。
而Javascript中所有的函数只能被引用而不是复制。

比较了行为委托和仿类式继承

+ 代码简单
+ 对象之间关联关系简单
+ 不需要有类似显式伪多态这种丑陋的语法


比较了行为委托和ES6 class

+ ES6只是语法糖，并没有改变内部复杂性
+ super()实现了相对多态，但super定义是静态的，会带来某些问题
+ 在继承关系中需要建立共享属性的话，还是需要用到丑陋的prototype


## 属性的设置与屏蔽

`myObject.foo = 'bar'`;

当foo属性存在于原型链的上游时，会出现三种情况:

+ 当[[prototype]]上有foo，且writable为true时，直接在`myObject`上添加
+ 当[[prototype]]上有foo，且writable为false时，严格模式报错，非严格模式则忽略
+ 当[[prototype]]上有foo，且foo是一个setter,则调用这个setter