aws ecs create-cluster --cluster-name "my-cluster"

aws ec2 request-spot-instances \
--spot-price 0.2 \
--instance-count 1 \
--launch-specification \
    "{ \
        \"ImageId\":\"ami-175f1964\", \
        \"InstanceType\":\"m3.medium\", \
        \"KeyName\":\"cmdigital\", \
        \"UserData\":\"`base64 userdata.sh`\", \
        \"IamInstanceProfile\": { \"Arn\": \"arn:aws:iam::830490074399:instance-profile/ecsInstanceRole\" }, \
        \"NetworkInterfaces\": [ { \"DeviceIndex\": 0, \"AssociatePublicIpAddress\": true, \"SubnetId\": \"subnet-1899456f\", \"Groups\": [ \"sg-99e4d2fe\",\"sg-dfbc03ba\" ]
  }] \
    }"
