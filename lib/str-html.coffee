module.exports.strToHtml = (str) ->
  # convert end of line to html break
  str = str.replace /(?:\r\n|\r|\n)/g, '<br/>'
  # convert indentions to html space
  str = str.replace /\s\s/g, '&nbsp;&nbsp;'

  return str
