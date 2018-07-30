+++
date = "2016-11-29T20:46:55+08:00"
title = "小技巧-console界面使用jQuery"
categories = ["代码"]
tags = ["jquery","技巧","javascript"]
toc = true
author = "ali"
author_homepage =  "http://ali1213.github.io/post/"
+++

## 前言

作为一个前端工程师，偶尔还是会经常在google浏览器的console写写代码，记得第一次在console写代码，真是觉得超酷！
最开始在控制台，我就很自然的用到jQuery。
直到有一天，我输入`$("")`，浏览器给我报了个错！
what the fuck！！！

<!--more-->

后来我才知道，能用是因为打开的网站本身就引入了jQuery。但有一些网站没有引入jQuery，怎么办呢？
如果你只是想应急使用的情况下，照超下面的代码即可

```javascript
var s = document.createElement("script");
s.src = "http://cdn.bootcss.com/jquery/2.2.0/jquery.js";
document.body.append(s);
```

原理也很简单。
1.找一个jquery 的cdn，列入[bootcdn.cn][1]。找到你需要的版本的jQuery，替换上文中的src；
2.用上面的代码插入到document.body中；

然后就又可以愉快的使用jQuery了。


感谢bootstrap中文网提供的CDN：[jquery][1]



  [1]: http://www.bootcdn.cn/jquery/