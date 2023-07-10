/*
module "vpc" {
  source = "./vpc"
  VPC_CIDR_Block = "10.0.0.0/16"
}


#----------------------------subnets ---------------------
module "subnet-1" {
  source = "./subnets"
  az = "us-east-1a"
  subnet_CIDR_Block = "10.0.0.0/24"
  vpc-id = module.vpc.id
  type-st = true
  name = "pro-sub-pub-1"
}

module "subnet-2" {
  source = "./subnets"
  subnet_CIDR_Block = "10.0.2.0/24"
  vpc-id = module.vpc.id
  type-st = true
  name = "pro-sub-pub-2"
  az = "us-east-1b"
}

module "subnet-3" {
  source = "./subnets"
  az = "us-east-1a"
  subnet_CIDR_Block = "10.0.1.0/24"
  vpc-id = module.vpc.id
  type-st = true
  name = "pro-sub-priv-1"
}

module "subnet-4" {
  source = "./subnets"
  az = "us-east-1b"
  subnet_CIDR_Block = "10.0.3.0/24"
  vpc-id = module.vpc.id
  type-st = true
  name = "pro-sub-priv-2"
  
}


#----------------------------sec gro ---------------------
module sec-grop-ins {
  source = "./security-group"
  name-sg = "sec-group-ins" 
  vpc-id-sg = module.vpc.id
}


module ami-ds {
  source = "./datasource"
}

#----------------------------private instance ---------------------
module priv-inst-1 {
  source = "./priv-apach-instance"
  sub-ins-id = module.subnet-3.subID
  name-ins = "pro-private-inst-1"
  segID = module.sec-grop-ins.sg-id
  ami-id = module.ami-ds.ami-id 
}

module priv-inst-2 {
  source = "./priv-apach-instance"
  sub-ins-id = module.subnet-4.subID
  name-ins = "pro-private-inst-2"
  segID = module.sec-grop-ins.sg-id
  ami-id = module.ami-ds.ami-id 
}



#Nat
module Nat-gw {
  source = "./Nat-gateway"
  sub-id = module.subnet-1.subID
}

#IGW
module "IGW" {
  source = "./internet-gateway"
  vpcID = module.vpc.id
  IGW-name = "pro-IGW"
}

#private routing table
module private-routing-table {
  source = "./priv-routing-table"
  vpc-id-priv-subnet = module.vpc.id
  r-nat-id = module.Nat-gw.NAT-ID
  name-priv-rt = "pro-private routing table"
}

#association 1 priv sub with priv rout table
module asso-private-1 {
  source = "./asso-sub-w-rt"
  ass-sub-id = module.subnet-3.subID
  ass-rt-id = module.private-routing-table.pr-rt-id
}

#association 2 priv sub with priv rout table
module asso-private-2 {
  source = "./asso-sub-w-rt"
  ass-sub-id = module.subnet-4.subID
  ass-rt-id = module.private-routing-table.pr-rt-id
}


#public routing table
module public-routing-table {
  source = "./pub-routing-table"
  vpc-id-pub-subnet = module.vpc.id
  prt-gw-id = module.IGW.IGW-ID
  name-pub-rt = "pro-public routing table"
}

#association 1 pub sub with priv rout table
module asso-public-1 {
  source = "./asso-sub-w-rt"
  ass-sub-id = module.subnet-1.subID
  ass-rt-id = module.public-routing-table.pub-rt-id
}


#association 2 pub sub with priv rout table
module asso-public-2 {
  source = "./asso-sub-w-rt"
  ass-sub-id = module.subnet-2.subID
  ass-rt-id = module.public-routing-table.pub-rt-id
}


#----------------------------private load balancer ---------------------
module priv-target-group {
  source = "./target-group"
  tg-name = "pro-priv-tg"
  nlb-vpc-id = module.vpc.id
}

module priv-net-lb {
  source = "./network-load-balancer"
  nlb-sub1-id = module.subnet-3.subID
  nlb-sub2-id = module.subnet-4.subID
  ltg-arn = module.priv-target-group.tg-arn
  nlb-name = "pro-priv-nlb"
  lb-state = true
}

module priv1-register-targets {
  source = "./regis-tg-w-inst"
  re-tg = module.priv-target-group.tg-arn
  re-inst-id = module.priv-inst-1.priv-instance_id
}

module priv2-register-targets {
  source = "./regis-tg-w-inst"
  re-tg = module.priv-target-group.tg-arn
  re-inst-id = module.priv-inst-2.priv-instance_id
}


#----------------------------public load balancer ---------------------
module pub-target-group {
  source = "./target-group"
  tg-name = "pro-pub-tg"
  nlb-vpc-id = module.vpc.id
}

module pub-net-lb {
  source = "./network-load-balancer"
  nlb-sub1-id = module.subnet-1.subID
  nlb-sub2-id = module.subnet-2.subID
  ltg-arn = module.pub-target-group.tg-arn
  nlb-name = "pro-pub-nlb"
  lb-state = false
}

module pub1-register-targets {
  source = "./regis-tg-w-inst"
  re-tg = module.pub-target-group.tg-arn
  re-inst-id = module.pub-inst-nginx-1.pub-instance_id
}

module pub2-register-targets {
  source = "./regis-tg-w-inst"
  re-tg = module.pub-target-group.tg-arn
  re-inst-id = module.pub-inst-nginx-2.pub-instance_id
}


#----------------------------public nginx instance ec2 ---------------------
module pub-inst-nginx-1 {
  source = "./pub-nginx-instances"
  ami-id-pub-ins = module.ami-ds.ami-id 
  pub-ins-sub-id = module.subnet-1.subID
  pub-ins-secg-id = module.sec-grop-ins.sg-id
  pub-ins-name = "pro-public-inst-1"
}

module pub-inst-nginx-2 {
  source = "./pub-nginx-instances"
  ami-id-pub-ins = module.ami-ds.ami-id 
  pub-ins-sub-id = module.subnet-2.subID
  pub-ins-secg-id = module.sec-grop-ins.sg-id
  pub-ins-name = "pro-public-inst-2"
}
*/