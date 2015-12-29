<%@page pageEncoding="UTF-8" contentType="text/html" trimDirectiveWhitespaces="true"%>
<%@include file="../bundle/initialization.jspf" %>
<nav class="navbar navbar-default">
    <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse"
            data-target="${target}" aria-expanded="false">
            <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <c:if test="${kapp != null}">
                <a class="navbar-brand" href="${bundle.kappLocation}">
                    <c:if test="${not empty kapp.getAttribute('logo-url')}">
                    <img src="${kapp.getAttribute('logo-url').value}" alt="logo">
                    </c:if>
                    <c:if test="${empty kapp.getAttribute('logo-url')}">
                    <i class="fa fa-home"></i> ${text.escape(kapp.name)}
                    </c:if>
                </a>
            </c:if>
        </div>
        <c:if test="${kapp != null}">
          <div class="navbar-nav navbar-right launcher">
            <div class="button"> <i class="fa fa-th fa-2x"></i> </div>
            <div class="app-launcher" style="display:none;">
                <div class="apps">
                    <ul class="first-set">
                      <c:forEach items="${space.kapps}" var="kapp" begin="0" end="8">
                        <li><a href="#"><i class="fa fa-google-plus-square fa-4x"> </i>${kapp.name}</a></li>
                      </c:forEach>
                    </ul>
                </div>
              </div>
          </div>
        </c:if>


        <div class="collapse navbar-collapse" id="navbar-collapse-1">
            <ul class="nav navbar-nav navbar-right">
                <li>
                    <div class="btn-group navbar-btn">
                        <button class="btn btn-default"><i class="fa fa-user fa-fw"></i> ${text.escape(identity.username)}</button>
                        <button data-toggle="dropdown" class="btn btn-default dropdown-toggle"><span class="caret"></span></button>
                        <ul class="dropdown-menu">
                            <li><a href="#"><i class="fa fa-pencil fa-fw"></i> Edit Profile</a></li>
                            <li class="divider"></li>
                            <li><a href="${bundle.spaceLocation}/app/"><i class="fa fa-dashboard fa-fw"></i> Management Console</a></li>
                            <li class="divider"></li>
                            <li><a href="${bundle.spaceLocation}/app/logout"><i class="fa fa-sign-out fa-fw"></i> Logout</a></li>
                        </ul>
                    </div>
                </li>
            </ul>
            <div class="navbar-form navbar-right" role="search" style='margin-right:1em;'>
                <div class="form-group">
                    <input type="text" class="form-control typeahead" placeholder="Search forms...">
                </div>
            </div>
        </div>
    </div>
</nav>

<script>
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
</script>
