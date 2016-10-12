#!/bin/bash
echo "Deleting Instances"
Instance=`aws ec2 describe-instances --filters "Name=instance-state-code,Values=16" --query 'Reservations[*].Instances[*].InstanceId'`

aws autoscaling detach-load-balancers --load-balancer-names ITMO544sj --auto-scaling-group-name server-rg
aws autoscaling set-desired-capacity update-auto-scaling-group-name server-rg --min-size 0 --desired-capacity 0
aws ec2 wait instance-terminated --instance-ids $Instance

echo "Instances deleted "

aws autoscaling delete-auto-scaling-group --auto-scaling-group-name server-rg
echo "Starting Deletion of Launch Configuration"
aws autoscaling delete-launch-configuration --launch-configuration-name  itmo544sjconfigure
echo "Starting Deletion of Load Balancer"
aws elb delete-load-balancer --load-balancer-name ITMO544sj
