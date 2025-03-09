####creating Ami #####
resource "aws_ami_from_instance" "frontend_ami" {
  name               = "frontend-ami"
  source_instance_id = aws_instance.frontend.id
  snapshot_without_reboot = true
}

resource "aws_ami_from_instance" "backend_ami" {
  name               = "backend-ami"
  source_instance_id = aws_instance.backend.id
  snapshot_without_reboot = true
}


##creating LT###

resource "aws_launch_template" "frontend_lt" {
  name          = "frontend-launch-template"
  image_id      = aws_ami_from_instance.frontend_ami.id
  instance_type = "t2.micro"



  network_interfaces {
    associate_public_ip_address = false
    security_groups = [aws_security_group.allow_all.id]
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "frontend-instance"
    }
  }
}

resource "aws_launch_template" "backend_lt" {
  name          = "backend-launch-template"
  image_id      = aws_ami_from_instance.backend_ami.id
  instance_type = "t2.micro"

 

  network_interfaces {
    associate_public_ip_address = false
    security_groups = [aws_security_group.allow_all.id]
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "backend-instance"
    }
  }
}

###creating asg for frontend## 
resource "aws_autoscaling_group" "frontend_asg" {
  name_prefix          = "frontend-asg"
  desired_capacity     = 1
  max_size            = 1
  min_size            = 1
  vpc_zone_identifier = [aws_subnet.front_1a.id,aws_subnet.front_1b.id]  # Corrected to public subnets
  target_group_arns   = [aws_lb_target_group.front_tg.arn]  # Corrected target group name

  health_check_type = "EC2"

  # Launch Template
  launch_template {
    id      = aws_launch_template.frontend_lt.id  # Corrected launch template name
    version = aws_launch_template.frontend_lt.latest_version
  }

  # Instance Refresh
  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 50
    }
    triggers = ["desired_capacity"]
  }

  tag {
    key                 = "Name"
    value               = "frontend-asg"
    propagate_at_launch = true
  }      
}

###ags for bakend##
resource "aws_autoscaling_group" "backend_asg" {
  name_prefix        = "backend-asg"
  desired_capacity   = 1
  max_size           = 1
  min_size           = 1
  vpc_zone_identifier = [aws_subnet.backend_1a.id, aws_subnet.backend_1b.id]  # Backend subnets should be private
  target_group_arns  = [aws_lb_target_group.front_tg.arn]  # Attach to backend target group
  
  health_check_type = "EC2"

  # Launch Template
  launch_template {
    id      = aws_launch_template.backend_lt.id
    version = aws_launch_template.backend_lt.latest_version
  }

  # Instance Refresh
  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 50
    }
    triggers = ["desired_capacity"]
  }

  tag {
    key                 = "Name"
    value               = "backend-instance"
    propagate_at_launch = true
  }
}

