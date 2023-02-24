data "template_file" "json_filename" {
    template         = "${file(var.json_filename)}"
}

locals {
    secret  = split(".", "${var.secret_name}")
}

/* resource "aws_ssm_parameter" "ssm_parameter" {
    name           = "/${var.environment}/${local.parameter_store[0]}"
    description    = "The parameter description"
    type           = "SecureString"
    value          = "${data.template_file.json_filename.rendered}"
    tags = {
        environment  = "${var.environment}-ssm-parameter"
    }
} */

resource "aws_secretsmanager_secret" "secret" {
  name = "/${var.environment}/${local.secret[0]}"
}

resource "aws_secretsmanager_secret_version" "secret_version" {
  secret_id     = aws_secretsmanager_secret.secret.id
  secret_string = "${data.template_file.json_filename.rendered}"
}
