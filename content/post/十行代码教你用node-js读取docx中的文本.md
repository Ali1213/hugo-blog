+++
date = "2016-12-16T19:30:15+08:00"
title = "十行代码教你用node.js读取docx中的文本"
categories = ["代码"]
tags = ["javascript","技巧"]
toc = true
author = "ali"
author_homepage =  "http://ali1213.github.io/post/"
+++



## 前言

最近有一个case。需要去解析word文档。有两个需求，一个是将word文档转成PDF，一个是将word文档中的内容按照一定的规范读取到数据库中，去npm仓库找了大概有十几个包，发现主要是通过以下的方式来转换代码。
+ 通过调用系统底层程序（比如说office）的API来转换；
+ 通过模板，替换数据来实现生成PDF；
+ 通过有些免费将word转成PDF的网站来实现将word转成PDF，比如docx-to-pdf；

后来退而求其次，想通过先将docx转成文字，发现了个textract的包。
当然也有缺点，不支持docx中的标题号，不支持图片等文件。

不怕死的我决定自己干这件事情。

<!--more-->

## 介绍

其实docx就是一个zip包，然后封装了一些xml文件。可以直接将docx的包改后缀为.zip来打开观看。

![Paste_Image.png](http://upload-images.jianshu.io/upload_images/2453666-4438d3b5000f5ad5.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

进入word文件夹


![Paste_Image.png](http://upload-images.jianshu.io/upload_images/2453666-d745d775c5be30c4.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

里面有几个主要的文件。
document.xml 这个就是文档的主要内容
numbering.xml 这个就是标题号，以及标题号的一些属性
styles.xml 这个就是样式列表

打开document.xml 你就会发现，所有的文本都是用 <w:t>标签包着的。这个就是本文的关键

## 代码

+   首先，需要通过npm安装一个能查看zip文件的包：adm-zip；
+   然后，写下下列代码即可
```javascript
  const fs = require("fs");
  const AdmZip = require('adm-zip'); //引入查看zip文件的包
  const zip = new AdmZip(filePath); //filePath为文件路径
  let contentXml = zip.readAsText("word/document.xml");//将document.xml读取为text内容；
  let str = "";
  contentXml .match(/<w:t>[\s\S]*?<\/w:t>/ig).forEach((item)=>{
  str += item.slice(5,-6)});
  fs.writeFile("./2.txt",str,(err)=>{//将./2.txt替换为你要输出的文件路径
    if(err)throw err;
  });
```

最近正在用node.js去解析docx的工作。先将最简单的写在上面。回头有空再继续分享

2月13日更新
之前随手写的代码，今天测试发现用更新后的代码比源代码的效率提升十倍以上。
```javascript
//原代码
//str += item.replace("<w:t>","").replace("</w:t>","");
//更新代码
str += item.slice(5,-6)
```

附上测试代码
```javascript
var str = "<w:t>sdfjpasif aefnmasd;lf asdfsdf</w:t>";
var arr = [];
for(var i=0;i<50000;i++){
    arr.push(str);
}
console.time("replactest");
arr.forEach((item)=>{
    item.replace(/<w:t>/,"").replace(/<\/w:t>/,"");
});
console.timeEnd("replactest");
//replactest: 20.560ms

console.time("replactest2");
arr.forEach((item)=>{
    item.replace(/<\/*w:t>/g,"");
});
console.timeEnd("replactest2");
//replactest2: 14.926ms

console.time("replactest3");
arr.forEach((item)=>{
    item.replace(/(^<w:t>)|(<\/w:t>$)/g,"");
});
console.timeEnd("replactest3");
//replactest3: 14.402ms

console.time("slice");
arr.forEach((item)=>{
    item.slice(5,-6);
});
console.timeEnd("slice");
//slice: 1.718ms
```

最近正在用node.js去解析docx的工作。先将最简单的写在上面。回头有空再继续分享