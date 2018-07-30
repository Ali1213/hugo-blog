+++
date = "2016-09-21T15:07:52+08:00"
title = "正则表达式字面量一个bug"
categories = ["代码"]
tags = ["javscript","正则"]
toc = true
author = "ali"
author_homepage =  "http://ali1213.github.io/post/"
+++

### 引言
事情起源于乙方数据库接口都是"nick_name"这种带下划线的格式:
```json
{
    message:"",
    nick_name:"",
    data:{
        contact_tel:""
    }
}
```
我需要写一个小程序将驼峰格式转化为这种格式。下面是我最初写的代码：

<!-- more -->

```javascript
var toCamel = function toCamel(json) {

    var re = /(_\w)/g;
    var rename = "";
    var arr = [];
    var i = 0;

    for (var attr in json) {
        arr[i] = attr;
        i++;
    };

    for (i = 0; i < arr.length; i++) {
        var attr = arr[i];
        if (arr[i].match(re)) {
            if (typeof json[attr] === "object") {
                json[attr] = toCamel(json[attr]);
            };
            rename = attr.replace(re, function($0) {
                return $0.substring(1).toUpperCase();
            });
            json[rename] = json[attr];
            delete json[attr];
        }

    };

    return json;
};
```
当然这个程序出了问题，其实是个简单的逻辑问题，不过最开始当局者迷，去查了下正则表达式的bug，发现正则表达式有这么一个bug：
首先，简单介绍下：
```javascript
var re = /(_\w)/g;  //这个是正则表达式字面量
var re = new RegExp("(_\w)","i");   //这个是RegExp构造函数创建的
```
然后，
在ECMAScript3中，正则表达式字面量会共享一个RegExp实例，举个例子
```javascript
var re = null;
var i = 0;
for(var i = 0; i < 4; i++){
    re = /cat/g;
	console.log(re.test("catastrophe") + "111")
}
//
for(var i = 0; i < 4; i++){
    re = new RegExp("cat","g");
	console.log(re.test("catastrophe")+ "222")
}
//
```
在第一个循环中，虽然是循环体指定的，但实际上只为/cat/创建了一个RegExp实例，由于实例属性不会重置，所以在循环内再次调用test()方法会失败。这是因为第一次调用test()找到了"cat",第二次调用会从索引为3的字符（上一次匹配的末尾）开始的，所以就再也找不到他了。
在第二个循环体中，每次会创建一个新的RegExp实例，所以每次调用test()都会返回true。
幸运的是，ECMAScript5 明确规定，使用正则表达式字面量必须像直接调用RegExp构造函数一样，每次都创建新的RegExp实例，IE9+，Firfox 4+ 和Chrome都据此做了修改。
···········
等等，上面的话似乎很熟悉，你可以翻开JavaScript高级程序设计（第三版）P105.
然而，我不是会光抄书的好吗。。。
```javascript
true111
true111
true111
true111
true222
true222
true222
true222
```
以上是IE6，IE7，IE8的上面一段示例的console.log。
其实我的心内是崩溃的，

because..
FireFox3.6遵循了ECMAScript3标准，所以结果与书中一致，而最新的Firefox4、Chrome和Safari5都遵循ECMAScript5标准，至于IE6-IE8都没有很好的遵循ECMAScript3标准，不过在这个问题上反而处理对了。
所以说IE系列，Firfox 4+ 和Chrome在这个地方都没有问题。

所以我以上说的都是废话。
![此处输入图片的描述][2]


那么，回到最开始的代码，改正逻辑的错误后，我们还有什么改进的空间呢？
函数arguments对象有一个特殊的属性叫做callee，该属性是一个指针，指向拥有这个arguments对象的函数。通过这个我们可以解除函数与函数名之间的耦合关系。避免可能的问题。所以最后，上述函数改进如下：
```javascript
var toCamel = function (json) {

    var re = /(_\w)/g;
    var rename = "";
    var arr = [];
    var i = 0;

    for (var attr in json) {
        arr[i] = attr;
        i++;
    };

    for (i = 0; i < arr.length; i++) {
        var attr = arr[i];
        if (typeof json[attr] === "object") {
            json[attr] = arguments.callee(json[attr]);
        };

        if (arr[i].match(re)) {
            rename = attr.replace(re, function($0) {
                return $0.substring(1).toUpperCase();
            });
            json[rename] = json[attr];
            delete json[attr];
        }

    };

    return json;
};
```
2016年9月21日补充：
在ES5 严格模式下arguments.callee是不允许访问的。
所以建议上述代码该为如下所述：
给函数外套一层（）可以防止一些可能的bug。

```javascript
var toCamel = （function toCamel(json) {

    var re = /(_\w)/g;
    var rename = "";
    var arr = [];
    var i = 0;

    for (var attr in json) {
        arr[i] = attr;
        i++;
    };

    for (i = 0; i < arr.length; i++) {
        var attr = arr[i];
        if (typeof json[attr] === "object") {
            json[attr] = toCamel(json[attr]);
        };

        if (arr[i].match(re)) {
            rename = attr.replace(re, function($0) {
                return $0.substring(1).toUpperCase();
            });
            json[rename] = json[attr];
            delete json[attr];
        }

    };

    return json;
}）
```


目前想到的就这么多了，有什么问题，欢迎指教。


  [2]: http://wanzao2.b0.upaiyun.com/system/pictures/29708560/original/1445037488_650x434.png

我是一个刚刚闯进前端的小学生，如果上文中有什么错误的地方，还请您指正，不甚感激！