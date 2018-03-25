---
title: "How to deploy k8s cluster on Oracle Public Cloud through kubeadm"
author: "Steven Su"
cover: "/img/cover.jpg"
tags: ["kubernetes" ]
date: 2018-02-28T13:05:45+08:00
draft: false
---

## How to deploy k8s culster on Oracle Public Cloud

   As you know , beacome kubernets 1.4, provoid kubeadm help deploy k8s environment to On-Demand, Cloud , this article is about kubeadmin.<!--more-->


   1.  Prepare your oracle cloud account and IaaS instance 

    You can select OCI or OCI classic, 2 types IaaS, please use Oracle enterprise linux 7 (UERK4) image , I create 3 three instance , every one with 1 OCPU/7.5GB Memory.
    
    cloud-node04 (k8s master)
    cloud-node05 (k8s node)
    cloud-node06 (k8s node)
    
   2. update yum & install docker-engine , kubeadm
   
     Use your privatekey login every instance
     
     
     ```bash
     
       cd /etc/yum.repos.d/
       curl -O -S http://yum.oracle.com/public-yum-ol7.repo
       
       #enable ol7_addons, ol7_preview(kubeadm need), set enabled=1
       vi  public-yum-ol7.repo
     
       yum update
       
       yum install docker-engine
       yum install kubeadm
     ``` 
     
   3. You need container-registry.oracle.com
   
     If you not login , you will get docker pull failed information like this "docker pull container-registry.oracle.com/kubernetes/kube-proxy-amd64:v1.8.4
Error response from daemon: repository container-registry.oracle.com/kubernetes/kube-proxy-amd64 not found: does not exist or no pull access"
     
     ```bash
     docker login container-registry.oracle.com
     ```
    
   4. Init k8s master

     Oracle provide kubeadm-setup.sh replace kubeadm. 

      ```bash
      #on cloud-node04 (k8s master)
      kubeadm-setup up
      
      #if everything is ok , you get follow this ,
      
      [root@cloud-node04 opc]# kubeadm-setup.sh up
      Starting to initialize master node ...
      Checking if env is ready ...
      Checking whether docker can pull busybox image ...
      Checking access to container-registry.oracle.com/kubernetes ...
      v1.8.4: Pulling from kubernetes/kube-proxy-amd64
      Digest: sha256:d716df87885a86bdf723b8f50f0c739205398cd0473036e4429d59ec07b474e2
      Status: Image is up to date for container-registry.oracle.com/kubernetes/kube-proxy-amd64:v1.8.4
      Checking whether docker can run container ...
      Checking iptables default rule ...
      Checking br_netfilter module ...
      Checking sysctl variables ...
      Check successful, ready to run 'up' command ...
      Waiting for kubeadm to setup master cluster...
      Please wait ...
      | - 75% completed
      Waiting for the control plane to become ready ...
      ...............
      100% completed
      clusterrole "flannel" created
      clusterrolebinding "flannel" created
      serviceaccount "flannel" created
      configmap "kube-flannel-cfg" created
      daemonset "kube-flannel-ds" created

      Installing kubernetes-dashboard ...

      Creating self-signed certificates
      Generating a 2048 bit RSA private key
      .........................+++
      ..........................................................................................+++
      writing new private key to 'dashboard.key'
      -----
      No value provided for Subject Attribute C, skipped
      No value provided for Subject Attribute ST, skipped
      No value provided for Subject Attribute L, skipped
      No value provided for Subject Attribute O, skipped
      No value provided for Subject Attribute OU, skipped
      Signature ok
      subject=/CN=kubernetes-dashboard
      Getting Private key
      secret "kubernetes-dashboard-certs" created
      serviceaccount "kubernetes-dashboard" created
      role "kubernetes-dashboard-minimal" created
      rolebinding "kubernetes-dashboard-minimal" created
      deployment "kubernetes-dashboard" created
      service "kubernetes-dashboard" created
      Restarting kubectl-proxy.service ...
      [kubeadm] WARNING: starting in 1.8, tokens expire after 24 hours by default (if you require a non-expiring token use --token-ttl 0)

      [===> PLEASE DO THE FOLLOWING STEPS BELOW: <===]

      Your Kubernetes master has initialized successfully!

      To start using your cluster, you need to run (as a regular user):

        mkdir -p $HOME/.kube
        sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
        sudo chown $(id -u):$(id -g) $HOME/.kube/config

      
      You can now join any number of machines by running the following on each node
      as root:

        kubeadm-setup.sh join --token 34f5ed.837475c98a4b7edc 192.168.2.100:6443 --discovery-token-ca-cert-hash sha256:65f1a9bef9f3a2a360b09085a23c52ddd385ecdd29baae2dd067ab9e631f2996
        
        
        #need setup kubectl env
        useradd oracle
        su - oracle
        mkdir -p $HOME/.kube
        sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
        sudo chown $(id -u):$(id -g) $HOME/.kube/config
		  
		  kubectl get nodes
		  
		  
		  [oracle@cloud-node04 ~]$ kubectl get nodes
		  NAME               STATUS    ROLES     AGE       VERSION
		  cloud-node04.k8s   Ready     master    2h        v1.8.4+2.0.1.el7
		  
      
      ```
   5. registration  k8s node

      ```bash
      #after setp4 you can get join command , please run it as root 
      kubeadm-setup.sh join --token 34f5ed.837475c98a4b7edc 192.168.2.100:6443 --discovery-token-ca-cert-hash sha256:65f1a9bef9f3a2a360b09085a23c52ddd385ecdd29baae2dd067ab9e631f2996
      
      ```
      
   6. Tips
   	Kubernets require complex enviroment include network, OS, system configuration .
   	
   	Most error kubeadm already gvie your fix command ,you just run it.
   	
   	```bash
   	  #ERROR Tips
   	  #ERROR 1 
   	  kuberuntime_sandbox.go:54] CreatePodSandbox for pod "etcd-localhost.localdomain_kube-system(6ee636e415b0ba6be9631785d3894bdf)" failed: rpc error: code = Unknown desc = failed pulling image "container-registry.oracle.com/kubernetes/pause-amd64:3.0": Error response from daemon: Get https://container-registry.oracle.com/v2/kubernetes/pause-amd64/manifests/3.0: unauthorized: authentication required
   	
   	  #you need use "docker login container-registry.oracle.com"
   	  docker login container-registry.oracle.com
   	  
   	  #ERROR 2  	   
   	  [ERROR] Please allow iptables default FORWARD rule to ACCEPT
      the way to do it:
      # /sbin/iptables -P FORWARD ACCEPT
   	
   	   #you need /sbin/iptables -P FORWARD ACCEPT 
   	   /sbin/iptables -P FORWARD ACCEPT
   	   
      #ERROR 3
   	  [ERROR] net.bridge.bridge-nf-call-ip6tables is 0
      please set it to 1:
      # /sbin/sysctl -p /etc/sysctl.d/k8s.conf
      
   	  
   	```
   	There have some very import error,sometim execute kubeadm-setup join show success, but master can't find this node use kubectl,
   	  
   	```bash
   		#you need check kubelet service
   		systemctl status -l kubelet
   		
   		A) hostname "" a DNS-1123 subdomain must consist of lower case alphanumeric characters, '-' or '.', and must start and end with an alphanumeric character (e.g. 'example.com', regex used for validation is '[a-z0-9]([-a-z0-9]*[a-z0-9])?(\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*')
[preflight] If you know what you are doing, you can skip pre-flight checks with `--skip-preflight-checks`
      
         this problem because your hostname use other char except [a-z,0-9,.,-], like  "cloud_node05",this is wrong hostname , need change "cloud-node05"  
         
       B) not found /etc/cni/net.d 
       I don't know why have one node can't create /etc/cni/netd, but we can quick fix it.
       
       mkdir -p /etc/cni/net.d
       cd /etc/cni/net.d
       #create 10-flannel.conf use this:
       {
         "name": "cbr0",
         "type": "flannel",
         "delegate": {
           "isDefaultGateway": true
         }
       }
       
       #rejoin k8s
   	
   	```
   
<!--more-->

This is version 1 , kubeadm-deploy-k8s-OPC guide.
