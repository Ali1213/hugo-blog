+++
date = "2016-05-16T21:18:23+08:00"
title = "锋利的jQuery-读书笔记4"
categories = ["读书笔记"]
tags = ["javascript","锋利的jQuery"]
toc = true
author = "ali"
author_homepage =  "http://ali1213.github.io/post/"
+++

## 前言

昨天晚上看完了JQ第四章, 话说其实每天要用电脑打字感觉挺累的。上班敲了一天的代码，下班感觉什么都不想动。
<!-- more -->

## jQuery中的事件和动画

### 事件

这章最开始讲了一大堆东西，概括起来就几个：
bind(),unbind();
我就一直在想，绑定事件有什么好处？然后就去查了下，结果没查出来，却发现在jQuery1.7的版本中已经用on()，和off()取代了上面两个，语法为：
```javascript
$(elements).on(event[,selector][,data],handle);
$(elements).on(event[,selector],handle);
```
个人片面理解，bind()的好处在于，可以给同一个元素绑定多个事件，如果你用click()的话，下一个click()就会覆盖上一个。第二个好处是可以绑定自定义事件，然并卵。
，然后讲了一个主动出发方法trigger(),以及主动触发但不引起浏览器默认事件（如果主动触发的事件是浏览器默认事件）triggerHandler()

### 动画

jQ中的动画运动事件都是默认400ms，可以指定slow(600ms),normal(400ms),fast(200ms);

+ show()/hide()

特性:1.同时改变宽高、透明度。运动结束时改变display值；
	2.hide()的时候会把display值记住，然后再次调用show()的时候赋值。

+ fadeIn()/fadeOut()
	感觉是弱版的show()/hide()，只能改变透明度。

+ slideUp()/slideDown()
	弱版show()/hide()，只改变高度。

+ animate(params,speed,callback)
特性:1.params是一个json
	2.发现一个有趣的用法animate({"left":+=500px},speed,callback),在原位置上累加500px;同理还可以-=
	3.通过链式操作，动画会排队等上一个动画执行完再执行，非动画的操作会插队（如css（）），必须在回调函数中使用才可以。

+ 停止动画 stop([clearQueue].[gotoEnd])
特性：1.两个参数值都是布尔值
	2.第一个参数为true，代表清空未执行完的动画队列，第二个参数为true代表将直接把正在执行的动画跳转到末状态。
	3.stop()只能改变当前正在执行的动画。

+ 判断是否在动画状态 is(':animated')

+ delay( time) 延迟动画，参数单位为ms

+ 其他动画
	- toggle(speed[,callback])  切换隐藏显示，就是你显示的状态，用这个动画就变成隐藏，你隐藏就变成显示的
	- slideToggle(speed[,easing][,callback])  高度变化，切换隐藏显示
	- fadeTo(speed,opacity[,callback])  透明度变化到设定值
	- fadeToggle(speed[,easing][,callback]) 透明度变化，切换隐藏显示

感觉今天速度还是快啊。最近又想买书了。

我是一个刚刚闯进前端的小学生，如果上文中有什么错误的地方，还请您指正，不甚感激！