(function() {
  var $BODY, $HTML, $SCROLL, $WINDOW, SCROLL_WATCHED, scrollSmooth;

  $WINDOW = $(window);

  $HTML = $('html');

  $BODY = $('body');

  window.$WINDOW = $WINDOW;

  window.$HTML = $HTML;

  window.$BODY = $BODY;

  SCROLL_WATCHED = (navigator.userAgent.indexOf('WebKit') < 0) ? document.documentElement : document.body;

  window.SCROLL_WATCHED = SCROLL_WATCHED;

  $SCROLL = (navigator.userAgent.indexOf('WebKit') < 0) ? $WINDOW : $BODY;

  window.$SCROLL = $SCROLL;

  scrollSmooth = function(ref, speed, easing) {
    var d, yTarget;
    if (speed == null) {
      speed = 500;
    }
    if (easing == null) {
      easing = "swing";
    }
    d = $.Deferred();
    yTarget = (ref === "#" || ref === "") ? 0 : $(ref).offset().top;
    $SCROLL.animate({
      scrollTop: yTarget
    }, speed, easing, function() {
      return d.resolve();
    });
    return d.promise();
  };

  window.scrollSmooth = scrollSmooth;

  $(function() {
    return $('.button-menu-open, .button-menu-close').on('click', function() {
      $BODY.toggleClass('menu-opened');
      return $('#menuSub').css('top', SCROLL_WATCHED.scrollTop);
    });
  });

}).call(this);
