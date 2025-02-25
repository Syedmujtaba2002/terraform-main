provider "aws" {
  region = "ap-south-1" 
}


resource "aws_key_pair" "smh" {
  key_name   = "syed"  
    public_key = file("~/.ssh/id_mum.pub") 
}

resource "aws_instance" "web_server" {
  ami                    = "ami-00bb6a80f01f03502"
  instance_type          = "t2.micro"
  key_name      = aws_key_pair.smh.key_name
  

  connection {
    type        = "ssh"
    user        = "ubuntu"  # Replace with the appropriate username for your EC2 instance
    # private_key = file("C:/Users/veerababu/.ssh/id_rsa")
    private_key = file("~/.ssh/id_mum")  #private key path
    host        = self.public_ip
  }
  # local execution procee 
 provisioner "local-exec" {
    command = "touch file500" 
   
 }
  # File provisioner to copy a file from local to the remote EC2 instance
  provisioner "file" {
    source      = "file30"  # Replace with the path to your local file
    destination = "/home/ubuntu/file30"  # Replace with the path on the remote instance
  }
  # remote execution process 
  provisioner "remote-exec" {
    inline = [
"touch file200",
"echo hello from aws >> file200", 
]
 }
}