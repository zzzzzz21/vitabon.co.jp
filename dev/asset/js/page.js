(function() {
  var THRESHOLD_BOTTOM, THRESHOLD_TOP, _scroll, _scrollHeight, _timerResize, _timerScroll, _windowHeight, toggleScrollStatus;

  _timerScroll = _timerResize = null;

  THRESHOLD_TOP = 100;

  THRESHOLD_BOTTOM = 60;

  _windowHeight = 500;

  _scrollHeight = 1000;

  _scroll = 0;

  toggleScrollStatus = function() {
    var bottomLine;
    _scroll = SCROLL_WATCHED.scrollTop;
    bottomLine = _scrollHeight - _windowHeight - THRESHOLD_BOTTOM;
    if (THRESHOLD_TOP > _scroll) {
      $BODY.addClass('scroll-top');
    }
    if (THRESHOLD_TOP <= _scroll) {
      $BODY.removeClass('scroll-top');
    }
    if (bottomLine < _scroll) {
      $BODY.addClass('scroll-bottom');
    }
    if (bottomLine >= _scroll) {
      return $BODY.removeClass('scroll-bottom');
    }
  };

  $(function() {
    $("a[href^='#']").on("click", function(e) {
      scrollSmooth($(this).attr("href"));
      e.stopPropagation();
      return e.preventDefault();
    });
    $WINDOW.on('load', function() {
      _windowHeight = $WINDOW.innerHeight();
      _scrollHeight = $BODY.get(0).scrollHeight;
      return toggleScrollStatus();
    });
    return $WINDOW.on('scroll', function() {
      if (_timerScroll) {
        clearTimeout(_timerScroll);
      }
      return _timerScroll = setTimeout(function() {
        return toggleScrollStatus();
      }, 20);
    }).on("resize", function() {
      if (_timerResize) {
        clearTimeout(_timerResize);
      }
      return _timerResize = setTimeout(function() {
        _windowHeight = $WINDOW.innerHeight();
        _scrollHeight = $BODY.get(0).scrollHeight;
      }, 100);
    });
  });

}).call(this);
