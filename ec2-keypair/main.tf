resource "aws_key_pair" "aws_key_pair" {
  key_name   = var.key_name
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCEZoBaTy1xB6FrKjqhE85Cvum4STGe5ilVme6baTYMIRPVgkKyHq9AYnjBsFGoUBGRnc8Q5zgn7HFGsf3HcVBBSBvH+M42T51knS3i1oGYN/tXmPVBMhjPoBAvCe38zRSclVIhhQ17d6baFy+xq0bE/nywJF/aTB+jVY6OVdru5FsnAubikzOa5JL2XOEOuvN8vi3Po5ZYLI+q1+T7l69aWcEeOxIGSjP163/bBOQ0bShhJxfLMUniycKI/sIVl9LPDdWbk/PVE+coFM5sBwVOnftNnQpbgfP4T+gPMvILCSbEiKBfqcXwWDSGgtMhXQxOllvS0FP4bgh7ICSG9sxn rsa-key-20220111"
}