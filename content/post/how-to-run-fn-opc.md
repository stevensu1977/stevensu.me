---
title: "Deploy Fn (open source serverless platform ) on Oracle Public Cloud"
author: "Steven Su"
#cover: "/img/cover.jpg"
tags: ["serverless"]
date: 2018-03-30T14:59:29+08:00
draft: false
---



   The Fn project is an open-source container-native serverless platform that you can run anywhere -- any cloud or on-premise. It’s easy to use, supports every programming language, and is extensible and performant.<!--more-->

   You can access [fnproject offical web site](http://fnproject.io/) get all information or [view on github](https://github.com/fnproject/fn).


   1. Pre-requisites
    
     - Docker 17.06 or later installed and runing
     - A Docker Hub account or other Docker-compliant registry (like container-registry.oracle.com)
     - If you need complie from source , you must install go
   
   2. Install fn

   you need login in your OPC vm , linux or windows
   
   ```bash
   
   #linux 
   #default install /usr/local/bin
   #[opc@cloud-node01 ~]$ whereis fn
   fn: /usr/local/bin/fn

   curl -LSs https://raw.githubusercontent.com/fnproject/cli/master/install | sh
   
   #windows
   #down it from https://github.com/fnproject/cli/releases 
   
   ```
   
   3. Start fn server
   wait a monent, fn need pull some image from docker registry
   
   ```bash
   #you need permission access unix:///var/run/docker.sock 
   [root@cloud-node01 opc]#
   [root@cloud-node01 opc]# fn start
   time="2018-03-31T00:24:42Z" level=info msg="Setting log level to" level=info
   time="2018-03-31T00:24:42Z" level=info msg="datastore dialed" datastore=sqlite3 max_idle_connections=256
   time="2018-03-31T00:24:42Z" level=info msg="agent starting cfg=&{MinDockerVersion:17.06.0-ce FreezeIdle:50ms EjectIdle:1s HotPoll:200ms HotLauncherTimeout:1h0m0s AsyncChewPoll:1m0s MaxResponseSize:0 MaxLogSize:1048576 MaxTotalCPU:0 MaxTotalMemory:0 MaxFsSize:0 PreForkPoolSize:0 PreForkImage: PreForkCmd:}"
   time="2018-03-31T00:24:42Z" level=info msg="no docker auths from config files found (this is fine)" error="open /root/.dockercfg: no such file or directory"
   time="2018-03-31T00:24:42Z" level=info msg="available memory" availMemory=5658624000 cgroupLimit=9223372036854771712 headRoom=628736000 totalMemory=6287360000
   time="2018-03-31T00:24:42Z" level=info msg="sync and async ram reservations" ramAsync=4526899200 ramAsyncHWMark=3621519360 ramSync=1131724800
   time="2018-03-31T00:24:42Z" level=info msg="available cpu" availCPU=2000 totalCPU=2000
   time="2018-03-31T00:24:42Z" level=info msg="sync and async cpu reservations" cpuAsync=1600 cpuAsyncHWMark=1280 cpuSync=400
   time="2018-03-31T00:24:42Z" level=info msg="Fn serving on `:8080`" type=full
   
           ______
          / ____/___
         / /_  / __ \
        / __/ / / / /
       /_/   /_/ /_/
           v0.3.402
   
   
   ```
   
   4. Start your frist java serverless function

   fn function SDK image    + fnproject/fn-java-fdk
    + fnproject/python 
    + fnproject/python 
    + fnproject/go    
    + 

   ```bash
   FN_JAVA_FDK_VERSION=1.0.59 fn init --runtime java hellojava
   
   [opc@cloud-node01 hellojava]$ fn deploy --app hellojava --local
   Deploying hellojava to app: hellojava at path: /hellojava
   Bumped to version 0.0.2
   Building image hellojava:0.0.2 .
   Updating route /hellojava using image hellojava:0.0.2...
   
   
   [opc@cloud-node01 hellojava]$ fn apps l
   hellojava
   [opc@cloud-node01 hellojava]$ fn routes list hellojava
   path		image		endpoint
   /hellojava	hellojava:0.0.2	localhost:8080/r/hellojava/hellojava
   [opc@cloud-node01 hellojava]$ fn call hellojava /hellojava
   Hello, world!
   
   
   ``` 
   
   5. Invoke your  java  function 

   You can use "fn call" or normal tools (etc. curl) access your java funciton

   ```bash
   
   [opc@cloud-node01 hellojava]$ fn call hellojava /hellojava
   Hello, world!

   [opc@cloud-node01 hellojava]$ curl -X GET localhost:8080/r/hellojava/hellojava
   Hello, world![opc@cloud-node01 hellojava]$
   
   ```
   
   6. Change code and redeploy  in second 
   
   Let's we add some thing and redploy, open HelloFunction.java and HelloFunctionTest.java
   
   ```java
    
    #vi hellojava/src/main/java/com/example/fn/HelloFunction.java
    //return "Hello, " + name + "!";
    return "Hello Serverless, " + name + "!";
     
    #also you need change test
    //vi src/test/java/com/example/fn/HelloFunctionTest.java
    //assertEquals("Hello, world!", result.getBodyAsString());
    assertEquals("Hello Serverless, world!", result.getBodyAsString());
    
    #same deploy command 
    fn deploy --app hellojava --local
   ``` 

    If you look for serverless framework or platform , may be you can try Fn project .
    
<!--more-->

doc version 1 .
