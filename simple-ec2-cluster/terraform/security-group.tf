/**
  * Security Group
  */
resource "aws_security_group" "k8s" {
  name        = "cg-sg"
  vpc_id      = aws_vpc.this.id
  description = "security group for cluster"
}

resource "aws_security_group_rule" "ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.k8s.id
}

resource "aws_security_group_rule" "test_ingress" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.k8s.id
}
