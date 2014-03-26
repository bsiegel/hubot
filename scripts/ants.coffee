# Description:
#   DO YOU WANT ANTS? BECAUSE THAT'S HOW YOU GET ANTS
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   ants - tell people about the ants
#
# Author:
#   bsiegel

module.exports = (robot) ->
  robot.hear /ants/i, (msg)->
    msg.send 'https://s3.amazonaws.com/uploads.hipchat.com/14158/50237/GpduEryjIgVnZgO/upload.png'

