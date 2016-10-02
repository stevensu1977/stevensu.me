+++
Description = ""
tags = ["db2", "mac"]
date = "2016-03-10T12:37:43+08:00"
menu = "main"
title = "DB2 Macbook pro VMwareFusion Crash"

+++


#### DB2 MacBookPro VMware Fusion Crash

 I build windows 7 vitrual machine on macbook pro using
 
 VMware Fusion ,<!--more--> when I start db2 express 64 for windows, it crash.
 
 I got error message:
 
 ```
 Problem signature:
  Problem Event Name:                          APPCRASH
  Application Name:                               DB2START.EXE
  Application Version:                            10.1.300.533
  Application Timestamp:                       523a8dd4
  Fault Module Name:                             DB2WINT64.dll
  Fault Module Version:                          10.1.300.533
  Fault Module Timestamp:                     523a892c
  Exception Code:                                    c0000005
  Exception Offset:                                  0000000000001015
  OS Version:                                           6.1.7601.2.1.0.274.10
  Locale ID:                                            1053
  Additional Information 1:                     516e
  Additional Information 2:                     516eca0b67cfd09c90e66458c5210645
  Additional Information 3:                     fbbe
  Additional Information 4:                     fbbe552d029c4fd19a87300f93f73351
  ```
  
  I find this issue on VMWare site [Source][]
  [Source]: https://communities.vmware.com/thread/461857
 "连接"   
  
 
  
  the problem appears to be that the DB2 installer can't handle more than 4 responses to the CPUID query for deterministic cache parameters.  It just so happens that the mobile Haswell CPUs with integrated GPUs reply with 5 or 6 responses to the CPUID query for deterministic cache parameters.
 
  The same thing would happen if the DB2 installer were run natively on these parts (e.g. in Boot Camp).  Note that this would not be an issue on desktop Haswell CPUs without integrated GPUs, since they only return 4 responses to the CPUID query for deterministic cache parameters.
 
  Fortunately, with Fusion, you can configure your VM to lie about its deterministic cache parameters.  The following configuration options should do the trick:
 
``` 
monitor_control.enable_fullcpuid = TRUE
cpuid.4.4.eax = "0000:0000:0000:0000:0000:0000:0000:0000"
```
 >As always, the VM must be completely powered down (not suspended), and you should quit Fusion before making these changes.  It is always wise to make a back up first. See http://kb.vmware.com/kb/1014782 for details on editing your configuration file.
 
>VMware cannot support this configuration, since we do not cover it in our testing, but this may be a reasonable workaround while you wait for a fix from IBM.
  
 I sloved this issue used this way !
