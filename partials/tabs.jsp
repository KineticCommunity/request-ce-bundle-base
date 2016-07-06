
<%@include file="../bundle/initialization.jspf" %>
<c:if test="${!(identity.anonymous)}">
    <section class="menu">
        <span class="scroller scroller-left hidden-lg"><i class="fa fa-chevron-left"></i></span>
        <span class="scroller scroller-right hidden-lg"><i class="fa fa-chevron-right"></i></span>
        <div class="scroll-wrapper">
          <ul class="nav nav-pills list">
              <c:set var="pageHome" value="${kapp.getForm('home')}" scope="page"/>
              <li id="home">
                  <a href="${bundle.kappLocation}">Home</a>
              </li>
              <li id="requests" class="submissiontable">
                  <a href="${bundle.kappLocation}?page=requests">My Requests</a>
              </li>
              <li id="approvals" class="submissiontable">
                  <a href="${bundle.kappLocation}?page=approvals">My Approvals</a>
              </li>
              <li id="closed" class="submissiontable">
                  <a href="${bundle.kappLocation}?page=closed">Closed Submissions</a>
              </li>
          </ul>
        </div>

    </section>
</c:if>
<style media="screen">
.scroll-wrapper {
  position:relative;
  margin:0 auto;
  overflow:hidden;
  padding:5px;
  height:50px;
}

.list {
  position:absolute;
  left:0px;
  top:0px;
  min-width:3000px;
  margin-left:12px;
  margin-top:0px;
}

.list li{
  display:table-cell;
  position:relative;
  text-align:center;
  cursor:grab;
  cursor:-webkit-grab;
  color:#efefef;
  vertical-align:middle;
}

.scroller {
  text-align:center;
  cursor:pointer;
  display:none;
  padding:7px;
  padding-top:11px;
  white-space:no-wrap;
  vertical-align:middle;
  background-color:#fff;
}

.scroller-right{
  float:right;
}

.scroller-left {
  float:left;
}
</style>
<script type="text/javascript">
$(document).ready(function() {
    var hidWidth;
    var scrollBarWidths = 50;

    var widthOfList = function() {
        var itemsWidth = 0;
        $('.list li').each(function() {
            var itemWidth = $(this).outerWidth();
            itemsWidth += itemWidth;
        });
        return itemsWidth;
    };

    var widthOfHidden = function() {
        return (($('.scroll-wrapper').outerWidth()) - widthOfList() - getLeftPosi()) - scrollBarWidths;
    };

    var getLeftPosi = function() {
        return $('.list').position().left;
    };

    var reAdjust = function() {
        if (($('.scroll-wrapper').outerWidth()) < widthOfList()) {
            $('.scroller-right').show();
        } else {
            $('.scroller-right').hide();
        }

        if (getLeftPosi() < 0) {
            $('.scroller-left').show();
        } else {
            $('.item').animate({
                left: "-=" + getLeftPosi() + "px"
            }, 'slow');
            $('.scroller-left').hide();
        }
    }

    reAdjust();

    $(window).on('resize', function(e) {
        reAdjust();
    });

    $('.scroller-right').click(function() {

        $('.scroller-left').fadeIn('slow');
        $('.scroller-right').fadeOut('slow');

        $('.list').animate({
            left: "+=" + widthOfHidden() + "px"
        }, 'slow', function() {

        });
    });

    $('.scroller-left').click(function() {

        $('.scroller-right').fadeIn('slow');
        $('.scroller-left').fadeOut('slow');

        $('.list').animate({
            left: "-=" + getLeftPosi() + "px"
        }, 'slow', function() {

        });
    });
});

</script>
