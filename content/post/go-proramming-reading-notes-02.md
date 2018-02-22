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
   
 http包高级用法(client)
 
    ```go
    #如果要自定义header, basic auth
    
    ```
   
   [Marshal example 1](https://play.golang.org/p/r5Vt4JBLbF) 
   
   [Marshal example 2,使用filed tag,自定义JSONfiled,格式化](https://play.golang.org/p/yheVlYT9P-)
   

   Unmarshal
	
   ```go
   //Unmarshal 方法提供了JSON到对象(struct)的转换
   
   const AccountJSON = `
	{
  		"email": "jack@gmail.com",
  		"password": "welcome1",
  		"created_at": "2009-11-10T23:00:00Z"
	}
	`
   acc:=&Account{} //注意要传入指针
   err:=json.UnMarshal(AccountJSON,acc)
  
	
   ```
   [Unmarshal example 1](https://play.golang.org/p/cSfm0ILF16)
   
   
   
   除了Marshal,Unmarshal之外, 还有2个直接对Writer/Reader操作的方式,分别是Encoder, Decoder
   
   ```go
   //example 读取远程的一个REST API 
   resp,err:=http.Get("https://api.github.com/search/issues?q=repo:golang/go")
   //如果使用Marshal和Unmarsha的话需要读取resp.Body,然后再进行处理
   issues := &Issues{}
   body,err:=ioutil.ReadAll(resp.Body)
   json.Unmarshl(body,issues)
   
   //使用Decoder即可省去ioutil.ReadAll这步
   //这种pipline的用法在golang非常常见
   decoder:=json.NewDecode(resp.Body)
   err=decoder.Decode(issues)
   
   ```
 
  2.encoding/json filed tag
  
  在基本用法中我们可以通过filed tag来定义json的字段
  
  ```go
  
  // 什么是filed tag ?
  // filed tag可以看作是struct 的meta data
  // 不少包使用了这个特性, 比如json字段的定义,
  // mongo 官方驱动也使用了filed tag
  //`json:"total_count,omitempty"`
  // `json:"_"` 忽略该字段
  // `json:",omitempty"` 如果该字段empty才忽略
  

  type Issues struct {
	Repo       string
	TotalCount int     `json:"total_count,omitempty"`
	Items      []Issue `json:"items"`
  }
  
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
  
  