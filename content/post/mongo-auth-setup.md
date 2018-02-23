+++
Description = ""
tags = ["mongo"]
date = "2016-03-24T11:08:56+08:00"
title = "Mongo auth setup"

+++

#### MongoDB Auth 配置

   1. Start MongoDB without access control
   
     <!--more-->

     ```
     mongod --port 27017 --dbpath /data/db1
     ```
     
   2. Connect to the instance

    ```
      mongo --port 27017
    ```
    
    
   3. Create the database  administrator

     Add a use with the userAdminAnyDatabase role (this is DB SA role, this role even can't show collections,not db user rol)
     
   
    ```javascript
      use admin
      db.createUser(
      	{
      	 user: 'sa',
      	 pwd: 'welcome1',
      	 roles:[ { role: "userAdminAnyDatabase", db: "admin" }]
      	}
      
     }
     
     #you can use "show user" show all user in current database
     
     use <database>
     show users
     
     # if you want show current mongo instance all database  user
     user admin
     db.system.users.find().pretty() 
   
     
    ```
   
   4. Re-start the MongoDB instance with access control
   Restart ths mongod instance with the --auth option,if using a conf file ,
   the "security.authorization" setting.

    ```
    mongod --auth --port 27017 --dbpath /data/db1
    ```
     
   5. Authenticate as the use administrator

    ```
    mongo --port 27017 -u "sa" -p "welcome1" --authenticationDatabase "admin"
   
     #or 
   
    mongo --port 27017
    use admin
    db.auth("sa","welcome1")
    ```
   
   6. Create Database user role

    ```javascript
   		# we show you , how to create normal database user role
   		
   		#first use SA
   		mongo --port 27017  -u "sa" -p "welcome1" --authenticationDatabase "admin"

		#second switch your normal database 
		
		#role : read/readWrite
		
   		use borgnix
   		db.createUser(
   			{
   			user:"test1",
   			pwd:"welcome1",
   			roles:[
   				{role: "readWrite",db:"borgnix"}
   			]
   			}
   		)
   
      show users
      
      
      #if not get any error, congratulations ,
      
      #use test01 login borgnix
      mongo --port 27017 -u "test1" -p "welcome1" --authenticationDatabase "borgnix"
      #or
      
      use borgnix
      db.auth("test1","welcome1")
      
      #you can use other command ,like 'show collections'
   
   
    ```
    
    It's all done!
