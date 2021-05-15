'use strict';

const AWS = require('aws-sdk');
AWS.config.update({ region: 'us-east-1' });

const s3 = new AWS.S3();

const bucket = process.env.BUCKET;

exports.handler = async function (event) {
  try {
    const data = await s3SelectQuery(
      'Select * from s3Object s LIMIT 10',
      'breeds',
    );

    return {
      statusCode: 200,
      body: data,
    };
  } catch (e) {
    console.error(e);
  }
};

const s3SelectQuery = (query, filename) => {
  return new Promise((resolve, reject) => {
    const params = {
      Bucket: bucket,
      Key: `${filename}.csv`,
      Expression: query,
      ExpressionType: 'SQL',
      InputSerialization: {
        CSV: {
          FieldDelimiter: ',',
          FileHeaderInfo: 'USE',
        },
        CompressionType: 'NONE',
      },

      OutputSerialization: {
        JSON: {
          RecordDelimiter: ',',
        },
      },
    };

    let resultData = '';
    s3.selectObjectContent(params, function (err, data) {
      if (!err) {
        data.Payload.on('data', (event) => {
          if (event.Records && event.Records.Payload) {
            const parsedPayload = event.Records.Payload.toString();
            resultData += parsedPayload;
          }
        });
        data.Payload.on('end', () => {
          try {
            const replaceLastComma = resultData.replace(/,\s*$/, '');
            resolve(`[${replaceLastComma}]`);
          } catch (e) {
            reject(
              new Error(
                `Unable to convert S3 data to JSON object. S3 Select Query: ${params.Expression}, Error ${e}`,
              ),
            );
          }
        });
      } else {
        reject(err);
      }
    });
  });
};
