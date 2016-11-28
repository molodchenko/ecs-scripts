set -e

export TARGET_GROUP_NAME=target-group-my-cluster

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


mas "$(aws ec2 describe-vpcs | jq -r '.Vpcs[].VpcId')"
vpc=$value


aws elbv2 create-target-group --name "$TARGET_GROUP_NAME" --protocol HTTP --port 80 \
--vpc-id $vpc
