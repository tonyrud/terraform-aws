const s3SelectQuery = (query) => {
  return new Promise((resolve, reject) => {
    const params = {
      Bucket: process.env.BUCKET,
      Key: process.env.QUERY_FILE,
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

module.exports = { s3SelectQuery };
