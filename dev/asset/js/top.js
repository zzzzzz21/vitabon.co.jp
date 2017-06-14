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
    return $('.item-menu-sub-inner > a').on('click', function() {
      return $BODY.removeClass('menu-opened');
    });
  });

}).call(this);
