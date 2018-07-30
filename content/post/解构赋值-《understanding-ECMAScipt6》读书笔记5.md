+++
date = "2017-04-26T17:02:51+08:00"
title = "解构赋值-《understanding ECMAScipt6》读书笔记5"
categories = ["读书笔记"]
tags = ["javscript","ES6","understanding ECMAScipt6"]
toc = true
author = "ali"
author_homepage =  "http://ali1213.github.io/post/"
+++

## 对象解构赋值

```javascript
let node = {
    type: "string",
    name: "foo"
};
let {type, name} = node;
```
<!--more-->
需要注意的点：

+ 当等式右边是`null`或者`undefined`会报错
+ 如果等式左边有的值在等式右边找不到，则该值为`undefined`
+ 可以给左边设定默认值，且默认值只有当预期值`===undefined`才能够生效
+ 可以不使用默认名称，例`let {type:newType, name: newName} = node`
+ 上面两个可以组合使用
+ 可以使用嵌套子对象的结构赋值
    ```javascript
    let node = {
    name: "foo",
    othenInfo: {
        height: 188
        }
    };
    let {otherInfo:{height}, name} = node;
    ```
+ 解构的值只会赋值到key/value中的value

## 数组解构赋值

+ 可以交换对象，例：`let [a,b] = [b, a]`
+ 可以设定默认值
+ 可以解构嵌套数组
+ 可以使用rest写法，同函数中提到的一样，rest写法只能放在数组的最后一项

## 混合解构

可以将数组和对象混合体放在一起解构，然而并没有什么好说的。

## 常用方法

在函数设定默认参数时，例如
```javascript

setCookie(name, value, {secure, path, domain, expires} = {}){
    //dosomething
}

//给后面参数解构赋值为空对象时，就算传参进来的是undefined也不会报错
```
