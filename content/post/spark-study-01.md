+++
Description = ""
Tags = ["big data", "spark"]
date = "2016-03-31T13:44:38+08:00"
menu = "main"
title = "Apache Spark 学习笔记 一"

+++

#### Apache Spark 介绍

 
  1.Apache Spark 介绍
   
   &nbsp; Spark是UC Berkeley AMP lab所开源的类Hadoop MapReduce的通用并行框架 <!--more-->
   
   引用[WIKI](https://en.wikipedia.org/wiki/Apache_Spark)的说法, Apache Spark is an opensource cluster computing framework,
   
   它提供了Resilient distributed dataset (RDD),Apache Spark 技术栈包括:
   
   Spark Core、Spark SQL、Spark Streaming、MLlib、Graphx
  
   1.1 Spark Core包括了任务分配,调度,基础I/O,实现了应用接口对RDD的访问
   
   ```java
  val conf = new SparkConf().setAppName("wiki_test")       // create a spark config object
  val sc = new SparkContext(conf)                          // Create a spark context
  val data = sc.textFile("/path/to/somedir")               // Read files from "somedir" into an RDD of (filename, content) pairs.
  val tokens = data.map(_.split(" "))                      // Split each file into a list of tokens (words).
  val wordFreq = tokens.map((_, 1)).reduceByKey(_ + _)     // Add a count of one to each token, then sum the counts per word type.
  wordFreq.sortBy(s=>s._2).map(x => (x._2, x._1)).top(10)  // Get the top 10 words. Swap word and count to sort by count.
  ```
  
  1.2 Spark SQL 通过一个名为DataFrames数据抽象结构来访问RDD,提供更友好的访问方式。
  
  ```java
    import org.apache.spark.sql.SQLContext

    val url = "jdbc:mysql://yourIP:yourPort/test?user=yourUsername;password=yourPassword"   // URL for your database server.
    val sqlContext = new org.apache.spark.sql.SQLContext(sc)              // Create a sql context object

    val df = sqlContext
      .read
      .format("jdbc")
      .option("url", url)
      .option("dbtable", "people")
      .load()

    df.printSchema() // Looks the schema of this DataFrame.
    val countsByAge = df.groupBy("age").count() // Counts people by age
   ```   	   
   
   1.3 Spark Streaming 提供秒级别(Storm是毫秒级别)的流式计算能力
   
   1.4 MLlib Machine Learning Library
   
   1.5 Graphx