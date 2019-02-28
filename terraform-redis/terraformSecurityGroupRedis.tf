resource "aws_security_group" "redis" {
  name = "tomcat-oracle-dockercompose-redis-terraform-aws-sample-redis"
  description = "tomcat-oracle-dockercompose-redis-terraform-aws-sample Redis Access"
  ingress {
    protocol = "tcp"
    from_port = 22
    to_port = 22
    cidr_blocks = [
      "0.0.0.0/0"]
  }
  ingress {
    protocol = "tcp"
    from_port = 6379
    to_port = 6379
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
    Name = "tomcat-oracle-dockercompose-redis-terraform-aws-sample Redis Access"
  }
}