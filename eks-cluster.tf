resource "aws_key_pair" "eks_nodes" {
  key_name   = "eks-nodes"
  public_key = "ssh-rsa AAAAB3NzXXxi6Dx4a38Y1+US..."
}

module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "17.24.0"
  cluster_name    = local.cluster_name
  cluster_version = "1.20"
  subnets         = module.vpc.private_subnets

  vpc_id = module.vpc.vpc_id

  workers_group_defaults = {
    root_volume_type = "gp2"
  }



  worker_groups = [
    {
      name                          = "worker-group-1"
      instance_type                 = var.instance_type_workers
      userdata_template_file        = "./user-data.sh"  
      additional_security_group_ids = [aws_security_group.worker_group_mgmt_one.id]
      key_name                      = aws_key_pair.eks_nodes.key_name
      asg_desired_capacity          = var.desired_workers
    },
    {
      name                          = "worker-group-2"
      instance_type                 = var.instance_type_masters
      userdata_template_file        = "./user-data.sh" 
      additional_security_group_ids = [aws_security_group.worker_group_mgmt_two.id]
      key_name                      = aws_key_pair.eks_nodes.key_name
      asg_desired_capacity          = var.desired_masters
    },
  ]
}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}
