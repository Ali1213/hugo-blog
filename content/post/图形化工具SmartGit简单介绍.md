---
date = "2016-09-09T11:11:18+08:00"
title = "图形化工具SmartGit简单介绍"
categories = ["工具使用"]
tags = ["git"]
toc = true
author = "ali"
author_homepage =  "http://ali1213.github.io/post/"
---


## git图形化工具一览

| 软件名        | 支持系统           | 是否收费  |备注|
| ------------- |:-------------:| -----:|------:|
| [TortoiseGit][1]      | winxp+ | free |支持中文|
| [SmartGit][2]      | win7+,OS10.9-`10.11,linux    |free for non-commercial use    ||
| [SourceTree][3] | win7+,OS10.10+      |    free |支持中文|
| [Git GUI][4] | win7+,OS10.09+      |    free |||

下面介绍一下SmartGit的常用操作。
## window下的安装过程
安装的过程很简单，请一路向下即可，唯一需要注意的是打开的时候记得选择
for non-commercial use only 这种选项，因为该软件只对非商业用户免费。


<!-- more -->

### 界面简介
![此处输入图片的描述][5]

***


### git clone
![此处输入图片的描述][6]
点开Repository然后选择 clone
上述操作也可以直接用快捷键 Ctrl+shift + o;
![此处输入图片的描述][7]
![此处输入图片的描述][8]

至此，git clone操作结束，新添加的项目会出现在软件左侧的repository中，可以方便以后快速使用。

***

### 上传操作（git add . ,git commit -m "",git push origin 自己分支名）

![此处输入图片的描述][9]
![此处输入图片的描述][10]

***


### git pull

![此处输入图片的描述][11]

***

### 回退操作

1. 回退整个操作

首页面点击log 进入操作日志。
![此处输入图片的描述][12]

右键点击，选择Reset可以回归到这个版本。Reset有三种模式可以选择，mixed、soft、hard。

- mixed：工作区不变，reset暂存区、reset当前分支

- soft：工作区不变、暂存区不变、reset当前分支

- hard：reset工作区、reset暂存区、reset当前分支


![此处输入图片的描述][13]



2 . 回退单个文件
暂未找到

### push到其他分支

![此处输入图片的描述][14]

![此处输入图片的描述][15]





至此，篇幅有限，仅介绍一部分常用的操作，更细腻的操作，有待您去发现。


  [1]: https://tortoisegit.org/about/
  [2]: http://www.syntevo.com/smartgit/download
  [3]: https://www.sourcetreeapp.com/
  [4]: https://desktop.github.com/
  [5]: http://o92fjw7pr.bkt.clouddn.com/15.png
  [6]: http://o92fjw7pr.bkt.clouddn.com/7.png
  [7]: http://o92fjw7pr.bkt.clouddn.com/8.png
  [8]: http://o92fjw7pr.bkt.clouddn.com/9.png
  [9]: http://o92fjw7pr.bkt.clouddn.com/11.png
  [10]: http://o92fjw7pr.bkt.clouddn.com/12.png
  [11]: http://o92fjw7pr.bkt.clouddn.com/13.png
  [12]: http://o92fjw7pr.bkt.clouddn.com/21.png
  [13]: http://o92fjw7pr.bkt.clouddn.com/22.png
  [14]: http://o92fjw7pr.bkt.clouddn.com/23.png
  [15]: http://o92fjw7pr.bkt.clouddn.com/24.png
