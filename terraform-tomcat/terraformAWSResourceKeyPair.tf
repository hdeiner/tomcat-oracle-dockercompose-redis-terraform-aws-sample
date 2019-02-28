resource "aws_key_pair" "tomcat_key_pair" {
  key_name = "tomcat_key_pair"
  public_key = "${file("~/.ssh/id_rsa.pub")}"
}