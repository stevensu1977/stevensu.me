+++
description = ""
tags = ["linux", "centos","glusterfs"]
date = "2016-03-16T22:42:43+08:00"
menu = "main"
title = "CentOS7 glusterfs 安装设置"

+++


#### CentOS 7 安装glusterfs 文件系统

   1. 增加gluster 源 
       
      ```
      wget http://download.gluster.org/pub/gluster/glusterfs/LATEST/CentOS/glusterfs-epel.repo
      
      mv glusterfs-epel.repo /etc/yum.repos.d/
      
      ```
      <!--more-->
      
   2. 安装对应的包

      ```
       yum install -y glusterfs glusterfs-server glusterfs-fuse
       
      ``` 
   
      查看selinux 配置, 注意选择permissive或者disabled 
      
   3. 启动服务

       ```
       service glusterd   start
       service glusterfsd start
       
       ```
   4. 配置集群、查看集群中的节点

      ```
      gluster peer probe node01
      gluster peer probe node02
      
      gluster pool list
      ```  

   5. 创建一个数据目录,gluster volume

		```
		   mkdir -p /opt/data
		   
		   #系统会提示,因为你在root partition上做gluster volume, 需要使用force
		   #The brick server01:/opt/data is being created in the root partition. It is recommended that you don't use the system's root partition for storage backend. Or use 'force' at the end of the command if you want to override this behavior.
		   gluster volume create kube_vol server01:/opt/data
		   
		   gluster volume create kube_vol server01:/opt/data force
		   gluster volume start kube_vol
		   gluster volume info
		      
		```

   6. 使用gluster 创建的卷

      ```
       mkdir /mnt/glusterfs
       
       mount -t glusterfs server:/kube_vol /mnt/glusterfs
       
       #测试读写
       dd if=/dev/sda of=/mnt/glusterfs/1.bin bs=1M count 20
      ```
	
		
