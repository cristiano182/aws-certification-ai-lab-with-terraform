require("dotenv").config();

module.exports.hello = async (event) => {
  return {
    statusCode: 200,
    body: JSON.stringify({
      message: "Hello from Lambda!",
      stage: process.env.STAGE,
      requestPath: event.path,
    }),
  };
};
