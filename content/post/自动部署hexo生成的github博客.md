---
title: 自动部署hexo生成的github博客
tags:
  - 2017年
categories:
  - 技巧
  - shell
date: 2017-09-07 16:25:15
---

## 前言

不想用第三方的travis-ci实现自动部署博客，但是gitbub提供的钩子折腾了下，遇到了个坑。
休息的时候突然想了想，这个钩子其实就是在git push（或者其他操作）的时候触发自定义的命令而已。
其实我每写一篇文件发布，还需要运行hexo插件的一些操作。
为什么我不用shell做这些事情呢？

<!--more-->

## 流程：

+ 准备同时备份两个文件夹，一个是博客的静态资源，一个是hexo博客生成库，两个均备份到github仓库
+ 配置好两个git文件夹都使用免密码使用git
+ 将下面的脚本放于hexo博客生成库的文件夹下面（修改BLOG路径为自己的路径），参考文件名为`auto.sh`
+ 用git bash 执行`auto.sh`

## 思路

+ 删除$BLOG静态资源（有洁癖的我）
+ 用hexo生成静态资源
+ 将hexo博客生成库推送到github仓库
+ 将public/文件夹（静态资源）移动到$BLOG文件夹内
+ 将$BLOG文件夹推送到github仓库



```shell
#!/bin/bash
#By Ali 2017

#你博客静态文件所在文件夹
BLOG="../Ali1213.github.io";


rm -rf $BLOG/*;

hexo generate;

git add .;

git commit -a -m "auto commit by ali at `date +%Y%m%d`";

git push origin master;

mv -f public/* $BLOG;

cd  $BLOG;

git add .;

git commit -a -m "auto commit by ali at `date +%Y%m%d`";

git push origin master;
```

**2018年7月30日更新**
因为博客的生成器从hexo换成了hugo，所以重写了一下，思路是一样的

```shell
#!/bin/bash

BLOG="../Ali1213.github.io";

rm -rf $BLOG/*;

hugo;

git add . ;

git commit -a -m "auto commit by ali at `date +%Y%m%d`";

git push origin master;

mv -f public/* $BLOG;

cd  $BLOG;

git add .;

git commit -a -m "auto commit by ali at `date +%Y%m%d`";

git push origin master;
```