$buo_f = ->
  e = document.createElement("script")
  e.src = "//browser-update.org/update.js"
  document.body.appendChild e
  return
$buoop =
  vs:
    i: 9
    f: 28
    o: 12.1
    s: 5.1

  c: 2

try
  document.addEventListener "DOMContentLoaded", $buo_f, false
catch e
  window.attachEvent "onload", $buo_f
