'use strict';

exports.handler = async function (event) {
  const breedId = event.pathParameters.id;

  try {
    const data = await s3SelectQuery(
      `Select * from s3Object s WHERE s.id = '${breedId}'`,
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
