+++
date = "2016-04-16T11:56:09+08:00"
title = "用git和hexo搭建博客遇到问题和解决办法"
categories = ["工具使用"]
tags = ["博客", "hexo"]
toc = true
author = "ali"
author_homepage =  "http://ali1213.github.io/post/"
+++

## 前言
昨天花了好几个小时，才把自己的第一个博客搭建起来。现在写下这篇简单记录一下自己遇到的坑，和一些常用操作，以便备忘。
<!-- more -->
## git的一些操作
因为之前已经熟悉git的操作。实际上用到的git常用命令基本不多。主要是创建SSH的公钥。
中间有一次因为主题的问题我清空了下浏览器的cookie，结果在用hexo generate --deploy提交的时候又出现了提交不了服务器。原来创建的ssh公钥这么脆弱。

后来发现是自己用的ss代理服务器的原因造成的。**2016/4/18修订**
    
`$ ssh-keygen -t rsa -C "ali.vip@gmail.com"           //ali.vip@gmail.com为邮箱地址`

连按三个空格，找到保存秘钥的文件夹将“id_rsa.pub”文件的公钥（我用的是sublime编辑器打开）复制所有，保存到web服务器

## hexo安装的问题
hexo官方网站是推荐在安装好git和npm后通过以下命令安装hexo

`$ npm install -g hexo-cli`

但在实际中，我尝试了很多次都无法安装。 应该是国外网络的原因。**2018/05/01修订**

所以解决的方法是换国内的npm源，下面介绍的是一种换npm源的方法。个人更推荐使用nrm 去切换源**2018/05/01修订**

1.通过config命令:
`npm config set registry http://registry.cnpmjs.org`
`npm info underscore` （如果上面配置正确这个命令会有字符串response）

2.命令行指定
`npm --registry http://registry.cnpmjs.org info underscore`

3.编辑 ~/.npmrc 加入下面内容
`registry = http://registry.cnpmjs.org`

我用的是方法1，然后再执行hexo官方的全局安装命令提交。

## hexo常用操作记录

### 安装命令

```
$ npm install hexo-cli -g  (如果报错，执行sudo npm install -g hexo-cli --unsafe-perm=true)
$ hexo init myblog
$ cd myblog
$ npm install
$ hexo server
```

在浏览器输入：http://127.0.0.1:4000 即可浏览本地生成的博客

### 将本地博客提交至服务器

`$ hexo clean//清理之前生成过的静态缓存文件，我一般不用这个`
`$ hexo generate//    generate命令是重新生成一遍静态文件的意思`
`$ hexo deploy //将生成的静态页面和文件推送到github服务器上`

注：

 1. 上述命令可以用`$ hexo g`代替`$ hexo generate`
 2. 可以用`$ hexo d`代替`$ hexo deploy`
 3. 熟练者可以1步直接操作`$ hexo g --d`