ecs-cli up --keypair cmdigital --capability-iam  \
		   --size 1 --security-group sg-99e4d2fe \
		   --vpc vpc-55aa6c30 --subnets subnet-1899456f \
		   --image-id ami-175f1964 --instance-type m3.medium \
		   --verbose
