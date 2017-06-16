(function() {
  var fullpageOpts, init;

  fullpageOpts = {
    anchors: ["top", "green", "white", "blue", "gold", "black", "purple", 'yellow', 'sns', 'caution', 'about'],
    scrollOverflow: true,
    verticalCentered: false,
    menu: "#pagination",
    afterLoad: function() {
      return $('#section_sns, #section_caution, #section_about').css('height', 'auto');
    }
  };

  init = function() {
    return $('#mainTop').fullpage(fullpageOpts);
  };

  $(function() {
    init();
    $('.button-menu-open, .button-menu-close').on('click', function() {
      if (($BODY.hasClass('menu-opened')) && ($WINDOW.innerWidth() < 767)) {
        $HTML.css({
          overflow: "auto"
        });
        $BODY.css({
          overflow: "auto"
        });
        $.fn.fullpage.setAutoScrolling(false);
        return $WINDOW.on('scroll', function() {
          return true;
        }).scrollTop(0);
      } else {
        return $.fn.fullpage.setAutoScrolling(true);
      }
    });
    return $('.item-menu-sub > a, .item-menu-sub-inner > a').on('click', function() {
      return $BODY.removeClass('menu-opened');
    });
  });

}).call(this);
