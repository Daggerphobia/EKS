Content-Type: multipart/mixed; boundary="==BOUNDARY=="
MIME-Version:  1.0
--==BOUNDARY==
Content-Type: text/cloud-boothook; charset="us-ascii"


#install ssm
yum install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm
systemctl enable amazon-ssm-agent && systemctl start amazon-ssm-agent


--==BOUNDARY==
Content-Type:text/x-shellscript; charset="us-ascii"

#!/bin/bash
set -o xtrace


set -a
source /etc/environment

# Bootstrap and join the cluster
/etc/eks/bootstrap.sh --b64-cluster-ca '${cluster_auth_base64}' --apiserver-endpoint '${endpoint}' ${bootstrap_extra_args} --kubelet-extra-args "${kubelet_extra_args}" '${cluster_name}'
# Allow user supplied userdata code


--==BOUNDARY==--