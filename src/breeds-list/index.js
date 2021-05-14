'use strict';

const AWS = require('aws-sdk');
const dynamo = new AWS.DynamoDB.DocumentClient();

const breeds = [
  { label: 'Rabbit', abbreviation: 'RAB', key: 'rab' },
  { label: 'Bat', abbreviation: 'BAT', key: 'bat' },
  { label: 'Canine', abbreviation: 'CAN', key: 'can' },
];

exports.handler = async function (event) {
  console.log('EVENT', event);

  var response = {
    statusCode: 200,
    body: JSON.stringify(breeds),
  };

  return response;
};
