+++
date = "2017-06-08T20:04:51+08:00"
title = "数组的增强 -《understanding-ECMAScipt6》读书笔记10"
categories = ["读书笔记"]
tags = ["javscript","ES6","understanding ECMAScipt6"]
toc = true
author = "ali"
author_homepage =  "http://ali1213.github.io/post/"
+++


# 前言

前两天看了别人写的博客，对某些知识点挖掘的深度和对知识点描述语言的通俗令我赞叹。
我写的这一系列读书笔记的初衷是想写给自己备忘的。
最初的目的，是想要翻到这个文章，就能够自己看的懂描述。
毕竟有些东西，不常用，细节不一定记得那么清楚。

<!--more-->

# 新的方法

## `Array.of()`

旧的构造数组方式`new Array()`的行为诡异，如果只传入一个参数，并且这个参数是数字，那么会构造出来一个长度为这个数字的数组。

`Array.of()`统一了行为，加入的项只会是数组的内容。

##　`Array.from()`

在ES5中，如果需要将类数组转变为数组，需要下面的代码:

```javascript
let arr = Array.prototype.slice.call(arrayLike);
```

ES6中，我们可以使用Array.from():

```javascript
/*
* Array.from(arrayLike[, mapFn[, thisArg]])
* 一参为类数组
* 二参为类似map的函数
* 三参为函数的this指向
*/
let arr = Array.from(arrayLike)

```

## `Array.prototype.find(callback[,thisArg])`

callback有三个参数，item,index,thisArray
thisArg为callback的this指向

返回值为通过callback测试的值的集合，若无，则为`undefined`

## `Array.prototype.findIndex(callback[,thisArg])`

和find方法的区别就是，返回值是通过callback测试的索引值的集合

## `Array.prototype.fill(特定的值[,起点][,终点(可为负)])`

好像没有什么好描述的
对了，这个主要用在类型数组（typed array）

## `Array.prototype.copyWithin(target[, start][, end])`

数组内部的自复制,感觉有点难理解，还是上一段代码吧。

```JavaScript
['alpha', 'bravo', 'charlie', 'delta'].copyWithin(2, 0);

// results in ["alpha", "bravo", "alpha", "bravo"]
```
target，目标的起始位置
start，复制的起始位置，默认为0
end，复制的终点位置，默认为数组最后一项的位置
这个主要用在类型数组（typed array）

# Typed Array

Typed Array 主要是为了WebGL 和OPEN GL ES2.0设计的

## 数字类型

+ int8
+ uint8
+ int16
+ uint16
+ int32
+ uint32
+ float32
+ float64

## Array Buffers

### 创建buffer

```javascript
let buffer = new ArrayBuffer(10) //调用c的malloc()方法，创建一个10字节的buffer
let buffer2 = buffer.slice(4,6)//生成新buffer，渠道上一buffer的4和5位
```

### 用视图操作buffer数组

```javascript
//DataView(buffer[,byteOffset][,byteLength])
let buffer = new ArrayBuffer(10),
    views = new DataView(buffer,5,2);

view.byteOffset //5
view.byteLength //2
```

### 读写数据


下面是操作8字节的方法， 操作16字节和32字节整型的方法只需要将下列方法中的8替换为16或者32.
+ `getInt8(byteOffset, littleEndian)`
+ `setInt8(byteOffset, value, littleEndian)`
+ `getUint8(byteOffset, littleEndian)`
+ `setUint8(byteOffset, value, littleEndian)`

下面是操作浮点数的方法

+ `getFloat32(byteOffset, littleEndian)`
+ `setFloat32(byteOffset, value, littleEndian)`
+ `getFloat64(byteOffset, littleEndian)`
+ `setFloat64(byteOffset, value, littleEndian)`

我擦，感觉好麻烦。不过，也有简化一点的法子

### 创建特定类型的视图

```javascript
//Int8Array(buffer[,byteOffset][,byteLength])
let buffer = new ArrayBuffer(10),
    views = new Int8Array(buffer,5,2);

view.byteOffset //5
view.byteLength //2
```

可以将以下对象作为参数传入构造函数

+ A typed array
+ An iterable
+ An array
+ An array-like object 

各种类型构造函数

+ `Int8Array(buffer[,byteOffset][,byteLength])`
+ `Int16Array(buffer[,byteOffset][,byteLength])`
+ `Int32Array(buffer[,byteOffset][,byteLength])`
+ `Float32Array(buffer[,byteOffset][,byteLength])`

这些方法的属性

+ byteOffset
+ byteLength
+ length
+ buffer

## 类型数组和正常数组相同点

### 可以通过索引值直接取值

值得注意的是，类型数组无法改变长度

### 共同的方法

+ copyWithin()
+ findIndex()
+ lastIndexOf()
+ slice()
+ forEach()
+ map()
+ some()
+ fill()
+ indexOf()
+ reduce()
+ sort()
+ filter()
+ join()
+ reduceRight()
+ entries()
+ values()
+ keys()
+ reverse()

虽然方法是一样的，但是还是有些细微的差别

+ 会检测返回的数组的数字类型是不是合理
+ 根据`[Symbol.species]`确定返回的是类型数组还是常规数组

### iterator接口

都具备iterator接口。
类型数组通过...接口时，会转换成常规数组

### `of()`和`from()`方法

类型数组返回的都是类型数组


## 类型数组和正常数组不同点

+ 类型数组的长度不可改变
+ 类型数组中的项，如非正常数字，则替换为0
+ 有些正常数组的方法，类型数组是没有的。因为类型数组不能改变数组长度，所以`concat()`,`shift()`,`pop()`,`unshift()`,`push()`的方法是没有的。

## 类型数组新增的方法

### `TypedArray.prototype.set(typedarray/array [,offset])`

第一个参数可以使类型数组或者常规数组
二参为写入类型数组的起始位置，默认为0

### `TypedArray.prototype.subarray([begin [,end]])`

第一个参数为拷贝数组的起始位置，默认为0
二参为拷贝数组的终止位置，默认为数组的长度


