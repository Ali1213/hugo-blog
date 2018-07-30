+++
date = "2016-04-18T16:14:28+08:00"
title = "css选择器及选择器的优先级"
categories = ["读书笔记"]
tags = ["css"]
toc = true
author = "ali"
author_homepage =  "http://ali1213.github.io/post/"
+++


## 前言

自打我开了博客以来，这基本上就是我第一个考虑写的文章。
话说来长，去年10月28号左右，刚刚看完《Head First HTML与CSS(第2版》的我，感觉自己飘了，毕竟600多页啊，一定要找一份工作压压惊。就请假去了一家公司面试，去面试前，我反复跟公司人事强调，我说我只有两个月的学习，人事说，没事，你过来。（其实我只是学了1个多星期的c语言，然后确定了前端方向，每天工作之余学习3、4个小时的xhtml和css2）。
所以一过去就笔试，摊开卷子，十道题目，8道都是js相关，我摸着那剩下两道想着，一定要做出来一道，不然怎么能连滚带爬，连哭带啼的求着面试官收下我呢。
其中有一道就是考属性选择器的优先级的。

<!-- more -->

## 选择器的优先级

在优先级面有一个最顶级的存在，虽然基本不要用它，他就是`! important`
```css
.head{
	background:red !important;
	color:green;
}
```

1. 按照选择器类型分

| 选择器类型    | 权重          |
| ------------- |:-------------:|
| 行内样式      | 1000|
| ID选择器     | 100|
| 类选择器、属性选择器、伪类选择器|10  |
| 元素（类型）选择器、伪元素（类型）选择器|1|
|通用元素选择器、伪元素:not选择器 |0|

2. 按照来源分

行内样式>页面样式>外部样式>浏览器自定义样式

3. 计算优先级的流程

a.根据选择器的类型计算权重，根据权重大小，大的优先级高；
b.如权重相同，则根据选择器的来源比较；
c.如果前面都想同，则根据其在文中的先后顺序，后面的优先级高；

## 选择器

为了有一个顺序，从总体上我按照优先级从高到低排序着说;

### ID选择器

```css
#head{
	background:red;
}
```

### 类选择器

```css
.left{
	float:left;
}
```

### 属性选择器

1. 基础选择器`Element[attr]`

```css
p[data]{
	color:red;
}

<p data = "transform"></p>
```
指定了属性名为data的p元素。

2. 基础选择器`Element[attr = "value"]`

```css
p[data = "transform"]{
	color:red;
}

<p data = "transform"></p>
```
指定了属性名为data，且属性值为transform的p元素。

3. 基础选择器`Element[attr ~= "value"]`

```css
p[data ~= "transform"]{
	color:red;
}

<p data = "transform big"></p>
```
指定了属性名为data，并且属性值为空格隔开的多个词，其中一个词为指定属性值的p元素。

4. 基础选择器`Element[attr ^= "val"]`

```css
p[data ^= "trans"]{
	color:red;
}

<p data = "transform"></p>
```
这个让我想到了正则，正则中^如果不放在[]内则代表开头的意思，该选择器表示，指定属性名为data，且属性值的开头为trans的p元素

5. 基础选择器`Element[attr $= "lue"]`

```css
p[data $= "form"]{
	color:red;
}

<p data = "transform"></p>
```
这个$符号在正则中表示结尾的意思，同理，该段代码表示，指定属性名为data，且属性值是以form结尾的p元素。

6. 基础选择器`Element[attr *= "alu"]`

```css
p[data *= "for"]{
	color:red;
}

<p data = "transform"></p>
```
该段代码表示，指定属性名为data，且属性值包含for的p元素。

7. 基础选择器`Element[attr |= "value"]`

```css
p[data |= "transform"]{
	color:red;
}

<p data = "transform"></p>
<p data = "transform-big"></p>
```
该段代码表示，指定属性名为data，属性值为"transform"或者"transform-"开头的p元素；

<font color="red">注：上述7种选择器在IE7及IE7以上均支持</font>

### 伪类选择器

#### 结构性伪类选择器

1. `p:nth-child(n)`表示p如果是p父元素的第n个元素子节点，匹配成功；
<font color="red">
注：a.结构性伪类选择器中的n，此处的n可以是自然数，但与js从0开始计数不同的是，此处的n是从1开始计数；
	b.此处还可以写自然数与n的计算关系式，如2n（表示偶数），2n-1（表示奇数），3n等等；
	c.此处可以是add（表示奇数行）或even（表示偶数行）
</font>
2. `p:nth-last-child(n)`表示p如果是p父元素的倒数第n个元素子节点，匹配成功；
3. `p:nth-of-type(n)`表示p如果是p父元素的第n个p类型的元素子节点，匹配成功；
4. `p:nth-last-of-type(n)`倒数版本的`p:nth-of-type(n)`；
5. `p:first-child`等同于`p:nth-child(1)`
6. `p:last-child`等同于`p:nth-last-child(1)`
7. `p:first-of-type`等同于`p:nth-of-type(n)`
8. `p:last-of-type`等同于`p:nth-last-of-type(n)`
9. `p:only-child`表示p如果是其父元素下唯一一个子元素
10. `p:empty`表示p元素下（不再是p的父元素）不包含任何子元素，匹配成功。
11. `html:root`当元素作为文档的根元素时，匹配成功。其实这样的元素再html中只有一个，就是HTMLHtmlElement元素。查了下百度，该选择器可以用于IE中的hack；

<font color="red">
注：基本上所有的伪类选择器（包括下文的）基本上都是css3新增的，可以视为在IE8及IE8以下均不支持。
ps：不知道电脑端的IE8淘汰要多久~~~~
</font>

#### 其他伪类选择器

1. `E:link`当元素E（a标签）未被点击时，匹配成功。
2. `E:visited`当元素E（a标签）点击过时，匹配成功。
3. `E:hover`必须在E:link、E:visited后声明才有效。当元素E（IE5.5~7时为a标签，IE8+可为其他标签）正被鼠标悬停时，匹配成功。
4. `E:active`必须在E:hover后声明才有效。当鼠标已经在元素E（a标签）按下，但未释放左键时，匹配成功。
5. `E:focus`当元素E（元素E必须为可以接收键盘或用户输入的元素）获得焦点时，匹配成功。（IE8的标准模式开始支持）
6. `E:lang(c)`当元素的lang属性值等于c时，则匹配成功。
7. `E:enabled`元素E（E为表单元素）可用时，匹配成功。
8. `E:disabled`元素E（E为表单元素）不可用时，匹配成功。
9. `E:checked`元素E（E为input[type=radio]或input[type=checkbox]元素）被钩选时，匹配成功。

####伪元素选择器
1. `E:before`（新写法`E::before`）用于向元素E前添加内容（IE8的标准模式开始支持）
2. `E:after`（新写法`E::after`）用于向元素E后添加内容（IE8的标准模式开始支持
3. `E:first-line`（新写法`E::first-line`）仅仅当元素E为块级元素时有效。用于向元素E中的文字的首行添加特殊样式。
4. `E:first-letter`（新写法`E::first-letter`）用于向元素E的首个字母添加特殊样式
5. `E:input-placeholder`用于向元素E的placeholder添加特殊样式。由于未成为W3C规范，因此需要加浏览器厂商前缀

#### 通用元素选择器和伪类not选择器----"最弱的选择器"
1. 通用元素选择器
```css
*{
  margin:0;padding:0;
}
```
话说最开始写代码时最喜欢的。

2. 伪类not选择器
`E:not`当元素E不符合其他类型的选择器条件时，匹配成功。

#### 组合类选择器

1. 群组选择器
```css
div, body{
  width: 1200px;
}
```

2. 后代选择器
```css
body div{
  width: 1200px;
}
```

3. 子元素选择器
```css
body > div{
  color: #111;
}
```

4. 相邻兄弟元素选择器
```css
h1 + p {
	margin-top:50px;
}
```
这个选择器读作：“选择紧接在 h1 元素后出现的段落，h1 和 p 元素拥有共同的父元素”。


我还是一个前端的小学生，如果上述文章中有什么错误的话，还希望您能够指正！谢谢！