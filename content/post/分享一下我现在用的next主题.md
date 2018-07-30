+++
date = "2016-04-18T15:14:28+08:00"
title = "分享一下我现在用的next主题"
categories = ["工具"]
tags = ["博客", "hexo"]
toc = true
author = "ali"
author_homepage = "http://ali1213.github.io/post/"
+++

## 换主题所需要的资源
上一个主题在刚用了两天就不能满足我了。所以赶紧换上了现在的主题。比较喜欢这个主题的功能。
所需要的资源如下
 - [hexo的官网][1]，还没有配置hexo的可以参考上面的看看，虽然简陋了点，但是基础的命令上面都有
 - [next主题的官网][2]，这个就很强大了。各种命令都有，而且介绍很详细。
 - [next主题的git仓库][3]
<!-- more -->

## 注意事项
next官网上已经把所有的说的很详细。
个人分享三个自己觉得很细致的东西：

![](/img/分享一下我现在用的next主题/favorite.png)
如果需要像图中的小图标，需要将你的 favicon 放置到 站点 的 source 目录下，与站点的配置文件同级。 若你发现设置的 Favicon 并未生效，请先清除浏览器的缓存后直接访问 Favicon 的地址，这个地址通常是 http://your-domain.com/favicon.ico。

![](/img/分享一下我现在用的next主题/readAll.png)
之前我的文章在首页一直是全文展示，觉得体验效果很一般，觉得阅读全文这个效果挺好的，hexo官网上推荐了
`<!-- more -->`
将上面这条语句放于文章中，然后这条语句的下面部分不会在你的博客首页中展示出来。

![](/img/分享一下我现在用的next主题/AMdIdpW.png)
我现在使用的是官方的第三方集成中的由 panzhitian 贡献的不蒜子统计，统计文章的点击量以及访问量，但该插件不能像上图一样再博客首页实现展示阅读次数。[jeyzhang][7]提供了一个更好的方法。有兴趣的同学可以点击他的名字进入网页按照他的方法试一下。
对了，如果要在博客首页也正常显示文章中的图片。markdown的语法是不行的。需要使用
`{% asset_img AMdIdpW.png %}//AMdIdpW.png为图片的路径`

最后。感谢一下我刚刚使用的markdown的web在线编辑器https://www.zybuluo.com/


  [1]: https://hexo.io/
  [2]: http://theme-next.iissnan.com/
  [3]: https://github.com/iissnan/hexo-theme-next
  [7]: http://www.jeyzhang.com/hexo-next-add-post-views.html---

