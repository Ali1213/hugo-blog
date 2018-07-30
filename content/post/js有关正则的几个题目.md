+++
date = "2016-04-20T14:14:47+08:00"
title = "js有关正则的几个题目"
categories = ["代码"]
tags = ["正则","javascript"]
toc = true
author = "ali"
author_homepage =  "http://ali1213.github.io/post/"
+++

## 题目1  写一个字符串转成驼峰的方法
如："border-bottom-color"->"borderBottomColor"

```javascipt
str = 'border-bottom-color';

//用原生方法实现
function toCamelCase(str){
	var arr = [];
	arr = str.split('-');
	for(var i=1;i<arr.length;i++){
		arr[i] = arr[i].charAt(0).toUpperCase()+arr[i].substring(1);
	}
	return arr.join('');

}

alert(toCamelCase(str));
```
<!-- more -->
```javascipt
str = 'border-bottom-color';

//正则实现
function toCamelCase(str){

	var re = /(-\w)/g

	str = str.replace(re,function($0){
		return $0.substring(1).toUpperCase();
	})
	return str;

}

alert(toCamelCase(str));
```
由于之前没有看到过replace中还有函数的参数写法，就去网上查了下资料,不得不说，正则的replace还是挺强大的。

## 题目2 查找字符串出现最多的字符和个数
如"sdfafdfafafadfeseoiw" ->

```javascipt
str = 'sdfafdfafafadfeaseoiw';

//用原生方法实现
function toFindMost(str){
	var most ={};
	var num = 0;
	var x = '';
	for(var i=0;i<str.length;i++){
		var alpha = str.charAt(i);
		if (!most[alpha]) {
			most[alpha] = 1;
		}else{
			most[alpha] = most[alpha]+1;
		}
	}
	for(var attr in most){
		if (most[attr]>num) {
			x=attr;
			num = most[attr];
		}
	}
	alert('出现最多的是：'+x+'总过出现了:' + num + '次');
}
toFindMost(str);
```
随便写了下，刚刚发现了一个小bug，如果最多的两个是一样的，只会显示先出现的。
```javascipt
str = 'sdfafdfafafadfeaseoiw';

//用正则方法实现
function toFindMost(str){
	var arr = str.split('');
	var str2 = arr.sort().join('');
	var re = /(\w)\1+/g;

	var num = 0;
	var x = '';

	str2.replace(re,function($0,$1){
		if (num<$0.length) {
			num = $0.length;
			x = $1;
		}
	})

	alert('出现最多的是：'+x+'总过出现了:' + num + '次');
}
toFindMost(str);
```

## 题目3 如何给数字加上千分符。
```javascipt
str = '22324345545244';
//用原生方法实现
function addCommas(str){
	var arr =[];
	var more = str.length%3;
	var moreStr = '';
	if (more) {
		moreStr = str.substring(0,more);
		str = str.substring(more);
	}
	
	for(var i=1;i<=str.length;i++){
		if (i%3==0) {
			arr.push(str.substring(i-3,i));
		}
	}
	
	return moreStr +','+arr.join(',');

}
alert(addCommas(str));
```
```javascipt
//用正则的方法实现
str = '22324345545244';
function addCommas(str){
	var re = /(?=(?!\b)(\d{3})+$)/g;
	return str.replace(re,',');

}
alert(addCommas(str));
```

## 题目4 返回一个只包含数字类型的一个数组；
如：'js123ldka78sdasejl654' ->[123,78,654]

```javascipt
str = 'js123ldka78sdasejl654';

//正则

function findNum(str){
	var re = /\d+/g;
	var arr = [];
	arr.push(str.match(re));
	return arr;
}

alert(findNum(str));
```
```
str = 'js123ldka78sdasejl654';

//原生方法

function findNum(str){
	var arr = [];
	for(var i=0;i<str.length;i++){
		if (Number(str.charAt(i))) {
			for(var j=0;j<str.length-i;j++){
				if (!Number(str.charAt(i+j+1)) || j==str.length-i-1) {
					arr.push(str.substring(i,i+j+1));
					break;
				}
			}
			i=i+j;
		}
	}
	return arr;
}

alert(findNum(str));
```

## 题目5 讲一个长度不超过5位的正整数转换成对应的中文字符串
num = 20876->'两万零八百七十六'
```javascipt
var num = 20876;

function numToChinese(num){
var numC = ['零','一','二','三','四','五','六','七','八','九'];
var unit = ['','十','百','千','万'];

var str = num + '';
var arr =[]
for(var i=0;i<str.length;i++){

	arr.push( numC[Number(str.charAt(i)) ] );

}
for(var i=0;i<arr.length;i++){
	if (arr[i]==arr[i+1]||arr[i]==0) {
		arr[i]='';
	}
}
arr = arr.reverse();
for(var i=0;i<arr.length;i++){
	if (arr[i]!='' && arr[i]!='零') {
		arr[i]=arr[i]+unit[i];
	}
}
return arr.reverse().join('') 
}

alert(numToChinese(num));
```

好吧，今天就先写这么多，感觉正则还是要多练习一下。

我是一个刚刚闯进前端的小学生，如果上文中有什么错误的地方，还请您指正，不甚感激！