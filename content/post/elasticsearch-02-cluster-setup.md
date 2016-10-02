+++
Description = ""
tags = ["nosql", "bigdata","document"]
date = "2016-05-18T21:44:26+08:00"
menu = "main"
title = "Elasticsearch - 02 Cluster Setup"

+++

#### Elasticsearch  第二篇 集群配置介绍

   &nbsp; &nbsp;&nbsp; &nbsp;本篇是介绍Elasticsearch Cluster 集群以及相关配置使用教程。<!--more-->
   
   
 1. Elasticsearch 集群介绍

    从Elasticsearch的文档上看,ES可以通过集群进行水平扩展,适合大规模的数据检索。再具体讲解Elasticsearch 集群可以实现: shards(分片), replication(复制),  failover(故障迁移)。
    
    ![集群示例](/img/elasticsearch-cluster.png)

    
    Elasticsearch 在不使用插件的情况下默认使用zen discovery 集群发现,支持多播(multicast)和单播(unicast)。
个人经验而言建议使用单播,可以避免误加入集群,或者网络环境不支持。
   
    根据Elasticsearch官方文档[Multicast Discovery is now a pluginedit](https://www.elastic.co/guide/en/elasticsearch/reference/2.3/breaking_20_removed_features.html#_multicast_discovery_is_now_a_plugin)介绍, 从ES 2.0开始 multicast就变成以插件方式支持。
    
    
    我使用的是2.3.2默认配置文件里面就给的unicast例子。
    
    
    
    
    Elasticsarch 除了自带的zen之外,还以插件的方式提供了[Azure discovery](https://www.elastic.co/guide/en/elasticsearch/reference/current/modules-discovery-azure.html),[EC2 discovery](https://www.elastic.co/guide/en/elasticsearch/reference/current/modules-discovery-ec2.html), [Google Computer Engine discovery](https://www.elastic.co/guide/en/elasticsearch/reference/current/modules-discovery-gce.html)。
    
    
    
 2. Elastisearch 集群配置

    [官方配置文档](https://www.elastic.co/guide/en/elasticsearch/reference/current/modules-discovery-zen.html#fault-detection)

   ```
   ＃集群名字,节点会通过discovery 加入到同一名字的集群
   cluster.name: es-cluster01
   
   
   #unicast的主机列表,默认的是 ["127.0.0.1", "[::1]"] 表示在本机所有网卡进行单播通信
   discovery.zen.ping.unicast.hosts: ["host1", "host2"]
 
   #为了防止脑裂("split brain"), 应该把该参数配置为:(所有节点总数 / 2 + 1):
   #例如,如果整个有4个节点,那么该值应该配置为4/2+1=3
   discovery.zen.minimum_master_nodes: 3
 
   #改值主要是忽略来自客户节点的ping(node.client为true或者node.data 和 node.master 的值均为false)进行master选举操作,默认为true
   discovery.zen.master_election.filter_client: true
 
   #类似上面,忽略来自data节点(nodes where node.data is true and node.master is false)的master选举操作
   discovery.zen.master_election.filter_data
 
 
   #几个ping阀值配置
   discovery.zen.fd.ping_interval: 1   #默认1s
   discovery.zen.fd.ping_timeout:  30  #默认30s
   discovery.zen.fd.ping_retries:	3   #默认3次
 
 
   #当master丢失,为选举产生的时候,工作策略,默认为write
   # all 表示当master丢失,read/write 都会被拒绝
   # write 表示当master 丢失, write 会被拒绝,read 系统将按照最后一次已知的集群配置进行操作
   discovery.zen.no_master_block= all | write 

  
   ```
    
    
  Elastisearch 集群测试
 
 
   ```
   使用默认配置文件,在同一台机器分别启动2个node
   
   #启动es-node01
   ./elasticsearch --node.name=es-node01
   
   #启动es-node02
   ./elasticsearch --node.name=es-node01
   
   ```
 

   ```
 #查看es-node01控制台,发现提示es-node02加入集群
[2016-05-18 11:30:11,340][INFO ][node                     ] [es-node01] version[2.3.2], pid[2976], build[b9e4a6a/2016-04-21T16:03:47Z]
[2016-05-18 11:30:11,342][INFO ][node                     ] [es-node01] initializing ...
[2016-05-18 11:30:12,061][INFO ][plugins                  ] [es-node01] modules [lang-groovy, reindex, lang-expression], plugins [head], sites [head]
[2016-05-18 11:30:12,084][INFO ][env                      ] [es-node01] using [1] data paths, mounts [[/ (rootfs)]], net usable_space [5.7gb], net total_space [17.4gb], spins? [unknown], types [rootfs]
[2016-05-18 11:30:12,084][INFO ][env                      ] [es-node01] heap size [990.7mb], compressed ordinary object pointers [true]
[2016-05-18 11:30:12,084][WARN ][env                      ] [es-node01] max file descriptors [4096] for elasticsearch process likely too low, consider increasing to at least [65536]
[2016-05-18 11:30:13,770][INFO ][node                     ] [es-node01] initialized
[2016-05-18 11:30:13,770][INFO ][node                     ] [es-node01] starting ...
[2016-05-18 11:30:13,906][INFO ][transport                ] [es-node01] publish_address {192.168.48.160:9300}, bound_addresses {127.0.0.1:9300}, {192.168.48.160:9300}
[2016-05-18 11:30:13,910][INFO ][discovery                ] [es-node01] es-cluster01/R_-oZRMvTVqn2IxEkRnZ9g
[2016-05-18 11:30:16,973][INFO ][cluster.service          ] [es-node01] new_master {es-node01}{R_-oZRMvTVqn2IxEkRnZ9g}{192.168.48.160}{192.168.48.160:9300}, reason: zen-disco-join(elected_as_master, [0] joins received)
[2016-05-18 11:30:16,993][INFO ][http                     ] [es-node01] publish_address {192.168.48.160:9200}, bound_addresses {127.0.0.1:9200}, {192.168.48.160:9200}
[2016-05-18 11:30:16,993][INFO ][node                     ] [es-node01] started
[2016-05-18 11:30:17,004][INFO ][gateway                  ] [es-node01] recovered [0] indices into cluster_state
[2016-05-18 11:31:16,926][INFO ][cluster.service          ] [es-node01] added {{es-node02}{VbsorCTXTeOh1DkBWLIGIQ}{192.168.48.160}{192.168.48.160:9301},}, reason: zen-disco-join(join from node[{es-node02}{VbsorCTXTeOh1DkBWLIGIQ}{192.168.48.160}{192.168.48.160:9301}])
   
   ``` 
   
   下一篇我们将继续讨论如何在Elasticsearch 集群环境下进行分片、复制、数据迁移备份。