### Key pair file
resource "aws_key_pair" "terraform-lab" {
  key_name   = "${var.ec2_instance_name}_key_pair"
  public_key = file(var.ssh_pubkey_file)
  tags = {
    Name = "terraform-lab"
    Project = var.tag_project
    Owner = var.tag_owner
    Env = var.tag_env
  }
}
