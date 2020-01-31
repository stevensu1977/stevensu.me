+++
date = "2016-02-27T22:58:22+08:00"
menu = "main"
title = "About Me"
layout= "about"
+++

  <br>
  &nbsp;&nbsp;&nbsp;&nbsp;S1君是一个考了现代汉语专业,拿了教师证,教了几年书,却混迹IT圈,自诩为搬得了机器,写得了代码,玩得了架构,讲得了情怀的工程师。
  
  &nbsp;&nbsp;&nbsp;&nbsp;S君很早就想建个自己专属Blog,写写身边的琐事,中间也断断续续在CSDN,Javaeye上面开了Blog, 奈何说的多写的少, 转眼过去发现自己马上进四奔五,赶紧抓住青春的尾巴, 由此本小站才得以诞生。

  
 ```go
 
 	 package main

 	 import (
 	 	"fmt"
 	 )

 	 var year []int

 	 func doStomething(year []int, something string){
     	 fmt.Println("\n")
     	 fmt.Printf("%s,  %d~%d\n",something ,year[0],year[1])
 	 }

 	 func main() {

     	 //As Chinese/Computer Teacher 
     	 year=[]int{1999,2005}
     	 doStomething(year,"Teaching something in middle school")

     	 //As Java Developer
     	 year=[]int{2005,2007}; 
     	 doStomething(year,"Devlop something in UISOFT")
    
     	 //As Presales
     	 year=[]int{2007,2013}; 
     	 doStomething(year,"Presales in BEA/Oracle")

     	 year=[]int{2013,2016}; 
     	 doStomething(year,"Presales in IBM")

     	 year=[]int{2016,2019}; 
     	 doStomething(year,"Cloud CSM in Oracle")
       
     	 //As AWS SA
     	 fmt.Println("\n\n2019~, Enjoy SA  in AWS, keep simple and stupid!")
   
 	 }
 
 ```
