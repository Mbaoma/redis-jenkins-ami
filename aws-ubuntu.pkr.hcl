variable "ami_name" {
  type    = string
  default = "redis-jenkins"
}

packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.1"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "ubuntu" {
  ami_name      = var.ami_name #"redis-jenkins"
  instance_type = "t2.micro"
  region        = "us-west-2"
  source_ami    = "ami-0cb4e786f15603b0d"
  ssh_username = "ubuntu"
}


build {
  name = "learn-packer"
  sources = [
    "source.amazon-ebs.ubuntu"
  ]

  provisioner "shell" {
    environment_vars = [
      "FOO=hello world",
    ]
    script = "./redis.sh"
  }


  provisioner "shell" {
    script = "./jenkins.sh"
  }
}
