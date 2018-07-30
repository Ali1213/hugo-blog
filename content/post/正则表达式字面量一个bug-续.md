+++
date = "2016-10-21T14:29:43+08:00"
title = "正则表达式字面量一个bug(续)"
categories = ["代码"]
tags = ["javscript","正则"]
toc = true
author = "ali"
author_homepage =  "http://ali1213.github.io/post/"
+++


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
<!--more -->
上面的代码应该是我7月初写的，果然后来给我挖了一个坑。
大概9月份的时候我修复了这个bug；

其实想来正确的写法从来都不是在原json对象上直接修改数据，这样很容易造成新的问题，而应该是新建一个对象。

反正建对象不要钱！！！
反正建对象不要钱！！！

下面是更正后的代码：
```javascript
var toCamel = function toUndeline(json) {
        var re = /(_\w)/g;
        var rename = "";
        var arr = [];
        var i = 0;
        var copyJson = {}


        Object.keys(json).forEach(function(item) {
                if (item.match(re)) {
                        rename = item.replace(re, function($0) {
                                return $0.substring(1).toUpperCase();
                        });
                } else {
                        rename = item;
                }
                if (typeof json[item] === "object") {
                        copyJson[rename] = toCamel(json[item]);
                } else {
                        copyJson[rename] = json[item];
                }

        });

        return copyJson;
};
```

如果上文中有什么错误的地方，还请您指正，不甚感激！



