+++
Description = ""
tags = ["linux", "centos"]
date = "2016-03-07T23:06:16+08:00"
menu = "main"
title = "CentOS7 重置root密码"

+++

#### CentOS 7 重置root密码	 
  
  [Source][]
  [Source]: http://www.liberiangeek.net/2014/09/reset-forgotten-root-password-centos-7-servers/ "连接"
  
  1. At the boot menu , press e to edit the existing kernel (Core) as shown below. <!--more-->

  ![启动图片](/img/centos7-forgot-root-password.png) <p>
  2.  Next,scroll down to the list until you see the line underlined below (ro), change ro to rw and start a bash shell, it should look lik this rw init =/sysroot/bin/sh.

  ![启动图片](/img/centos7-forgot-root-password-1.png) 
 
  
 ```
 #Change ro to rw and start a bash shell
 rw init=/sysroot/bin/sh
 ```
 
 ![启动图片](/img/centos7-forgot-root-password-2.png)
 
 3.After change,press Control+X or Ctrl+X , start into single user mode.
 
 ```
  chroot /sysroot
 ``` 
 
  ![启动图片](/img/centos7-forgot-root-password-3.png)
  
 4.Finally,run passwd root ,change root password
 

  ```
  #This is very import tips:
  #  if server say bad password , it will not changed after reboot! you must input strong password .
  :/#passwd root
  ```
  
  5.if you anbled SELinux , you need  update autorelabel
  
  ```
  touch /.autorelabel
  ```
  Exit and reboo your system. You should be able to sign on system with the new password you created. (If you input bad password, change is failure).
  
 Enjoy!
 