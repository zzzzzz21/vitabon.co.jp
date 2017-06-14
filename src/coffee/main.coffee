$WINDOW = $ window
$HTML = $ 'html'
$BODY = $ 'body'

window.$WINDOW = $WINDOW
window.$HTML = $HTML
window.$BODY = $BODY

# スクロール監視
SCROLL_WATCHED = if (navigator.userAgent.indexOf('WebKit') < 0) then document.documentElement else document.body

window.SCROLL_WATCHED = SCROLL_WATCHED

$SCROLL = if (navigator.userAgent.indexOf('WebKit') < 0) then $WINDOW else $BODY

window.$SCROLL = $SCROLL

scrollSmooth = (ref, speed = 500, easing = "swing")->
  d = $.Deferred()
  yTarget = if (ref is "#" or ref is "") then 0 else $(ref).offset().top
  $SCROLL.animate
    scrollTop : yTarget
  , speed
  , easing
  , ->
    d.resolve()
  d.promise()

window.scrollSmooth = scrollSmooth

$ ->

  $('.button-menu-open, .button-menu-close').on 'click', ->
    $BODY.toggleClass 'menu-opened'
    $('#menuSub').css('top', SCROLL_WATCHED.scrollTop)
