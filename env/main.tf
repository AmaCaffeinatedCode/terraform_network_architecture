module "vpc" {
  source = "../modules/vpc"

  name        = var.name
  cidr_block  = var.vpc_cidr
  az          = var.az
  tags        = var.tags
  project_url = var.project_url
}

module "networking" {
  source = "../modules/networking"

  name        = var.name
  vpc_id      = module.vpc.vpc_id
  access_ip   = var.access_ip
  tags        = var.tags
  project_url = var.project_url
}

module "security" {
  source = "../modules/security"

  name        = var.name
  tags        = var.tags
  project_url = var.project_url
}

module "ssh_key" {
  source      = "../modules/ssh_key"
  name        = var.name
  tags        = var.tags
  project_url = var.project_url
}

module "ec2" {
  source = "../modules/ec2"

  name          = var.name
  bastion_ami   = var.bastion_ami
  private_ami   = var.private_ami
  instance_type = var.instance_type
  key_pair_name = "${var.name}-key-pair"
  subnet_ids = {
    public    = module.vpc.public_subnet_id
    private_a = module.vpc.private_subnet_ids[0]
    private_b = module.vpc.private_subnet_ids[1]
  }
  security_group_ids = {
    bastion_sg   = module.networking.bastion_sg
    private_a_sg = module.networking.private_a_sg
    private_b_sg = module.networking.private_b_sg
  }
  iam_instance_profile_ssm = module.security.ssm_instance_profile_arn
  tags                     = var.tags
  project_url              = var.project_url
}
