+++
date = "2016-05-01T19:03:25+08:00"
title = "锋利的jQuery-读书笔记2"
categories = ["读书笔记"]
tags = ["javascript","锋利的jQuery"]
toc = true
author = "ali"
author_homepage =  "http://ali1213.github.io/post/"
+++

## 前言
好几天因为各种事，也没有好好学习，内心不安。。今天忙完了。继续总结下《锋利的jQuery》第二章。
第二章主要是介绍了jQuery的选择器。jQ强大的选择器是实现各种效果的基础，熟练的使用有助于精简代码。
<!-- more -->
## jQ的选择器主要分为以下几类
+ 基本选择器
+ 层次选择器
+ 过滤选择器
    - 基本过滤选择器
    - 内容过滤选择器
    - 可见性过滤选择器
    - 属性过滤选择器
    - 子元素过滤选择器
    - 表单对象属性过滤选择器
+ 表单选择器

### 基本选择器

```
$("#test")   //选取id为test的元素
$(".test")   //选取class为test的所有元素
$("p")      //选取所有的<p>元素
$("*")      //选取所有的元素
$("div,span,p.myClass") //选取所有的div和span元素，选取class为myClass的<p>元素
```
基本选择器的最后一个例子，之前确实蛮忽视它的用法。用其他类型的选择器。结合基本选择器使用，应该会在很大程度上减少代码的长度。

### 层次选择器

```
$("div span")    //后代元素，选取<div>里面的所有<span>元素
$("div>span")   //子元素，选取<div>里面的子元素为<span>的元素
$(".one+span")
//紧跟的兄弟元素，选取紧跟在class为one的元素后面的同辈<span>元素。一定是紧跟，而且选择的是span元素。
//可以用$('.one').next('span')代替
$("#two~div")   //随后的兄弟元素，选取id为two的元素后面所有的<div>同辈元素
//可以用$('#two').nextAll('div')
```

### 过滤选择器

过滤选择器的语法和css中的伪类有一定的相似，都是用冒号：为开头。以下是按照不同的过滤规则分类的。

- 基本过滤选择器

```
$('div:first')
//选取所有<div>元素中的第一个<div>元素
$('div:last')
//选取所有<div>元素中的最后一个<div>元素
$('div:not(.selector)')
//选取所有div的class不为.selector的div，同理class也可以换成id或者其他作为筛选
$('div:even')
//选取索引是偶数的div元素
$('div:odd')
//选取索引是奇数的div元素
$('div:eq(1)')
//选取索引值为1的div元素
$('div:lg(1)')
//选取索引值大于1的div元素
//这阵子在看bootstrap,里面也用到了lg作为一个栅格的规格
$('div:lt(1)')
//选取索引值小于1的div元素
$(':header')
//选取网页中所有的标题
$('div:animated')
//选取所有正在运动的div元素
$(':focus')
//选取正在获得焦点的元素
```

- 内容过滤选择器
```javascript
$('div:contains('我')')
//选取含有文本中含有‘我’的<div>元素
//类似中关村、太平洋等的网站的品牌有一些高亮的效果，可以用该选择器删选标签。
$('div:empty')
//选取标签中不含任何子元素（包括文本节点）的<div>元素
$('div:has(.selector)'）
//选取所有含有class为.selector子元素的<div>元素
$('div:parent')
//选取所有含有子元素（或文本节点）的<div>元素
```

- 可见性过滤选择器
```javascript
$(':hidden')
//选取不可见元素，包括display:none,visibility:none,type='hidden'的元素
$('div:visble')
//选取所有可见元素<div>元素
```

- 属性过滤选择器
```javascript
//属性过滤选择器和css中的属性选择器基本一样。在此不详述
$('div[id]')
$('div[title=test]')
$('div[title!=test]')
$('div[title^=test]')
$('div[title$=test]')
$('div[title*=test]')
$('div[title|=test]')
$('div[title~=test]')
$('div[id][title~=value]')//复合属性选择器
```

- 子元素过滤选择器
```javascript
$('div:nth-child(4)')
$('div:nth-child(even)')
$('div:nth-child(odd)')
$('div:nth-child(3n)')
$('div:nth-child(3n-1)')
$('div:first-child')
$('div:last-child')
$('div:only-child')
//都是选取div元素下的子元素的
```

- 表单对象属性过滤选择器
```javascript
$('#form1:enabled')
//选取id为form1的表单内所有可用元素
$('#form1:disabled')
//选取id为form1的表单内所有不可用元素
$('input:checked')
//选取所有被选中的input元素
$('select option:selected')
//选取所有被选中的选项元素
```

- 表单选择器
```javascript
$(':input')
//选取所有的<input>、<textarea>、<select>和<button>元素
$(':text')
//选取所有的单行文本框
$(':password')
//选取所有的密码框
$(':radio')
//选取所有的单选框
$(':submit')
//选取所有的提交按钮
$(':image')
//选取所有的图像按钮
$(':reset')
//选取所有的重置按钮
$(':button')
//选取所有的按钮
$(':file')
//选取所有的上传域
$(':hidden')
//选取所有的不可见元素
```


我是一个刚刚闯进前端的小学生，如果上文中有什么错误的地方，还请您指正，不甚感激！