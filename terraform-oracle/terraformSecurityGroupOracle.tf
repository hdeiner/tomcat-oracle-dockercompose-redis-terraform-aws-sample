resource "aws_security_group" "oracle" {
  name = "tomcat-oracle-dockercompose-oracle-terraform-aws-oracle-sample"
  description = "tomcat-oracle-dockercompose-oracle-terraform-aws-sample Oracle Access"
  ingress {
    protocol = "tcp"
    from_port = 22
    to_port = 22
    cidr_blocks = [
      "0.0.0.0/0"]
  }
  ingress {
    protocol = "tcp"
    from_port = 1521
    to_port = 1521
    cidr_blocks = [
      "0.0.0.0/0"]
  }
  ingress {
    protocol = "tcp"
    from_port = 8081
    to_port = 8081
    cidr_blocks = [
      "0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [
      "0.0.0.0/0"]
  }
  tags {
    Name = "tomcat-oracle-dockercompose-redis-terraform-aws-sample Oracle Access"
  }
}