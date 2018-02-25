+++
Categories = ["Development"]
Description = ""
Tags = ["golang"]
date = "2017-07-17T10:03:45+08:00"
title = "The Go Proramming Language reading notes 02"

+++

#### Go Proramming 读书笔记 02

 1.net/http client 基本使用
   
   &nbsp; Go提供net/http包, 提供http client/server的能力<!--more-->
   
 http包基本使用(client)
 
   ```go
   //提供了最基本的几种func 调用,这些最基本的调用无法设置header或者BasicAuth
   http.Get
   http.Head
   //Post和PostForm的区别,Post是按照body的方式,PostForm 是按照url.Values方式
   http.Post
   http.PostForm
   
   ```
   
 2.http包高级用法(client)
 
    ```go
    //如果要自定义header, basic auth,proxy
    
    //basic auth编码辅助方法,net/http已经自带了SetBasicAuth方法
    //func basicAuth(username, password string) string {
    //		auth := username + ":" + password
    //		return base64.StdEncoding.EncodeToString([]byte(auth))
    //}

    
    /*
    var DefaultTransport RoundTripper = &Transport{
        Proxy: ProxyFromEnvironment,
        DialContext: (&net.Dialer{
                Timeout:   30 * time.Second,
                KeepAlive: 30 * time.Second,
                DualStack: true,
        }).DialContext,
        MaxIdleConns:          100,
        IdleConnTimeout:       90 * time.Second,
        TLSHandshakeTimeout:   10 * time.Second,
        ExpectContinueTimeout: 1 * time.Second,
    }
    */
    
    //proxy example 
    proxyUrl, err := url.Parse("http://proxyIp:proxyPort")
	 	 
    client :=&http.Client {
      Transport: &http.Transport{Proxy: http.ProxyURL(proxyUrl)}
    }
    
    
    //custom header define
    req, err := http.NewRequest("GET", "http://example.com", nil)
    req.Header.Add("If-None-Match", `W/"wyzzy"`)
    
    
    //req.Header.Add("Authorization","Basic " + basicAuth("username1","password123"))

	 //2018 2/25 update , Request已经自带的一个新的方法
	 //func (r *Request) SetBasicAuth(username, password string)
	 req.SetBasicAuth("username1","password123")
	 
    //func (c *Client) Do(req *Request) (*Response, error) 
    resp,err:=client.Do(req)
	 
	 //处理resp即可
    
    
    ```
   
    
  3.http/template
  
  ```go
  
   //在模版中,如何在range 里面访问外部参数?
   //注意  $.CurrentPage, 在range里面如果还要访问外部变量需要使用$
  
    {{range $index,$page := .Page}}
     <li class="paginate_button {{if (eq $index $.CurrentPage)}} active {{end}}" aria-controls="demo-dt-basic" tabindex="0"><a href="./?page={{$index | add}}">{{$index| add}} </a></li>
    {{end}}  
  
   //在模版里面调用方法
  
    {{ $index | add }} 或者 (eq $index $.CurrentPage)
  
  ```
  
 
  4.net/http server 基本使用
  
  ```
  //静态网页
  http.FileServer
  	
  log.Fatal(http.ListenAndServe(":8080", http.FileServer(http.Dir("/var/www"))))
  
  //如果要对路径进行转换
  http.Handle("/tmpfiles/", http.StripPrefix("/tmpfiles/", http.FileServer(http.Dir("/tmp"))))
  
  //其他的动态使用HandleFunc或者Handle添加处理函数和模块
  
  ```
  
  
