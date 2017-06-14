(function() {
  var fullpageOpts, init;

  fullpageOpts = {
    anchors: ["top", "green", "white", "blue", "gold", "black", "purple", 'yellow', 'sns', 'caution', 'about'],
    fitToSection: true,
    verticalCentered: false,
    menu: "#pagination",
    afterLoad: function() {
      return $('#section_sns, #section_caution, #section_about').css('height', 'auto');
    },
    onLeave: function(index, next, dir) {
      if ((8 < next && next < 12)) {
        $.fn.fullpage.setFitToSection(false);
        return $.fn.fullpage.setAutoScrolling(false);
      } else {
        $.fn.fullpage.setFitToSection(true);
        return $.fn.fullpage.setAutoScrolling(true);
      }
    }
  };

  init = function() {
    return $('#mainTop').fullpage(fullpageOpts);
  };

  $(function() {
    init();
    return $('.item-menu-sub-inner > a').on('click', function() {
      return $BODY.removeClass('menu-opened');
    });
  });

}).call(this);
