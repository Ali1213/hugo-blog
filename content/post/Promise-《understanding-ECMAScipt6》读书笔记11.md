+++
date = "2017-07-05T00:09:59+08:00"
title = "Promise-《understanding-ECMAScipt6》读书笔记11"
categories = ["读书笔记"]
tags = ["ES6","javascript","understanding ECMAScipt6"]
toc = true
author = "ali"
author_homepage =  "http://ali1213.github.io/post/"
+++


# 前言

最近实在是发生太多事情。
昨天差点露宿接头，今天终于把房子搞定了。
接下来，又可以专心的写代码了。
<!--more-->

# 处理异步的方式（之前）

+ 事件模式
+ 回调模式

# 简介

promise是一个异步操作结果的占位符
promise有三种状态: pending, fulfilled, rejected

# Node.js错误处理
process对象有两个关于promise错误的事件:
`unhandleRejection`,`rejectionHandle`

```javascript
let rejected;
process.on("unhandleRejection",function(reason,promise){
    console.log(reason.message); // "Explosion!";
    console.log(promise === rejected) //true;
});
rejected = Promise.reject(new Error("Explosion!"));
```

```javascript
let rejected;
process.on("rejectionHandled",function(promise){
    console.log(promise === rejected) //true;
});
rejected = Promise.reject(new Error("Explosion!"));
```

`rejectionHandled`事件只有一个参数promise

# 浏览器错误处理
浏览器的错误处理稍有不同
```javascript
let rejected;
window.unhandleRejection = function(event){
    console.log(event.type); // unhandleRejection 
    console.log(event.reason.message) //"Explosion!";
    console.log(event.promise === rejected) //true;
});
window.rejectionHandled= function(event){
    console.log(event.type); // rejectionHandled
    console.log(event.reason.message) //"Explosion!";
    console.log(event.promise === rejected) //true;
});
```
# 链式调用

promise是一个thenable， 你可以直接return一个value,它会自动帮你包装成一个新的promise。当然，你也可以直接return一个新的Promise。

# `Promise.prototype.then(onFulfilled[,onRejected])`

onFullfilled : 成功后的回调函数
onRejected：错误后的毁掉函数

# `Promise.prototype.catch(onRejected)`

相当于`Promise.prototype.then(null,onRejected)`

# `Promise.all(iterable)`

当所有项都完成后进行下一步，或者当某一项出错后触发rejected
会将iterable里所有项结果按次序放在数组内。

# `Promise.race(iterable)`

当有一项完成后进行下一步

# `Promise.resolve(value/promise/thenable)`

# `Promise.rejected(reason)`