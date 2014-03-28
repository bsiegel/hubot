# Description:
#   Get some stats from the kegbot
#
# Commands:
#   hubot what's on tap
#   hubot who's drinking
base_uri = 'http://kegbot.mobiledefense.local/api/'

module.exports = (robot) ->
  robot.respond /what'?s on tap\??/i, (msg) ->
    tapped msg

  robot.respond /who'?s drinking\??/i, (msg) ->
    drinking msg

tapped = (msg) ->
  msg.http(base_uri + 'taps')
    .get() (err, res, body) ->
      taps = JSON.parse(body)?.objects
      if taps? and taps.length > 0
        active_taps = tap for tap in taps when tap.current_keg?.online
        if active_taps.length > 0
          describe_tap msg, tap for tap in active_taps
        else
          no_taps msg
      else
        no_taps msg

no_taps = (msg) -> msg.send "Sorry, there's nothing on tap at the moment."

describe_tap = (msg, tap) ->
  image = tap.current_keg.type.image?.original_url
  image ?= tap.current_keg.type.image?.url
  msgs = []
  msgs.push image if image?
  msgs.push "#{image}#{tap.current_keg.type.name} is available on #{tap.name}"
  msg.send msgs.join "\n"

drinking = (msg) ->
  msg.http(base_uri + 'sessions')
    .get() (err, res, body) ->
      session = JSON.parse(body)?.objects?.shift()
      if session?.is_active and session?.id?
        describe_session msg, session.id
      else
        no_sessions msg

no_sessions = (msg) -> msg.send "No one's currently drinking."

describe_session = (msg, session_id) ->
  msg.http(base_uri + "sessions/#{session_id}/stats")
    .get() (err, res, body) ->
      data = JSON.parse(body)?.object?.volume_by_drinker
      sorted = ([k, v] for k,v of data).sort (a,b) -> b[1]-a[1]
      if sorted.length > 0
        msgs = ["There are #{sorted.length} people currently drinking."]
        msgs.push "#{s[0]} has had #{floz s[1]} so far this session." for s in sorted
        msg.send msgs.join "\n"
      else
        msg.send "I'm sorry, I can't find any info about the current session."

floz = (ml) -> "#{(ml * 0.033814).toFixed 1} oz"
