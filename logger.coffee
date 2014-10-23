winston = require 'winston'

### Example
  # `logger.info( 'info', 'Test Log Message',{anything: 'This is metadata'});`
  # `logger.log( 'info', 'Test Log Message', {anything: 'This is metadata'});`
  # ##Logging Levels
  # verbose, info, http, warn, err, silent
###

logger = new (winston.Logger)(transports: [
  new (winston.transports.Console)({ level: 'info' })
  new (winston.transports.File)(filename: "stdout.log")
])

module.exports = logger
