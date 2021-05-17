'use strict';

const AWS = require('aws-sdk');
AWS.config.update({ region: process.env.REGION });

const s3 = new AWS.S3();

const bucket = process.env.BUCKET;

exports.handler = async function (event) {
  console.log('EVENT: ', event);

  const breedId = event.pathParameters.id;

  try {
    const data = await s3SelectQuery(
      `Select * from s3Object s WHERE s.id = '${breedId}'`,
      'breeds',
    );

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
            resolve(JSON.parse(replaceLastComma));
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
