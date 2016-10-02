+++
Description = ""
tags = ["bigdata", "hbase"]
date = "2016-08-08T22:06:23+08:00"
menu = "main"
title = "HBase Store 01"

+++


### HBase  Store 学习-01 

  1. B+树 与 LSM 树
  
  	B+树被广泛的应用于典型的关系型存储,B+树可以通过主键对记录进行高速的插入、查找以及删除。B+树可以通过叶节点相互连接并且按主键有序排列,从而扫描时避免了耗时的遍历树操作,但是两个页表在硬盘中不一定时彼此相邻。<!--more-->
  	
  	LSM树(log-structured merge-tree) 则按照另外一种方式组织数据。输入数据首先被存储在日志文件，这些文件内的数据完全有序。当有日志文件被修改时，对应的跟心会保存在内存中加速查询。
  	
  	当系统经历多次修改，且内存空间逐渐占满后,LSM树会把有序的"Key-Value"键值对写入到磁盘中，因为最近的修改都被持久化了，内存中保存的最新更新就可以被丢弃了。
  	
  	LSM树将删除视为一种特殊的更改，会对数据进行删除标记，查询的时候会跳过这些删除过的键，当页被重写时，有删除标记的键会被丢弃。
  	
  	
  	B+树 利用了存储随机查找能力， LSM树利用了存储联系传输的能力。
  	
 2. HBase 存储架构

    HBase与Bigtable 一样采用了LSM树。
 
 ![启动图片](/img/Hbase-Store.png) 
 
 HBase 主要处理2种文件,一种时预写日志(Write-Ahead Log ,WAL)HLog,一种时实际的数据文件HFile, 这2种文件主要由HRegionServer管理。
 

 3.HBase Data Flow
 
 3.1 查询流程
   一个基本查询流程, 客户端联系ZK子集群(quorum,一个由zk节点组成的单独集群)查找行键, 通过zk获取含有-ROOT-的region服务器名(主机名)完成，通过含有-ROOT-的region服务器查询还有.META.表中对应的region服务器名,包括请求的行键信息。通过查询.META.服务器来获取客户端查询的行键数据所在的region服务器名字,HBase会缓存这次查询信息，同时直接管理管理实际数据的HRegionServer。
   
   (待续...)