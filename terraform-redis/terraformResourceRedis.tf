resource "aws_instance" "ec2_redis" {
  count = 1
  ami = "ami-759bc50a"
  instance_type = "t2.small"
  key_name = "${aws_key_pair.redis_key_pair.key_name}"
  security_groups = ["${aws_security_group.redis.name}"]
  provisioner "file" {
    connection {
      type = "ssh",
      user = "ubuntu",
      private_key = "${file("~/.ssh/id_rsa")}"
    }
    source      = "compose-redis.yml"
    destination = "/home/ubuntu/compose-redis.yml"
  }
  provisioner "remote-exec" {
    connection {
      type = "ssh",
      user = "ubuntu",
      private_key = "${file("~/.ssh/id_rsa")}"
    }
    script = "terraformProvisionRedisUsingDocker.sh"
  }
  tags {
    Name = "tomcat-oracle-dockercompose-redis-terraform-aws-sample Redis ${format("%03d", count.index)}"
  }
}