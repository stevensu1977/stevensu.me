+++
Categories = ["mac"]
Description = ""
Tags = ["resetpassword"]
date = "2017-02-16T15:36:17+08:00"
title = "How to reset macbook password"

+++

# How to reset macbook password 




### 利用Single User Mode

   1. 开机时, 同时按住cmd+S + 电源键
   进入Single User Model ,会出现 #root>
   
   ```bash
   #检查磁盘, 将根目录以读写权限挂载
   fsck -y
   mount -uaw / 
   
   #重置Apple macbook设置状态
   rm /var/db/.AppleSetupDone
   
   reboot
   
   ```   
   
   2. 这样重新开机后系统会出现重新装机界面,所有软件均在,只需要设置一个新的管理员账号即可

   3. 以新管理员账号登录, 打开 系统-账户,
   直接修改原管理员密码。
   
   4. 以原有账号登录，一定要选择新建钥匙串!
   
   
 
