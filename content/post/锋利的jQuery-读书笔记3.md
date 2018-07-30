+++
date = "2016-05-15T16:41:24+08:00"
title = "锋利的jQuery-读书笔记3"
categories = ["读书笔记"]
tags = ["javascript","锋利的jQuery"]
toc = true
author = "ali"
author_homepage =  "http://ali1213.github.io/post/"
+++


## 前言

前阵子在知乎上看到有一个问题是：“JQ有没有过时”，感觉最悲惨的事情莫过于，你还是刚刚开始熟练，别人却在讨论JQ的过时。随着ES6的诞生，还有AngularJS,ReactJS以及等等的出现，JQ的使用频率确实大不如前。但JQ的思想一直会存在，及时其被抹去了JQ这两个字的标识。
作为一个新手，我还是老老实实看书比较好。。

<!-- more -->

### JQuery中的DOM操作

#### 概念

首先，将我以前一直分不太清的DOM操作分了个类。
- DOM Core
	只要支持DOM语言设计的都可以支持使用它，用途不限于网页，可以处理任何一种使用标记语言写出来的文档，比如XML（然而我并不知道这个是什么鬼），for example： getElementById()
- HTML-DOM
	只能操作HTML，相比DOM而言一般简单一些，比如表单的一些操作：document.forms，比如src属性的获取：elements.src;
- CSS-DOM
	针对css操作，主要是通过style实现的，如element.style.color等等

#### 查找节点

- 元素节点
	主要通过$()实现，或者通过$().text(),获取文本节点，
- 属性节点
	主要通过attr();

#### 创建节点

	一个$('要创建的内容') 搞定，元素，文本，属性，都直接写在里面，简单粗暴，一方面也遭人诟病。

#### 插入节点

- append()、appendTo()
- prepend()、prependTo()
- before()、 insertBefore()
- after()、insertAfter()
太简单，不细说

#### 删除节点

- remove()
	特点：返回值是删除的元素，可以传参进行筛选，绑定事件会永久删除
- detach()
	特点：与remove()区别，不会删除绑定事件
- empty()
	特点：删除后代节点，这个使用可会“断子绝孙”啊。。。

#### 复制节点

- clone()
	特点：参数传入true，会复制绑定事件

#### 替换节点

- replaceWith()
- replaceAll()

一个主动一个被动，replaceWith()主动

注：会抹去元素的绑定事件。

#### 包裹节点

- wrap()
- wrapAll()
- wrapInner()

这个可不是一个主动一个被动，wrap()是单个打包
如`$('strong').wrap('<p></p>')`是HTML中每一个<strong>外面都包裹一个<p>.
wrapAll()就霸道多了，`$('strong').wrapAll('<p></p>')`不仅只用一个袋子<p>打包所有的<strong>，而且还把非<strong>的东西都丢在袋子外面（元素节点后面）。
wrapInner()是内部打包,相当于给里面所有的元素多套了一层袋子。

#### 属性操作

- 获取设置
	+ attr()
	+ html()
	+ text()
	+ height()、weight()
	+ val()、css()
- 删除属性
	+ removeAttr()
	+ removeProp() //这个不是很懂，标记下，下次用一下

#### 样式操作（个人理解就是class操作）

- 获取样式和设置样式
	+ attr() //如 attr('class');
- 追加样式
	+ addClass()
- 移除样式
	+ removeClass()
- 切换样式
	+ toggleClass() //这个貌似挺好玩的，你有这个class就remove，没有就add
- 判断
	+ hasClass() //据说其实用的是is()判断的

#### 设置获取HTML、文本和值

对应就是html()/text()/val()
说下val()的一个独特用法，可以选中seclect/checkbox/radio
如select的ID为sel,则通过`$('#sel').val(['value值',…])`可以呈现选中某些选框的效果

#### 遍历节点

- children()
	匹配元素的子元素集合
- next()
	下一个同辈元素
- prev()
	上一个同辈元素
- siblings()
	带s的,匹配同辈的所有兄弟
- closest()
	单个元素，填入筛选条件，从自己开始找起，找祖先节点，
- present()
	找爸爸
- presents()
	找祖先，不同于closest()，是从父节点开始找，而且是个集合，可以填入筛选内容
- find()
	找孩子。内填筛选内容
- filter()
	在已经找到的集合内筛选，内天筛选内容
- nextAll()
	下面所有的同辈元素
- prevAll()
	上面所有的同辈元素

#### CSS-DOM操作

- css()
	特点：1.可以获取到外部设置的样式表的值
	2.如果填入的是数字，会自动转换为px
	3.加引号可写类似"background-color"，不过感觉还是驼峰风格更为统一
- opacity()
	没什么说的
- height()
	和css('height')的区别，css('height')获取的是样式表设置的值，所以可能会是auto或者加了px，而height()获取的是经过电脑计算的
- offset().left/offset().top
	获取元素相对于当前视窗的相对偏移
- position().left/position().top
	获取元素相对于上一个定位为relative或absolute的祖先节点的相对位置
- scrollTop()/scrollLeft()
	获取元素的滚动条距顶端的距离和距左侧的距离



我是一个刚刚闯进前端的小学生，如果上文中有什么错误的地方，还请您指正，不甚感激！