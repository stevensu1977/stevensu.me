+++
Categories = ["nosql", "elasticsearch"]
Description = ""
tags = ["nosql", "elasticsearch"]
date = "2016-07-12T21:15:22+08:00"
title = "Elasticsearch 插件篇 01"

+++

#### Elasticsearch  第三篇 插件配置

   &nbsp; &nbsp;&nbsp; &nbsp;本篇是介绍Elasticsearch 常用插件以及相关配置使用教程。<!--more-->
   
   
 1. Elasticsearch 插件介绍

    Elasticsearch通过插件机制可以扩展Elasticsearch的管理,使用功能,本文介绍常用的几个插件配置使用方法。
    
    首先Elasticsearch 提供了通用的插件安装方法 bin/plugin
    
    ```shell
    
      plugin <command>
             install  Install a plugin
             remove   Remove a plugin
             list 	  List installed plugins
             
      #可惜的是没有提供一个search的功能
    ```
    
       
    
    
 2. [Head 插件](https://github.com/mobz/elasticsearch-head)

    ```
     # Github上面版本说明, 注意5.x目前还不支持插件的方式运行
     # Install elasticsearch-head:
     #	– for Elasticsearch 5.x:
     #		site plugins are not supported. Run elasticsearch-head as a standalone server
     #	– for Elasticsearch 2.x – 4.x:
     #		sudo elasticsearch/bin/plugin install mobz/elasticsearch-head
     #	– for Elasticsearch 1.x:
     #		sudo elasticsearch/bin/plugin -install mobz/elasticsearch-head/1.x
     #	– for Elasticsearch 0.9:
     #	sudo elasticsearch/bin/plugin -install mobz/elasticsearch-head/0.9

      bin/plugin install mobz/elasticsearch-head
      restart elasticsearch 
    
    

     #	秉承了ES一贯的风格, head插件使用起来非常简单
     # head提供了集群节点,索引,数据的基本操作,查询
      open http://localhost:9200/_plugin/head
  
     ```
     ![head](/img/elasticsearch-plugin-head-1.png) <p>
     ![head](/img/elasticsearch-plugin-head-3.png) <p>
     ![head](/img/elasticsearch-plugin-head-2.png) <p>
    
    

	 
	 
 3. [IK 分词插件](https://github.com/medcl/elasticsearch-analysis-ik/)

    IK分词插件是由Medcl开发的，Medcl也是国内elasticsearch第一批使用、实践者。

    ```
     # Github上面版本说明, 注意目前还不支持2.3.4 & 5.0
     #IK version	ES version
     #	master	2.3.1 -> master
     #1.9.3	2.3.3
     #1.9.0	2.3.0
     #1.8.1	2.2.1
     #1.7.0	2.1.1
     #1.5.0	2.0.0
     #1.2.6	1.0.0
     #1.2.5	0.90.x
     #1.1.3	0.20.x
     #1.0.0	0.16.2 -> 0.19.0
     
     #install,select/checkout right IK version
     git clonet https://github.com/medcl/elasticsearch-analysis-ik.git
     mvn package
     copy and unzip target/releases/elasticsearch-analysis-ik-{version}.zip to your-es-root/plugins/ik
     
     
     restart elasticsearch 
     
     Tips:

			ik_max_word: 会将文本做最细粒度的拆分，比如会将“中华人民共和国国歌”拆分为“中华人民共和国,中华人民,中华,华人,人民共和国,人民,人,民,共和国,共和,和,国国,国歌”，会穷尽各种可能的组合；

			ik_smart: 会做最粗粒度的拆分，比如会将“中华人民共和国国歌”拆分为“中华人民共和国,国歌”。
			
	```
    
		
	```
	  
     #quick start 
     
     1.create index
	 
     curl -XPUT http://localhost:9200/index
	 
     2.create a mapping
	 
     curl -XPOST http://localhost:9200/index/fulltext/_mapping -d'
     {
      "fulltext": {
             "_all": {
             "analyzer": "ik_max_word",
             "search_analyzer": "ik_max_word",
             "term_vector": "no",
             "store": "false"
        },
        "properties": {
            "content": {
                "type": "string",
                "store": "no",
                "term_vector": "with_positions_offsets",
                "analyzer": "ik_max_word",
                "search_analyzer": "ik_max_word",
                "include_in_all": "true",
                "boost": 8
             }
          }
    	  }
	   }'
	 
	    3. index some docs
		 curl -XPOST http://localhost:9200/index/fulltext/1 -d'
		  {"content":"美国留给伊拉克的是个烂摊子吗"}
	   '
	 
	   curl -XPOST http://localhost:9200/index/fulltext/2 -d'
		  {"content":"公安部：各地校车将享最高路权"}
	   '

	   curl -XPOST http://localhost:9200/index/fulltext/3 -d'
		  {"content":"中韩渔警冲突调查：韩警平均每天扣1艘中国渔船"}
      '
    
	   curl -XPOST http://localhost:9200/index/fulltext/4 -d'
	     {"content":"中国驻洛杉矶领事馆遭亚裔男子枪击 嫌犯已自首"}
      '
      
      4.query with highlighting

	 curl -XPOST http://localhost:9200/index/fulltext/_search  -d'
	  {
   	    "query" : { "term" : { "content" : "中国" }},
        "highlight" : {
           "pre_tags" : ["<tag1>", "<tag2>"],
           "post_tags" : ["</tag1>", "</tag2>"],
           "fields" : {
             "content" : {}
           }
        }
     }
     '
     
     Result(省略)
	   

	```
     
     
     后面将陆续介绍几个River Plugin  包括CouchDB,MongoDB,JDBC,Hadoop ,ZooKeeper Discovery Plugin 等组件
