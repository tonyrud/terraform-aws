const moment = require('moment');

function logger(string) {
  console.log('Lambda Layer: ', string);
  console.log('NOW', moment.now());
}

module.exports = { logger };
