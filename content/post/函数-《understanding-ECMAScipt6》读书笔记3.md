+++
date = "2017-04-17T12:35:56+08:00"
title = "函数-《understanding ECMAScipt6》读书笔记3"
categories = ["读书笔记"]
tags = ["javscript","ES6","understanding ECMAScipt6"]
toc = true
author = "ali"
author_homepage =  "http://ali1213.github.io/post/"
+++

##前言
其实这本书已经看完很久了。前几天突然有人在微信群里分享了别人的翻译版本。如果有些人会觉得这本书英文比较难理解，还是可以去找翻译版的看一看。
我还是接着回顾一下知识点吧。
<!--more-->

## 参数默认值

### 解决的问题
ES5中我们经常要写出这样的代码:
```javascript
var a = function(timeout,callback){
 timeout= timeout|| 2000;
 callback = callback || function(){};
}
```
传统的方式有两个方面困扰
+ 如果timeout或callback传入的值是0，"", null的会被默认值替代
+ 繁琐

下面是ES6的写法:
```javascript
var a = function(timeout = 2000,callback=function(){}){
}
```
此时只有传参进来的值是undefined，才会用默认参数复制
等同于
```
timeout = (typeof timeout !== "undefined")? timeout || 2000;
```

### 默认参数带来的arguments的变化

首先，假定一个函数
```
var a = function(first,second){
//<1>
fist = "c";
second = "d"
//<2>
}
a("a","b");
```

1. ES5 非严格模式下
无论是1处还是在2处
```javascript
first === arguments[0];
second === arguments[1];
```

2. ES5 严格模式
```javascript
//1处
first === arguments[0];
second === arguments[1];
//2处
first !== arguments[0];
second !== arguments[1];
```
3. ES6中默认参数的情况
```javascript
var a = function(first,second = "a"){
//first === arguments[0]
//second !== arguments[1]
fist = "c";
second = "d"
//first !== arguments[0]
//second !== arguments[1]
}
a("a","b");
```
### 默认参数的使用

1. 不仅可以赋值，还可以使函数返回值
```javascript
var getValue = function(a){
  return a;
}
var a = function(first, second = getValue(1)){
}
```

2. 由于second 默认参数是后于first解析的,还可以这样:
```javascript
var a = function(first = 1, second = getValue(first)){
}
```
下面是会抛错的，因为默认参数相当于let声明，是会有TDZ的。
```javascript
var a = function(first =  = getValue(second), second = 1){
}
```

## rest参数
某些时候你需要用到rest参数去简化函数的传参
```javascript
var a = function(first,...other){
}
```
需要注意以下两点:
+ rest参数必须是参数的最后一个
```javascript
var a = function(first,...other,third){ //error
}
```
+ 不能用在对象字面量set的时候
```javascript
var a = {
    set name(...value){//error
    }
}
//因为对象字面量的参数只允许有一个
```


## 对Function 构造函数的增强

+ 允许使用默认参数，示例如下:
```javascript
var a = new Function("first","second = first", "return first + second");
```

+ 允许使用rest参数，示例如下:
```javascript
var a = new Function("...args", "return args[0]");
```

## 扩散操作符...

扩散操作与rest参数有密切关系
rest参数：允许把多个独立的参数变为数组
扩散操作符: 允许把数组切割成独立的参数

使用场景：
需要使用apply调用的场合;

## 函数的name属性
匿名函数表达式的错误难以调试，ES6为所有函数添加了name属性。

+ 函数声明和函数表达式
```javascript
function dosomething(){}
//dosomething.name : "dosomething"
var doAnotherthing(){}
//doAnotherthing.name: "doAnotherthing"
```
+ 其他情况
```javascript
var dosomething = function dosomethingElse(){}
//dosomething.name : "dosomethingElse";
var person = {
    get firstName(){},
    sayName:function(){}
}
//person.firstName.name: "get firstName";
//person.sayName.name:"sayName";
var dosomething = function(){};
//dosomething.bind().name:"bound dosomething";
//(new Function()).name : "anonymous";

```

## 阐明函数的两种使用目的

在ES5中，调用函数时用new和不用new有两种不同的结果
```javascript
function Person(name){
  this.name = name;
}
//1
var person = new Person("ali");
//2
var notPerson = Person("ali");
```
比如说，在1调用的时候，返回了一个对象赋值给person,并将person.name设置为ali；而在2调用时，并

未返回值，并在global对象上创建了一个name属性

在ES6中，使用new则调用内部的[[construct]]方法实现这一效果，不使用new则调用内部的[[call]]方

法
注，不是所有的函数都有这两个内部方法，箭头函数就没有。

## new.target

在ES5中如果要判断函数是否用new方式调用，一般用instanceof，较为繁琐。
ES6增加了new.target
+ 如果通过[[call]]调用，则new.target === undefined
+ 如果通过[[construct]]调用，则new.targe === 这个类名;
+ 在函数外使用new.target会抛错

## 函数在块级作用域内状况
总所周知的一个bug
在ES3及以前，理论上讲函数声明在块级作用域会抛错，但基本上所有的浏览器都支持将函数写在块级作

用域内，但实现方式各有差异。
ES5中严格模式下， 函数声明在块级作用域下会抛错。

ES6严格模式下，函数声明在块级作用域的表现如同用let声明一样，只在块级作用域有效，有TDZ。
ES6非严格模式下，函数声明在块级作用域的表现如同用var声明一样。

## 箭头函数
+ 没有this，super,arguments,和new.target绑定
+ 不能用new调用
+ 没有原型

## 箭头函数的语法
```javascript
let reflect = value =>value;
//等同于
let reflect = function(value){
    return value;
}
```
```javascript
let sum (num1,num2)=>num1+num2;
//等同于
let sum = function(num1,num2){
    return num1+num2;
}
```

```javascript
let getName ()=>"ali";
//等同于
let getName = function(){
    return "ali";
}
//等同于
let getName ()=>{
   return "ali";
}



//等同于
let getName ()=> ("ali")
```

## 尾递归优化
ES6针对递归函数进行了优化，不过有几点限制。
+ 尾递归调用不需要调用当前栈的变量（所以闭包是不行的）
+ 函数在递归调用返回后不需要有进一步的操作
+ 尾递归调用的结果必须有返回函数值

