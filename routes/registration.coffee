fs = require('fs')

getRequirements = (req, res) ->
  fs.createReadStream('routes/requirements.txt').pipe(res)

module.exports.getRequirements = getRequirements
