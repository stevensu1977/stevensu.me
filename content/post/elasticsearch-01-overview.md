+++
Description = ""
tags = ["nosql", "bigdata","document"]
date = "2016-05-12T22:53:00+08:00"
title = "Elasticsearch - 01 Overview "

+++

#### Elasticsearch  第一篇 概要介绍

   &nbsp; &nbsp;&nbsp; &nbsp;最近因为工作原因, 对几种文档型数据进行了调研,本笔记记录了以上几种数据库概要介绍,<!--more-->以及简单使用教程。
  
1.初识 Elasticsearch

   [Elasticsearch](https://en.wikipedia.org/wiki/Elasticsearch) 是基于Lucene 的Java开源全文检索引擎(文档数据库), 与Logstash,Kibana一起提供了整套的日志/数据分析技术栈(ELK),现在主要贡献者为Elastic公司。
 
  
  Elasticsearch 主要竞争对手有Solr, Splunk , 以及文档数据库Mongo, CouchDB, Riak, 主要接口为REST API。
  
  当前版本为 2.3.2 [下载](https://www.elastic.co/downloads/elasticsearch)
  
  ```
  #将zip或者tar 解压, 直接执行 bin/elasticsearch 即可
  
  bin/elasticsearch
  
  ```
  
  ![启动图片](/img/elasticsearch-start.png)
   
   恭喜,你的Elasticsearch 节点已经正常启动了。

  

2.参数配置
 
   
  几个重要的参数,默认的配置文件是config/elasticsearch.yaml
  
  
  ```
  #1. 节点名字,存储/日志路径
   node.name: node-1
   path.data: /path/to/data
   path.data: /path/to/logs 
    
  #2. 监听地址
   network.host: ["127.0.0.1","192.168.0.1"]
  
  #3. 监听端口
  http.port: 9200
  
  #4 自动发现 , elasticsearch 使用的是zen,支持多播/单播,后面章节我们会详细讨论集群配置
  #  例如:
     discovery.zen.ping.unicast.hosts: ["host1", "host2"]
     discovery.zen.minimum_master_nodes: 3
  
  ```
 
  ```
  #内存比较特别,单独说
  #Lock the memory on startup,在启动的时候将内存大小锁定,
  #`ES_HEAP_SIZE`参数建议使用系统一半的内存
  bootstrap.mlockall: true

  # Make sure that the `ES_HEAP_SIZE`

  ```
  
  这些参数可以通过--property=value 在启动的时候指定
  
   
  ```
   #可以使用--property=value 来启动,例如设置节点名字为es-01
   
   bin/elsaticsearch --node.name es-01 
  
  ```
  
  config/logging.yml 是日志配置文件,在这里就不详细讲解了,有兴趣的朋友请自己参阅官方文档.
 
  
   下一篇我们将探讨Elasticsearch 集群。
