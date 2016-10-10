#!/bin/bash
echo "Deleting Instances"
Instance=`aws ec2 describe-instances --filters "Name=instance-state-code,Values=16" --query 'Reservations[*].Instances[*].InstanceId'`

aws ec2 wait instance-terminated --instance-ids $Instance

echo "Instances deleted"
echo "Starting Deletion of Auto Scaling group"
aws autoscaling set-desired-capacity --auto-scaling-group-name server-rg --desired-capacity 0
aws autoscaling delete-auto-scaling-group --auto-scaling-group-name server-rg
echo "Starting Deletion of Launch Configuration"
aws autoscaling delete-launch-configuration --launch-configuration-name  itmo544sjconfigure
echo "Starting Deletion of Load Balancer"
aws elb delete-load-balancer --load-balancer-name ITMO544sj
