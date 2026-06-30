variable "aws_region" {
  description = "Região AWS onde os recursos serão criados"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Ambiente (dev/prod)"
  type        = string
}

variable "project_name" {
  description = "Nome do projeto"
  type        = string
  default     = "aws-certification-project"
}
