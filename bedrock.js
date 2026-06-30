require("dotenv").config();
const {
  BedrockRuntimeClient,
  InvokeModelCommand,
} = require("@aws-sdk/client-bedrock-runtime");

const client = new BedrockRuntimeClient({
  region: process.env.AWS_REGION || "us-east-1",
});

const DEFAULT_MODEL_ID = "us.anthropic.claude-haiku-4-5-20251001-v1:0";

module.exports.ask = async (event) => {
  let question;
  try {
    question = JSON.parse(event.body || "{}").question;
  } catch (err) {
    return {
      statusCode: 400,
      body: JSON.stringify({ error: "Invalid JSON body" }),
    };
  }

  if (!question) {
    return {
      statusCode: 400,
      body: JSON.stringify({ error: "Missing 'question' in request body" }),
    };
  }

  const modelId = process.env.BEDROCK_MODEL_ID || DEFAULT_MODEL_ID;

  try {
    const command = new InvokeModelCommand({
      modelId,
      contentType: "application/json",
      accept: "application/json",
      body: JSON.stringify({
        anthropic_version: "bedrock-2023-05-31",
        max_tokens: 512,
        messages: [{ role: "user", content: question }],
      }),
    });

    const response = await client.send(command);
    const payload = JSON.parse(Buffer.from(response.body).toString("utf-8"));
    const answer = payload.content?.[0]?.text ?? "";

    return {
      statusCode: 200,
      body: JSON.stringify({ question, answer }),
    };
  } catch (err) {
    console.error(err);
    return {
      statusCode: 500,
      body: JSON.stringify({
        error: "Failed to get a response from Bedrock",
        details: err.message,
      }),
    };
  }
};
