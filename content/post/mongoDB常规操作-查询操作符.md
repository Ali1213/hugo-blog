+++
date = "2018-02-10T22:31:09+08:00"
title = "mongoDB常规操作-查询操作符"
categories = ["读书笔记"]
tags = ["mongo"]
toc = true
author = "ali"
author_homepage =  "http://ali1213.github.io/post/"
+++

## 前言

最近看Mongo权威指南的时候，偶然间查了下mongo的官方文档，发现其实增加了很多新的API，打算系统性的过一遍。

<!--more -->

## 比较操作符

### `$eq`
没啥用
因为
`db.collectionName.find({"field":{$eq:"value"}})`
等于
`db.collectionName.find({"field":"value"})`

### `$gt`
语法: `{field: {$gt: value} }`

### `$gte`
语法: `{field: {$gte: value} }`

### `$lt`
语法: `{field: {$lt: value} }`


### `$lte`
语法: `{field: {$lte: value} }`

### `$in`
语法: `{field: {$in: [ <value1>, <value2> ... <valueN> ]} }`
尽量少用$in，而是分解成一个一个的单一查询。尤其是在分片上，$in会让你的查询去每一个分片上查一次，如果实在要用的话，先在每个分片上建索引。

### `$ne`
语法: `{field: {$ne: value} }`
$ne查询会扫描整个collection, 即使是文档上面没有该field也会被扫描。性能会比较差

### `$nin`
语法: `{ field: { $nin: [ <value1>, <value2> ... <valueN> ]} }`
匹配两种文档
1. field字段中没有指定数组的值
2. 没有fileld字段的

查询会全表扫描。

## 逻辑查询符
逻辑操作符都是元操作符，意味着他们可以放在其他任何操作符之上

### `$and`
语法: `{ $and: [ { <expression1> }, { <expression2> } , ... , { <expressionN> } ] }`

第一个expression应筛去尽可能多的条件

### `$not`
语法: `{ field: { $not: { <operator-expression> } } }`
+ $not 在大部分操作符上行为始终一致，但是在一些数据类型（比如数组）可能会产生不同的结果
+ $not 操作符不支持 $regex操作符，但是可以使用//替代；
+ $not通常不知道如何使用索引
+ $not操作符与其他逻辑操作符语法有些不太一样

### `$or`
语法: `{ $or: [ { <expression1> }, { <expression2> }, ... , { <expressionN> } ] }`

+ 第一个expression1应匹配尽量多的结果
+ 使用$or查询，每个expression可以优先选用其自己的索引（而非符合索引）
+ 除非所有的expression都对应相应的索引，不然$or没有办法使用索引
+ 因为$text查询必须使用索引，所以当同时使用$or和$text的时候，必须所有的expression都有索引，不然会抛出错误
+ 如果有可能，尽量用$in代替$or

### `$nor`
语法: `{ $nor: [ { <expression1> }, { <expression2> }, ...  { <expressionN> } ] }`
+ 当使用$nor去查询时，不仅包括不符合这个表达式的，还包括不存在于这个表达式中field字段
+ 可以和$exists配合使用，例如: 

```javascript
db.inventory.find( { $nor: [ 
	{ price: 1.99 }, { price: { $exists: false } }, 
	{ sale: true }, { sale: { $exists: false } }
 ] } )
```

## 元素查询操作符


### `$exists`
语法: `{ field: { $exists: <boolean> } }`

当为true时，匹配包含该字段的文档，即使该字段的值为null
+ 据mongodb权威指南说，该操作符不会用到索引


### `$type`
语法: `{ field: { $type: <BSON type> } }`，`{ field: { $type: [ <BSON type1> , <BSON type2>, ... ] } }`

## 估算查询操作符

### `$expr`
语法: `{ $expr: { <expression> } }`
3.6版新增的语法，允许在查询中使用aggregation expression

+ 可以使用它比较一个文档中的不同field的值，例如：`db.monthlyBudget.find( { $expr: { $gt: [ "$spent" , "$budget" ] } } )`
+ 可以使用条件语句，例如

```javascript
db.supplies.find( {
    $expr: {
       $lt:[ {
          $cond: {
             if: { $gte: ["$qty", 100] },
             then: { $divide: ["$price", 2] },
             else: { $divide: ["$price", 4] }
           }
       },
       5 ] }
} )
```


### `$jsonSchema`
语法: `{ $jsonSchema: { <expression> } }`
3.6版本新增语法： 讲文档与给定的JSON Schema文档进行匹配
示例如下：
```javascript
db.createCollection("students", {
   validator: {
      $jsonSchema: {
         bsonType: "object",
         required: [ "name", "year", "major", "gpa" ],
         properties: {
            name: {
               bsonType: "string",
               description: "must be a string and is required"
            },
            gender: {
               bsonType: "string",
               description: "must be a string and is not required"
            },
            year: {
               bsonType: "int",
               minimum: 2017,
               maximum: 3017,
               exclusiveMaximum: false,
               description: "must be an integer in [ 2017, 3017 ] and is required"
            },
            major: {
               enum: [ "Math", "English", "Computer Science", "History", null ],
               description: "can only be one of the enum values and is required"
            },
            gpa: {
               bsonType: [ "double" ],
               description: "must be a double and is required"
            }
         }
      }
   }
})
```

### `$mod`
语法: `{ field: { $mod: [ divisor, remainder ] } }`

+ 返回`字段值%divisor === remainder`的文档
+ 如果数组内元素不等于两个会报错


### `$regex`
语法: `{ field: { $mod: [ divisor, remainder ] } }`
可以使用以下的形式
```javascript
{ <field>: { $regex: /pattern/, $options: '<options>' } }
{ <field>: { $regex: 'pattern', $options: '<options>' } }
{ <field>: { $regex: /pattern/<options> } }
```


### `$text`
语法: 
```javascript
{
  $text:
    {
      $search: <string>,
      $language: <string>,
      $caseSensitive: <boolean>,
      $diacriticSensitive: <boolean>
    }
}
```

$text 只在有text索引的field上进行搜索



### `$where`
语法: ``
+ 在3.6版本中增加了$expr，与$where相比，不需要执行javascript，所以会快很多，优先使用$expr
+ $where只能用于最顶层的文档查询，不能用于内线文档或者数组的查询
+ $where无法使用索引

示例：
```javascript
db.foo.find( { $where: function() {
   return (hex_md5(this.name) == "9b53e667f30cd329dca1ec9e6a83e994")
} } );
```

## 地理空间查询操作符

暂时略过

## 数组查询操作符


### `$all`
语法: `{ <field>: { $all: [ <value1> , <value2> ... ] } }`

$all查询用于全部value的指定文档

## `$elemMatch`
语法: `{ <field>: { $elemMatch: { <query1>, <query2>, ... } } }`

使用多个表达式去匹配数组的每一项，返回匹配成功的文档


## `$size`
语法: `{ <field>: { $size: length} }`

匹配数组的长度，只能是固定值，不能是范围


## 位查询操作符

暂时略过

## Projection操作符

### `$`

语法：
```javascript
db.collection.find( { <array>: <value> ... },
                    { "<array>.$": 1 } )
db.collection.find( { <array.field>: <value> ...},
                    { "<array>.$": 1 } )
```
返回的文档中的数组只会保留匹配到的数组的那一项


### `$elemMatch`

示例：

```javascript
db.schools.find( { zipcode: "63109" },
                 { students: { $elemMatch: { school: 102, age: { $gt: 10} } } } )
```

返回的文档中会去掉不匹配的数组项，但是数组中匹配的项以及文档的其他项还是会如期的返回



### `$meta`

暂时略过

### `$slice`

示例：

```javascript
db.collection.find( { field: value }, { array: {$slice: count } } );
```

返回的数组中含有多少项
如果是正数，表示返回的数组的前几个元素
如果是负数，表示返回数组的最后几个元素




 