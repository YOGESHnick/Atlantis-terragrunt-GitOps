data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

resource "aws_instance" "demo" {
  count         = var.instance_count
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
  subnet_id     = "subnet-058a17ee18465ecce"

  tags = {
    Name = "atlantis-demo-${count.index + 1}"
  }
}

output "instance_ids" {
  value = aws_instance.demo[*].id
}