+++
Categories = ""
Description = ""
Tags = ["big data", "Spark"]
date = "2016-04-10T21:21:14+08:00"
menu = "main"
title = "Apache Spark 学习笔记二"

+++
#### Apache Spark 启动

   &nbsp; &nbsp;&nbsp; &nbsp;上一篇[Apache Spark 学习笔记一](/post/spark-study-01/)给大家介绍了Apache Spark几个重要的概念, <!--more-->从本篇文章开始,我们就会进一步学习、使用Apache Spark。
  
 1. 下载Apache Spark
 
     &nbsp; &nbsp;Apache Spark 主要有2种方式,编译版,源代码, 由于现实使用中Spark经常会与
   Hadoop(HDFS)配合使用,所以项目网站提供了编译好的不同Hadoop版本(2.4/2.6)的Spark,如果
   需要使用特殊的Hadoop建议使用源代码自行构建。
  
     [下载链接: &nbsp; spark-1.6.1-bin-hadoop2.4.tgz](https://spark.apache.org/downloads.html)


2. Apache Spark 运行架构几个概念
     
     &nbsp;&nbsp; Driver Program(SparkContext), Master,Worker,Executor
  
    ![Apache Spark Cluster](/img/apache-spark-cluster-overview.png)
  
     &nbsp;&nbsp; Spark 应用主要是通过SparkContext来访问Spark Cluster Manager(Standalone cluster manager, YARN or Mesos), SparkContext会把任务分给各个Executor
    
     &nbsp;&nbsp; 每一个应用都会获得自己的执行进程(Executor process),在没有外部存储的情况下,不能跨越SparkContext实例进行数据共享。
     
     &nbsp;&nbsp; Spark在较长时间的任务执行的时候不会依赖cluster manager, 执行进程(executor process) 之间可以通信, 甚至cluster manager可以设置、安排、调度其他任务(例如 Mesos/YARN).
     &nbsp;&nbsp; Driver Program 必须可以访问到工作节点(work node),这样才能与分配给它的执行进程(Executor process)进行通信。
     
     
3. Apache Spark Cluster 运行方式
   
     &nbsp;&nbsp; Apache Spark目前支持以下几种运行方式
   
  
     3.1 Standalone
   
     
     ```js
	   Apache Spark 自带的资源调度方式,由Master负责调度,不需要任何外部资源管理器,
	   本学习笔记也主要基于standalone模式,而且standalone结合后面提到的docker部署
	   非常方便。
     ```
     
     3.2 YARN
   
     
     ```js
	   Apache Spark 与Hadoop 2.0(YARN)结合,由YARN充当资源管理器
     ```
     
     3.3 Mesos
   
     
     ```js
	   Mesos充当Apache Spark 资源调度器
     ```

4. Apache Spark 启动
   
  
      
      ```python
	    #解压spark-1.6.1-bin-hadoop2.4.tgz
	    
	    tar zxf spark-1.6.1-bin-hadoop2.4.tgz . 
	    cd  spark-1.6.1-bin-hadoop2.4
	    
	    #由于我们使用的是local model或者standalone 模式，
	    #所以可以在下面的pyspark/spark-shell后面加上 
	    #--master=local[2] 或者--master=spark://master-host:port
	    
	    
	    #use pyspark
	    ./bin/pyspark
	    
	    #use scala
	    ./bin/spark-shell      
	   ```
       
       
       ![pyspark](/img/apache-spark-pyspark.png)

       ![pyspark](/img/apache-spark-sparkshell.png)  
