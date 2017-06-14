_timerScroll = _timerResize = null

THRESHOLD_TOP = 100
THRESHOLD_BOTTOM = 60

# 仮
_windowHeight = 500
_scrollHeight = 1000
_scroll = 0

toggleScrollStatus = ->
  _scroll = SCROLL_WATCHED.scrollTop
  bottomLine = _scrollHeight - _windowHeight - THRESHOLD_BOTTOM
  $BODY.addClass 'scroll-top' if THRESHOLD_TOP > _scroll
  $BODY.removeClass 'scroll-top' if THRESHOLD_TOP <= _scroll
  $BODY.addClass 'scroll-bottom' if bottomLine < _scroll
  $BODY.removeClass 'scroll-bottom' if bottomLine >= _scroll

$ ->
  # スムーズスクロールのバインド
  $("a[href^='#']").on "click", (e)->
    scrollSmooth $(@).attr("href")
    e.stopPropagation()
    e.preventDefault()

  $WINDOW
    .on 'load', ->
      _windowHeight = $WINDOW.innerHeight()
      _scrollHeight = $BODY.get(0).scrollHeight
      toggleScrollStatus()

    $WINDOW
      .on 'scroll', ->
        clearTimeout _timerScroll if _timerScroll
        _timerScroll = setTimeout ->
          toggleScrollStatus()
        , 20
      .on "resize", ->
        clearTimeout _timerResize if _timerResize
        _timerResize = setTimeout ->
          _windowHeight = $WINDOW.innerHeight()
          _scrollHeight = $BODY.get(0).scrollHeight
          return
        , 100
