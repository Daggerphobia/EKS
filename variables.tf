variable region {
  type = string
  default     = "us-west-1"
  description = "AWS region"
}

variable cluster_name {
    type = string
    default = "eks"
}

variable vpc_name {
    type = string
    default = "eks"
}

variable instance_type_workers {
    type = string
    default = "t2.micro"
}

variable instance_type_masters {
    type = string
    default = "t2.micro"
}

variable desired_workers {
    type = number
    default = 2
}

variable desired_masters {
    type = number
    default = 1
}