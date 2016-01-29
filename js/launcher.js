$(document).ready(function(){

      var scroll = false;
      var launcherMaxHeight = 400;
      var launcherMinHeight = 396;

      // Mousewheel event handler to detect whether user has scrolled over the container
      $('.apps').bind('mousewheel', function(e){
            if(e.originalEvent.wheelDelta /120 > 0) {
              // Scrolling up
            }
            else{
                // Scrolling down
                if(!scroll){
                    $(".second-set").show();
                    $('.apps').css({height: launcherMinHeight}).addClass('overflow');
                    scroll =true;
                    $(this).scrollTop(e.originalEvent.wheelDelta);
                }
            }
        });

      // Scroll event to detect that scrollbar reached top of the container
      $('.apps').scroll(function(){
        var pos=$(this).scrollTop();
        if(pos == 0){
            scroll =false;
            $('.apps').css({height: launcherMaxHeight}).removeClass('overflow');
            $(".second-set").hide();
        }
      });

      // Click event handler to show more apps
      $('.apps .more').click(function(){
        $(".second-set").show();
        $(".apps").animate({ scrollTop: $('.apps')[0].scrollHeight}).css({height: 396}).addClass('overflow');
      });

      // Click event handler to toggle dropdown
      $(".button").click(function(event){
        event.stopPropagation();
        $(".app-launcher").toggle();
      });

      $(document).click(function() {
        //Hide the launcher if visible
        $('.app-launcher').hide();
        });

        // Prevent hiding on click inside app launcher
        $('.app-launcher').click(function(event){
            event.stopPropagation();
        });

});

  // Resize event handler to maintain the max-height of the app launcher
  $(window).resize(function(){
    $('.apps').css({maxHeight: $(window).height() - $('.apps').offset().top});
  });