+++
Description = ""
tags = ["HOWTO", "jdk","ubuntu"]
date = "2016-05-12T22:23:52+08:00"
menu = "main"
title = "Install JDK Ubuntu"

+++

#### Install JDK Ubuntu 

 
  1.Installing JDK on Ubuntu 14.04 
   
   &nbsp; OpenJDK or Oracle JDK <!--more-->
   
   [source](https://www.atlantic.net/community/howto/install-java-ubuntu-14-04/)
   
   Before we begin let makr sure that the server is fully updated with this following command:
   
   ```
     sudo apt-get update
   ```   
   
   After your server have been fully updated, you will need to know what version of Java is currently installed or if it is not installed ,with the following command:
   
   ```
   java -version
   ```
   Once you have verified if Java is installed or not , choose the type of Java installation that you want with one the following:
   
   ```
   # open-jdk
   
   sudo apt-get install default-jdk
   sudo apt-get install default-jre 
   
   ```
   2.Install Java Open JRE or JDK on Ubuntu 14.04
   
   ```
   sudo apt-get install openjdk-7-jre
   sudo apt-get install openjdk-7-jdk
   ```
   
   3.Install Java Oracle JRE or JDK on Ubuntu 14.04 (use ppa)
   
   Another alternative Java install is with Oracle JRE and JDK. However , we would need additional repositories for a proper installation.
   
   
   ```
   sudo apt-get install software-properties-common python-software-properties
   sudo add-apt-repository ppa:webupd8team/java
   
   ```
   Then , you will need to fully update the system with the following command:
   
   ```
   sudo apt-get update
   ```
   
   [jdk installer list](https://launchpad.net/~webupd8team/+archive/ubuntu/java)
     
   ```
   #  You can also install previous and newer versions of Java by using one of the following command:
   sudo apt-get install oracle-java6-installer
   sudo apt-get install oracle-java7-installer
   sudo apt-get install oracle-java8-installer
   ```
   
  If you have multiple versions of Java installed on your server,then you have the ability to select a default version. Check your alternatives with the following command:
  
  ```
  sudo update-alternatives --config java
  ```
  
   ![启动图片](/img/install-Java-on-ubuntu-14.04-1.jpg) 
   
   
   4.Setup JAVA_HOME on Ubuntu 14.04
   
   Since many programs now days need a JAVA_HOME environment variable
   
   ```
   JAVA_HOME="/usr/ib/jvm/java-8-oracle"
   
   ```
   
   
