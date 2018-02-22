+++
Categories = ["Development", "GoLang"]
Description = ""
Tags = ["Development", "golang"]
date = "2017-07-17T10:03:45+08:00"
menu = "main"
title = "The Go Proramming Language reading notes 02"

+++

#### Go Proramming 读书笔记 02

 1.net/http client 基本使用
   
   &nbsp; Go提供net/http包, 提供http client/server的能力<!--more-->
   
 http包基本使用(client)
 
   ```go
   #提供了最基本的几种func 调用,这些最基本的调用无法设置header或者BasicAuth
   #http.Get
   #http.Head
   #Post和PostForm的区别,Post是按照body的方式,PostForm 是按照url.Values方式
   #http.Post
   #http.PostForm
   
   ```
   
 2.http包高级用法(client)
 
    ```go
    #如果要自定义header, basic auth
    
    ```
   
    
  3.http/template
  
  ```
  //在模版中,如何在range 里面访问外部参数?
  //注意  $.CurrentPage, 在range里面如果还要访问外部变量需要使用$
  
   {{range $index,$page := .Page}}
    <li class="paginate_button {{if (eq $index $.CurrentPage)}} active {{end}}" aria-controls="demo-dt-basic" tabindex="0"><a href="./?page={{$index | add}}">{{$index| add}} </a></li>
   {{end}}  
  
  //在模版里面调用方法
  
   {{ $index | add }} 或者 (eq $index $.CurrentPage)
  
  ```
  
 
  4.net/http
  
  ```
  //静态网页
  http.FileServer
  	
  
  ```
  
  