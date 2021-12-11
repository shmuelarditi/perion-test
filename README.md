Terraform: 
	- 3 providers (aws , kubernetes, helm)
	- VPC with 2 private subnets and 1 public subnet.
	- eks cluster & managed node group 
	- installing jenkins on the cluster 
	- installing helm chart of metrics-server
	- installing EFK with helm charts 

Jenkins:
	- installing the hello-world deployment with helm chart
	- creates autoscaling with hpa inside the same pipeline
	- creates time-based scaling with cronjob that override the hpa minimum replicas.
	
	#NOTE: jenkins checking out a git repo that contains the Jenkinsfile itself, and all the required files.
	
Manual installations:
	- EFK was mannualy installed on the cluster.
