+++
date = "2017-03-15T20:22:12+08:00"
title = "块级作用域-《understanding ECMAScipt6》读书笔记1"
categories = ["读书笔记"]
tags = ["javscript","ES6","understanding ECMAScipt6"]
toc = true
author = "ali"
author_homepage =  "http://ali1213.github.io/post/"
+++


## 针对的问题
+ 变量提升 令人困惑
+ 改变window对象或global对象的属性

<!--more-->

## 块级作用域的特点

1. 作用范围在`{}`内或者函数体内
2. 不允许重复声明
3. 无变量提升

## let声明
`let`跟`var`比主要有以下三个特点：
+ 无变量提升
+ 只在块级作用域内有效
+ 不允许重复声明

## const声明
`const`声明与`let`声明类似，但`const`声明指向固定的内存指针。
+ 初始化时必须赋值
+ 一旦声明，不可改变指针指向

## 带来的困惑 TDZ
TDZ ：暂时性死区
在块级作用域内，`let`和`const`声明前，任何对变量名的操作都会抛出异常，即使是`typeof`

## 应用场景
+ for循环中取代`var`
+ 取代IIFE函数


文笔简陋，如有错误，还请指正！谢谢！

