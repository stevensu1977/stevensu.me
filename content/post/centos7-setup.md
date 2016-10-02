+++
description = ""
tags = ["linux", "centos"]
date = "2016-02-29T22:42:43+08:00"
menu = "main"
title = "CentOS7 安装设置"

+++



#### CentOS 7 安装以及配置

   1. Disable SELINUX
   
      查看selinux 配置, 注意选择permissive或者disabled <!--more-->

     	    [root@node01 centibox]# cat /etc/sysconfig/selinux
	        # This file controls the state of SELinux on the system.
	        # SELINUX= can take one of these three values:
	        #     enforcing - SELinux security policy is enforced.
	        #     permissive - SELinux prints warnings instead of enforcing.
	        #     disabled - No SELinux policy is loaded.
	        SELINUX=enforcing
	        # SELINUXTYPE= can take one of three two values:
	        #     targeted - Targeted processes are protected,
	        #     minimum - Modification of targeted policy. Only selected processes are protected.
	        #     mls - Multi Level Security protection.
	        SELINUXTYPE=targeted

   2. 检查基本环境
   
    *   python (系统自带2.7.5,无pip)
    *   node
    *   erlang
    *   c/c++ (parser) （系统自带gcc 4.8.5)
    *   Java (Spark/Hadoop)<p>
  

   3. 安装pip，shadowsocks，polipo
   		
		#安装epel-release (扩展包, pip 需要)
        yum install epel-release
		yum -y update
		


		

	3.1 配置shadowsocks

	    yum install python-setuptools && easy_install pip
	    #如果发现easy_insall pip 说找不到,可以使用
	    #yum install python-pip 替代
		pip install shadowsocks
		mkdir -p /etc/shadowsocks

		vi /etc/shadowsocks/config.json
		{
 		"server":"*****",
 		"server_port":8388,
 		"local_address": "127.0.0.1",
 		"local_port":1080,
 		"password":"*****",
 		"timeout":600,
 		"method":"aes-256-cfb",
		}

		vi /usr/lib/systemd/system/shadowsocks-client.service

		
		[Unit]
		Description=Shadowsocks Client
		After=network.target
		
		[Service]		
		Type=simple
		PIDFile=/run/shadowsocks/client.pid
		PermissionsStartOnly=true
		ExecStartPre=/bin/mkdir -p /var/run/shadowsocks
		ExecStartPre=/bin/chown root:root /var/run/shadowsocks
		ExecStart=/usr/bin/sslocal --pid-file /var/run/shadowsocks/client.pid -c /etc/shadowsocks/config.json
		Restart=on-abort
		User=root
		Group=root

		[Install]
		WantedBy=multi-user.target

    3.2 配置polipo

	     git clone https://github.com/jech/polipo.git
	     make all
		 mkdir /etc/polipo
		 [root@node01 centibox]# cat /etc/polipo/conf
		 proxyAddress = "0.0.0.0"

		 socksParentProxy = "127.0.0.1:1080"
		 socksProxyType = socks5

		 chunkHighMark = 50331648
		 objectHighMark = 16384

		 serverMaxSlots = 64
		 serverSlots = 16
		 serverSlots1 = 32


   4. 安装docker

	 Docker.com [有一篇详细的文档](https://docs.docker.com/engine/installation/linux/centos/).

     我选择的是使用脚本安装

	    curl -fsSL https://get.docker.com/ | sh

	    usermod -aG docker centibox

		docker run --cpu-shares 5 -m 64m  hello-world

		echo  $(docker ps -a -q)



##
  
### 问题汇总

   1. Q: Delta RPMs disabled because /usr/bin/applydeltarpm not installed.
      
      A: 安装deltarpm  
	     
	    yum install deltarpm

   2. Q: make: makeinfo: Command not found

	  A: 安装texinfo <p>
	  texinfo.x86_64 : Tools needed to create Texinfo format documentation files
      
	    yum install texinfo


  3. Q: CentOS7 默认没有telnet
  
	 A: 安装telnet 

	    yum install telnet.x86_64

