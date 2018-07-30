+++
date = "2017-05-19T14:16:26+08:00"
title = "Sets和Maps《understanding ECMAScipt6》读书笔记7"
categories = ["读书笔记"]
tags = ["ES6","javascript","understanding ECMAScipt6"]
toc = true
author = "ali"
author_homepage =  "http://ali1213.github.io/post/"
+++

# 前言

让我们来愉快的立一个Flag:
每周写一篇文章
<!--more-->


# Set


## 介绍
值（value）的集合，存储任一类型的唯一值，无论是原始还是引用，不能重复

## ES5实现的类Set

```javascript
var set = Object.create(null);
set.foo = true;

if(set.foo){
    //do something
}
```

存在的问题:
+ 对象的属性都是`String`格式，举例来说，5和'5'是等价的
+ 如果key值为`Object`对象，则会调用`toString()`，使之变为`[object object]`

## 属性和方法

添加值时内部使用Object.is()去判断是否有相同值，如果相同，则忽略

### `new Set()`

1参，可选，参数为数组

### `Set.prototype.add()`

1参，必选（如果没有则传入`undefined`），加入Set，返回值为该Set

### `Set.prototype.has()`

1参， 返回值为true或false

### `Set.prototype.delete()`

1参，需要删除的值，返回true(删除成功)或false(删除失败)

### `Set.prototype.clear()`

删除所有值

### `Set.prototype.forEach()`

和数组的forEach()一样
2参，
1参为函数，函数有三参，分别为value,value,set,是的，你没有看错，因为Set 是value的集合，所以没有key
2参为1参中函数的this

### `Set.prototype.entries()`

返回一个Generate函数, Generate函数.next()后返回值的value的是`[value,value]`

### `Set.prototype.values()`

返回一个Generate函数, Generate函数.next()后返回值的value的是`value`


### `Set.prototype.size`

返回Set的长度

## 小技巧 - 数组去重

```javascript
//利用...
const duplication = function(arr){
    return [...new Set(arr)]
}

```

# Weak Sets

使用Set需要注意的是：

存在Set内的值 = 存在对象引用 = set存在时，无法被垃圾回收

so: Weak Set 出来了

使用Weak Set需要注意的是:
+ Weak Set只存储数据引用，不能存储原始类型，添加原始类型会报错
+ 如果只有Weak Set保存引用时，垃圾清理机制可以回收它

## 特性

+ 支持add(),has(),delete()方法
+ 非iterable结构，不能用for-of循环
+ 无法从里面取到值
+ 没有forEach()等遍历方法
+ 没有size属性

# Maps

## 介绍
键值对{key:value}的集合，key存储任一类型的唯一值，无论是原始还是引用，不能重复

## 属性和方法

添加值时内部使用Object.is()去判断是否有相同值，如果相同，则忽略

### `new Map()`

1参，可选，参数为数组, 例如:
```javascript
new Map([ [key1,value1],[key2,value2]);
```

### `Map.prototype.set()`

1参，必选（如果没有则传入`undefined,undefined`），加入Map，返回值为该Map

```javascript
let a = new Map();
a.set(key,value);
```

### `Map.prototype.get()`


1参，参数为需要取的值的key,返回键值对的value,如果没有这个key，则返回undefined

### `Map.prototype.has()`


1参，参数为需要取的值的key,返回值为true或false

### `Map.prototype.delete()`

1参，需要删除的值的key，返回true(删除成功)或false(删除失败)

### `Map.prototype.clear()`

删除所有值


### `Map.prototype.forEach()`
2参，
1参为函数，函数有三参，分别为value,key,Map
2参为1参中函数的this



### `Map.prototype.entries()`

返回一个Generate函数, Generate函数.next()后返回值的value的是`[value,key]`

### `Map.prototype.values()`

返回一个Generate函数, Generate函数.next()后返回值的value的是`value`

### `Map.prototype.keys()`

返回一个Generate函数, Generate函数.next()后返回值的value的是`key`

### `Map.prototype.size`

返回Map的长度


# Weak Maps


使用Weak Map需要注意的是:
+ Weak Map存储的键值对的key必须是对象，如果不是对象，则抛出异常
+ 如果只有Weak Map保存引用时，垃圾清理机制可以回收它



## 特性

+ 支持set(),has(),delete()方法
+ 非iterable结构，不能用for-of循环
+ 无法从里面取到值
+ 没有clear()方法
+ 没有forEach()等遍历方法
+ 没有size属性


## 使用场景
+ 将DOM元素以Key的值存起来
+ key->Object,value->该Object私有的数据
