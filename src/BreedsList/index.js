'use strict';

const AWS = require('aws-sdk');
AWS.config.update({ region: process.env.REGION });

const s3 = new AWS.S3();

const bucket = process.env.BUCKET;

const { logger } = require('/opt/nodejs/logger');
const { s3SelectQuery } = require('/opt/nodejs/s3Select');

exports.handler = async function (event) {
  logger('called layer func');

  console.log('EVENT', event);
  let query = 'Select * from s3Object s LIMIT 30';

  if (event.queryStringParameters) {
    const filter = event.queryStringParameters.filter;
    query = `SELECT * FROM s3object s 
    WHERE LOWER(s.label) LIKE '%${filter.toLowerCase()}%'`;
  }

  try {
    const data = await s3SelectQuery(query);

    return {
      statusCode: 200,
      body: JSON.stringify({
        data,
      }),
    };
  } catch (e) {
    console.error(e);
  }
};
