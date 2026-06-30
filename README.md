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

Then hit `http://localhost:3000/hello`.

## Bedrock Q&A endpoint

`POST /ask` sends a question to AWS Bedrock (Claude 3 Haiku by default) and returns the answer.

```bash
curl -X POST http://localhost:3000/ask \
  -H "Content-Type: application/json" \
  -d '{"question": "What is AWS Lambda?"}'
```

This calls the real Bedrock API, so it needs valid AWS credentials with Bedrock access
(e.g. via `aws configure` or `AWS_ACCESS_KEY_ID` / `AWS_SECRET_ACCESS_KEY` env vars) —
the values in `.env` are mocked and not used for AWS authentication. You also need to
[request model access](https://docs.aws.amazon.com/bedrock/latest/userguide/model-access.html)
for the model set in `BEDROCK_MODEL_ID` in your AWS account/region.

## Deploy

```bash
npm run deploy
```
