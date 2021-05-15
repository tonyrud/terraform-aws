'use strict';

// const AWS = require('aws-sdk');
// AWS.config.update({ region: 'us-east-1' });

// const s3 = new AWS.S3();

// const bucket = process.env.BUCKET;

exports.handler = async function (event) {
  console.log('EVENT: ', event);

  return {
    statusCode: 200,
    body: `path: ${event.pathParameters.id}`,
  };
};
