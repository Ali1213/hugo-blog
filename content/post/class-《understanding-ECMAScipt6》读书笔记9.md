+++
date = "2017-06-07T16:53:53+08:00"
title = "class -《understanding ECMAScipt6》读书笔记9"
categories = ["读书笔记"]
tags = ["javscript","ES6","understanding ECMAScipt6"]
toc = true
author = "ali"
author_homepage =  "http://ali1213.github.io/post/"
+++


# 前言

记得之前有一次面试，面试官问我，有几种面对对象的设计方式。
我一下懵了，，虽然高级程序设计的第六章我看了好多遍，但确实太久没有用了，如果没有准备面试是对面试官的不尊重，我确实有点失礼了。
有些人说，es6，没有必要记那么多种复杂的类的实现方式了。
我偏向于这种说法，prototype单词实在太长，而且类的实现方式隐晦难懂。
<!--more-->

# 示例

```javascript
/*
* class是关键字
* className是函数名称
* constructor函数等同于之前的函数constructor
* name 是往这个class传入的参数
* sayName 是给函数prototype上添加的方法
*/

class className {
  constructor(name){
    this.name = name;
  }
  sayName(){
    console.log(this.name);
  }
}
```

# 为什么用class方法

+ 不会变量提升，class声明类似于let声明
+ 函数内部的方法内部自动使用strict mode
+ 里面定义的所有方法都不可枚举
+ 所有的方法内部都有一个都有一个内部的[[Construct]]方法，如果new调用，会报错
+ 在class内部试图重写class名会报错

# 使用方法

类可以作为参数传入函数
类可以立即执行

```javascript
//类表达式
let PersonClass1 = class {/*内部代码省略*/};
//命名的类表达式
let PersonClass2 = class PersonClass22 {/*内部代码省略*/};
```

# 类内部方法的设定

##　get 

```javascript
class a {
  get methodName(){

  }
}
```

## set

```javascript
class a {
  set methodName(){
    
  }
}
```

##　生成器方法

```javascript
class a{
  *createIterator(){
    yield 1;
  }
}
```

##　static 静态方法

```javascript
class a {
  static methodName(){
    
  }
}
//static关键字不能用于constructor方法
//无法获取实例属性，简单的说，就是this底下的值
```

## 方法名称可以是变量

```javascript

let method = 'methodName'

let PersonClass = class {
  [method] (){
    //do something
  }
}
```

# 类的继承

## 示例

```javascript
//使用extends关键字
//可以用super()来调用父类的constructor
//如果在子类无constructor()，则自动调用父类的super()
class Child extends Parent{
//无constructor
}
//下例和上例相同
class Child extends Parend{
  constructor(args){
    super(...args);
  }
}
```

## super()

+ 只能在继承关系的子类使用super()
+ 必须调用super()，来初始化this
+ 惟一避免调用super()，是从class的constructor()中返回一个对象

## 备注

+ 可以在子类中屏蔽父类的方法
+ 可以通过继承静态方法
+ 可以从ES5写法的类中继承，只要父类有[[Constructor]]和prototype
+ 可以从内建对象中继承

## Symbol.species 属性

继承自内建对象，子类使用任何父类的方法，都会返回子类的实例
下列内建对象中有Symbol.species

+ Array
+ ArrayBuffer
+ Map
+ Promise
+ RegExp
+ Set
+ Typed arrays

## new.target

只可在类的constructor内使用。
在继承时，子类调用父类， new.target 不等于父类名称。
可以通过这个性质，阻止其他方法继承这个类。

