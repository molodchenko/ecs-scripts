set -e



function mas() {
	array=()
	  PS3='Please enter your choice, "q" finish choose: '
	  select item in $1
	  do
	    case $item in
	        "")
	            break
	            ;;
	        *) array+=("$item");;
	    esac
	  done
	value=$(printf " %s" "${array[@]}")
}

function instance_id() {
	array=()
	  PS3='Please enter your choice, "q" finish choose: '
	  select item in $1
	  do
	    case $item in
	        "")
	            break
	            ;;
	        *) array+=("Id=$item");;
	    esac
	  done
	value=$(printf " %s" ${array[@]})
}

echo "choose target group"
mas "$(aws elbv2 describe-target-groups | jq -r '.TargetGroups[].TargetGroupArn')"
tga=$value
echo $tga

echo "choose instances"
aws ec2 describe-instances | jq '.Reservations[]| .Instances[]| .PublicIpAddress + "   Instance ID:" + .InstanceId'
instance_id "$(aws ec2 describe-instances | jq '.Reservations[]| .Instances[]| .InstanceId')"
InstanceId=$value
echo $InstanceId


aws elbv2 register-targets --target-group-arn $tga  \
	--targets $InstanceId


