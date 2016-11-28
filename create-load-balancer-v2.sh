export elbv2_name=elbv2-my-cluster

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

aws ec2 describe-subnets | jq '.Subnets[]| .Tags[]| .Value'
mas "$(aws ec2 describe-subnets | jq -r '.Subnets[].SubnetId')"
subnet=$value

aws ec2 describe-security-groups | jq '.SecurityGroups[]| .Description + " " + .GroupId'
mas "$(aws ec2 describe-security-groups | jq -r '.SecurityGroups[].GroupId')"
sg=$value

aws elbv2 create-load-balancer --name "$elbv2_name"  \
--subnets $subnet --security-groups $sg