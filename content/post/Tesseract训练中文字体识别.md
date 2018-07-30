+++
date = "2017-02-14T19:53:47+08:00"
title = "Tesseract训练中文字体识别"
categories = ["工具"]
tags = ["Tesseract"]
toc = true
author = "ali"
author_homepage =  "http://ali1213.github.io/post/"
+++


注：目前仅说明windows下的情况

# 前言
网上已经有大量的tesseract的识别教程，但是主要有两个缺点：
+ 大多数比较老，有部分内容已经不适用。
+ 大部分只是就英文的训练进行探索，很少针对中文的训练。
接下来尽可能详细的介绍自己tesseract训练中文识别的经验。

本文中使用的tesseract版本为3.05;
为什么用3.05呢？
从官方文档上看4.0版本（windows版本于2017年1月30号发布）显著的提高了识别率，同时也加大了性能的消耗。理论上我是应该用4.0。但这不是重点。重点是有windows的版本有诡异的bug! 花了好久没有解决。
不过还好，4.0支持3.05版本的所有语法。换而言之，下面的所有内容在4.0都是可以用的。
<!--more-->
# 工具准备
+ 下载 [java](https://www.java.com/zh_CN/download/)(java大法好啊);
+ 下载[jTessBoxEditor](http://sourceforge.net/projects/vietocr/files/jTessBoxEditor/)(依赖于java)
+ 下载[tesseract](https://github.com/tesseract-ocr/tesseract)， [windows64点这里](http://digi.bib.uni-mannheim.de/tesseract/)

# 安装过程

![点击下一步](http://upload-images.jianshu.io/upload_images/2453666-ea9dae9beb888efc.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![勾选上同意，然后点击下一步](http://upload-images.jianshu.io/upload_images/2453666-b5a791071f97b1ec.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![点击下一步](http://upload-images.jianshu.io/upload_images/2453666-fcfbf56b5d8d7490.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![既然是要训练中文，记得勾选 additional language data](http://upload-images.jianshu.io/upload_images/2453666-79dc22f93059bb2e.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


![找到中文简体和中文繁体，按需勾选，然后点下一步](http://upload-images.jianshu.io/upload_images/2453666-f0089942b8d35128.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

可以先不勾选，因为这样直接下载语言的包实在太慢。可以从网页上直接下载[语言包](https://github.com/tesseract-ocr/tesseract/wiki/Data-Files),然后等程序安装好后，放入安装目录下tessdata目录下面

![目录。。毕竟是你的电脑，随便选，你开心就好，然后点下一步](http://upload-images.jianshu.io/upload_images/2453666-9aa34e08a4d05740.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


![点击install](http://upload-images.jianshu.io/upload_images/2453666-d2b078fe59d720ab.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

安装完毕。

# 字体训练
我准备了一份含汉语7000字和大小写英文字母和数字的[文档](http://o92fjw7pr.bkt.clouddn.com/%E6%89%80%E6%9C%89%E5%AD%97%E4%BD%93.docx).如果你需要训练所有中文的话，请将所有docx文件内所有字改成你要训练的字体。然后转化成tif格式的图片。

## 步骤（转自tesseract的github）
1. Prepare training text.
准备你的训练文本
2. Render text to image + box file. (Or create hand-made box files for existing image data.)
将文本转为image+box文件.(如果你已经有image文件的话，只需要手动生成box文件)
3. Make unicharset file.
生成unicharset文件
4. Optionally make dictionary data.
有选择性的生成字典数据
5. Run tesseract to process image + box file to make training data set.
运行tesseract来处理之前的image+box文件生成一个训练数据集合
6. Run training on training data set.
在训练数据集合的基础上进行训练
7. Combine data files.
合并数据文件

下面所列的步骤其实稍有不同。

## 如果有多张图片[可选]
如果是其他图片格式，将其转为tif格式。附上一个[在线地址](http://cn.office-converter.com/Convert-to-TIF)

使用之前安装jTessBoxEditor工具将多张图片合并为一张（菜单栏 Tools → Merge TIFF）。并按照格式 **[lang].[fontname].exp[num]** 重命名合并后的文件，这里我命名为 **chi.fangzheng.exp0.tif**。

为了方便下文中输入路径，在本文中将改好的tif图拷贝至tesseract安装之后的目录下。

## 步骤二:生成box文件
贴一张官网命令:
![官方命令](http://upload-images.jianshu.io/upload_images/2453666-9cac91a7536861b7.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
输入路径和输出路径文件名（除了后缀）应该保持一致。
因为我们是要训练中文所以还需要加上-l chi_sim（l代表language chi_sim是放在tessdata目录下中文简体字体名的前缀），实际命令如下所示
```
tesseract.exe chi.fangzheng.exp0.tif chi.fangzheng.exp0 -l chi_sim batch.nochop makebox
```
## 步骤二:校正box文件
打开之前安装的jTessBoxEditor，

![点击open，然后找到tif图片文件](http://upload-images.jianshu.io/upload_images/2453666-e3893d651d73bbde.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![通过这部分区域的按钮对识别结果进行校正](http://upload-images.jianshu.io/upload_images/2453666-e710481fa658ae2a.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

校正完之后点击保存

## 步骤三:生成unicharset文件

### 生成tr文件

使用刚才修改正确后的 box 文件，对 Tesseract 进行训练，生成 .tr 文件：
```
//tesseract.exe [tif图片文件名] [生成的tr文件名] nobatch box.train
tesseract.exe chi.fangzheng.exp0.tif chi.fangzheng.exp0  nobatch box.train
```

### 生成Character集合
```
//unicharset_extractor.exe [box文件名]
unicharset_extractor.exe chi.fangzheng.exp0.box
```

如果有多个图片的话，则需要合并生成1个Character集合,命令如下
```
//unicharset_extractor.exe [1个box文件名] [1个box文件名] .....
unicharset_extractor.exe chi.fangzheng.exp0.box chi.fangzheng.exp1.box
```

### 创建字体特征文件
定义字体特征文件，Tesseract-OCR 3.01 以上的版本在训练之前需要创建一个名称为 font_properties 的字体特征文件。font_properties 不含有 BOM 头，文件内容格式如下：
```
<fontname> <italic> <bold> <fixed> <serif> <fraktur>
//其中 fontname 为字体名称，必须与 [lang].[fontname].exp[num].box 中的名称保持一致。<italic> 、<bold> 、<fixed> 、<serif>、<fraktur> 的取值为 1 或 0，表示字体是否具有这些属性。
```

```
//本次示例
fangzheng 0 0 0 0 0
```

## 步骤五:生成字典数据

如果是单个依次输入下面两条命令,多个文件则输入多个tr
```
mftraining.exe -F font_properties -U unicharset -O chi.unicharset chi.fangzheng.exp0.tr
//mftraining.exe -F font_properties -U unicharset -O chi.unicharset  [第一个tr] [第二个]...

cntraining.exe chi.fangzheng.exp0.tr
//cntraining.exe [第一个tr] [第二个]...
```

接下来手工修改 Clustering 过程生成的 4 个文件（inttemp、pffmtable、normproto、shapetable）的名称为 [lang].xxx。例如我这里改为 chi.inttemp、chi.pffmtable、chi.normproto、chi.shapetable。

## 步骤七:合并数据文件

生成语言文件：
```
combine_tessdata chi.
```

![](http://upload-images.jianshu.io/upload_images/2453666-9d21685e4b49f914.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

需确认打印结果中的 Offset 1、3、4、5、13 这些项不是 -1。这样，一个新的语言文件就生成了。

chi.traineddata 便是最终生成的语言文件，将生成的 chi.traineddata 文件拷贝到 tessdata 目录下，就可以用它来进行字符识别了。

我们可以用刚刚的tif文件来测试一下识别能力:
```
//tesseract [图片文件名] [需要输出的文本文档的文件名] -l [识别的语言]
tesseract chi.fangzheng.exp0.tif out -l chi
```

我只是一个 div工程师，api使用者，字符串拼接员，cp。
文笔简陋，如有错误，还请指正！谢谢！

