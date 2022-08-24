/**
  * Key Pair
  */
resource "aws_key_pair" "node" {
  key_name   = "cg-node-key"
  public_key = var.public_key
}

/**
  * EC2 Instance : Kube Masters
  */
resource "aws_instance" "master" {
  count         = 1
  ami           = var.instance_ami
  instance_type = var.instance_type
  key_name      = aws_key_pair.node.key_name

  associate_public_ip_address = true # Instances have public, dynamic IP

  vpc_security_group_ids = [aws_security_group.k8s.id]
  subnet_id              = element(aws_subnet.public, count.index).id

  root_block_device {
    volume_type           = "gp3"
    volume_size           = "20"
    delete_on_termination = true
  }

  tags = {
    Name                                = "cg-ec2-master-${count.index + 1}"
    "kubernetes.io/cluster/k8s-cluster" = "k8s-cluster"
  }
}

/**
  * EC2 Instance : Kube Workers
  */
resource "aws_instance" "worker" {
  count         = 2
  ami           = var.instance_ami
  instance_type = var.instance_type
  key_name      = aws_key_pair.node.key_name

  associate_public_ip_address = true # Instances have public, dynamic IP

  vpc_security_group_ids = [aws_security_group.k8s.id]
  subnet_id              = element(aws_subnet.public, count.index).id

  root_block_device {
    volume_type           = "gp3"
    volume_size           = "10"
    delete_on_termination = true
  }

  tags = {
    Name                                = "cg-ec2-worker-${count.index + 1}"
    "kubernetes.io/cluster/k8s-cluster" = "k8s-cluster"
  }
}
