fullpageOpts =
  anchors: ["top", "green", "white", "blue", "gold", "black", "purple", 'yellow', 'sns', 'caution', 'about']
  # navigation: true
  # navigationPosition:'left'
  # fitToSection: true
  scrollOverflow: true
  verticalCentered: false
  menu: "#pagination"
  afterLoad: ->
    $('#section_sns, #section_caution, #section_about').css 'height', 'auto'
  # onLeave: (index, next, dir)->
  #   console.log index, next, dir
  #   if 9 < next < 12
  #     $.fn.fullpage.setFitToSection(false)
  #     $.fn.fullpage.setAutoScrolling(false)
  #   else
  #     $.fn.fullpage.setFitToSection(true)
  #     $.fn.fullpage.setAutoScrolling(true)

init = ->
  $('#mainTop').fullpage fullpageOpts


$ ->
  init()

  $('.item-menu-sub-inner > a').on 'click', ->
    $BODY.removeClass 'menu-opened'
