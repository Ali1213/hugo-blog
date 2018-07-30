+++
date = "2016-04-19T23:17:47+08:00"
title = "锋利的jQuery-读书笔记"
categories = ["读书笔记"]
tags = ["javascript","锋利的jQuery"]
toc = true
author = "ali"
author_homepage =  "http://ali1213.github.io/post/"
+++

## 前言

之前一直在看秒味课堂的视频，最开始看css2和html的话还挺好，各种课后作业可以做。后来看css3、html5、jq、anglarjs的时候，就感觉有点像介绍概念，且没有了一些官方布置的练习的题目，导致自己学完一遍没有记忆下来的思维。最近蛮想找份工作养活自己，但投的简历都是石沉大海，所以心态也是相当不稳定。妈妈今天做手术，昨天晚上整夜失眠睡不着，下午睡了两个小时，真是学也学不进去，睡也没办法睡，所以抱着之前买的《锋利的jQuery》在床上看。

<!-- more -->

## 《锋利的jQuery》第一章

最开始看秒味视频的时候，`<script>`标签里面放的都是window.onload = function(){};
而jQuery 中用的是 `jQuery()`、`$()`、`$(document).ready()`其实都是document.ready = function(){};
他们之间有什么差异呢？终于在这本书上找到了答案
差异：
1. window.onload 不能同时编写多个，后面的window.onload=function(){}会取代前面的，而document.ready则可以。
2. window.onload 意味着其后面跟着的函数是在整个页面加载完成后（包括图片元素），才会执行，而document.ready是等待页面中的DOM结构绘制完毕就执行。

据我个人的见解，window.onload这样对于那些大量图片的网站其实用户体验会比document.ready要差一些，但同时又有了新的问题，如果要操作一个图片的宽和高这些属性，用document.ready，但是图片还没有加载玩，这样会不会带来一些问题？
经查阅，这样肯定会有问题的，jQ提供了一个元素的操作方法：load();可以`$(window).load()`其实就是`window.onload`，或者把load时间加载到元素身上。

## 简单的笔记汇总

### 本书推荐的一些规范写法

1. 再秒味课堂有些视频看到的是 `var aLi = $(li)`,在本书中，推荐如果获取的对象是jQ对象，则在变量前加上$,用与和原生对象的区别，如：`var $aLi = $(li)`;
2. 代码的风格格式，针对JQ长长的链式操作而言：
a. 对于同一对象不超过3个的，直接写成一行。
b. 对于同一对象较多操作，建议每行写一个操作，如：
```javaScript
$(this).removeClass('mouseout')
		.addClass('mouseover')
		.stop()
```
c. 对于多个对象少量操作，可以每个对象写一行，如果对象设计子元素，可以考虑缩进。

### 其他内容

#### JQ对象和原生对象之间不能够混用

如果需要混用，可以通过转换的方法：

JQ对象转换成原生对象，采用[index],或get(index),如`$('li').get(3).style.display = "none"`

原生对象转换为JQ对象，只需像这样$(DOM对象)；

#### 解决JQ库和其他库之间的冲突

如果JQ库放在其他库之后导入：

1. 加入`jQuery.noConfict()`,然后不用$(),直接使用jQuery()代替。//可能因为$容易和其他程序冲突
2. 自定义一个快捷方式，如`$j = jQuery.noConfict()`，然后用$j()代替$();

如果jQ库放在其他库之前导入：

文中介绍的说你不使用$(),就可以了。//逗比的书，每次都用jQuery()很累的好不好，建议还是用上文的2方法。


我是一个刚刚闯进前端的小学生，如果上文中有什么错误的地方，还请您指正，不甚感激！
