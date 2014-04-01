# Description:
#   This is a snotur
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   snotur - what is a snotur?
#
# Author:
#   bsiegel

module.exports = (robot) ->
  robot.hear /snotur/i, (msg)->
    msg.send 'https://s3.amazonaws.com/uploads.hipchat.com/14158/153443/8KzocltXoZlZaXy/68747470733a2f2f6c68332e67677068742e636f6d2f5f4461714a43514a536262412f5369375935476966755f492f41414141414141414143492f517365357a46436b584d732f73313630302f6a61636b65642b6b6977692e6a7067.jpeg'

