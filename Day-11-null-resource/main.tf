resource "aws_key_pair" "smh" {
  key_name   = "syed"  
    public_key = file("~/.ssh/id_ed25519.pub") 
}

resource "aws_instance" "web" {
  ami           = "ami-00bb6a80f01f03502"
  instance_type = "t2.micro"
  key_name = aws_key_pair.smh.key_name
  
}

resource "null_resource" "ec2_setup" {
  triggers = {
    instance_id = aws_instance.web.id  # Runs if the EC2 instance is recreated
  }

  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("~/.ssh/id_ed25519")
      host        = aws_instance.web.public_ip
    }

    inline = [
      "sudo apt update -y",
      "sudo apt install nginx -y"
    ]
  }
}
