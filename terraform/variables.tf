variable "vpc_cidr_block" {
    default = "10.0.0.0/16"
}
variable "subnet_cidr_block" {
    default = "10.0.10.0/24"
}
variable "avail_zone" {
    default = "us-west-1b"
}
variable "env_prefix" {
    default = "dev"
}
variable "my_ip" {
    default = "96.49.56.42/32"
}
variable "instance_type" {
    default = "t2.micro"
}
variable "region" {
    default = "us-west-1"
}
variable "jenkins_ip" {
    default = "34.236.150.178/32"
}
