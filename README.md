# simple-lambda-app

Simple Node.js AWS Lambda app using the Serverless Framework.

## Setup

```bash
npm install
cp .env.example .env
```

## Local development

```bash
npm start
```

## Bedrock Q&A endpoint

`POST /ask` sends a question to AWS Bedrock (Claude Haiku 4.5 by default) and returns the answer.

```bash
curl -X POST http://localhost:3000/ask \
  -H "Content-Type: application/json" \
  -d '{"question": "What is AWS Lambda?"}'
```

This calls the real Bedrock API, so it needs valid AWS credentials with Bedrock access
(e.g. via `aws configure`, an SSO profile, or `AWS_ACCESS_KEY_ID` / `AWS_SECRET_ACCESS_KEY`
env vars) — the values in `.env` are mocked and not used for AWS authentication. Foundation
models activate automatically on first use, but Anthropic models require submitting a
one-time "use case details" form (triggered by trying the model in the Bedrock console
Playground) before your account can invoke them.

### Provisioning the local IAM user with Terraform

`terraform/` provisions the IAM user and policy used for local Bedrock access
(`AWS_ACCESS_KEY_ID` / `AWS_SECRET_ACCESS_KEY` above). It does not provision the Lambda/API
Gateway — that stays managed by the Serverless Framework.

```bash
cd terraform
cp terraform.tfvars.example terraform.tfvars   # edit aws_profile to your own SSO profile
terraform init
terraform apply
terraform output -raw access_key_id
terraform output -raw secret_access_key
```

Copy those two output values into `AWS_ACCESS_KEY_ID` / `AWS_SECRET_ACCESS_KEY` in your
`.env`. The Terraform state file contains the secret key in plaintext — it's gitignored,
keep it that way, and don't share it.

## Deploy

```bash
npm run deploy
```
