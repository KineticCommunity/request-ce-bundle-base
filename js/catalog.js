/**
 * Grabs the dominant color from the logo and applies it to page
 * elements or falls back to whatever colors are passed in.
 * This only works for locally hosted images on the same domain due to security
 * constraints.
 */
   function setColors(primary, secondary, tertiary){
     try {
       if (primary == null || primary.length == 0) {
         var colorThief = new ColorThief();
         primary = colorThief.getColor($('a.navbar-brand img')[0]);
       }
       if (primary != null || primary.length > 0) {
         var rgb = "rgb(" + primary.join() + ")";
         /* Default link colors */
         $(':not(.card-title, ul.dropdown-menu) > a, .card .action a').css("color", rgb);
         $('a:hover,.card .action a:hover').css("color", "rgba(" + primary.join() +", 0.8)");
         /* Card Icon Color */ /* Navbar brand color */
         $('.card .fa, .navbar-default .navbar-brand').css("color", rgb);
         /* Card top border */
         $('.card .card-content').css("border-top-color", rgb);
         /* Menu Nav border color */
         $('.nav-pills > li.active > a, .nav-pills > li.active > a:hover,.nav-pills > li.active > a:focus').css("border-bottom", "0.4rem solid rgba(" + primary.join() + ",0.5)");
         $('.nav-pills > li > a:hover').css("color", rgb);
         $('.nav-pills > li > a:hover').css("border-bottom", "0.4rem solid " + rgb);
       }

       if (secondary != null || secondary.length > 0) {
         var rgb = "rgb(" + secondary.join() + ")";
         /* Form page header color */
         $('section > .page-header').css("background-color", rgb);
         /* Timeline Dot*/
         $('.timeline > ul > li:before').css('color', rgb);
       }
       if (tertiary != null || tertiary.length > 0) {
         var rgb = "rgb(" + tertiary.join() + ")";
         /* Default Button */
         $('form button,form .btn').css("background-color", rgb);
         /* Default Button:hover; */
         $('form button:hover,form .btn:hover').css("background-color", "rgba(" + tertiary.join() +", 0.8)");
         /* Custom Button styles */
         $("form button[data-button-type='custom']").css("border-color", rgb);
         $("form button[data-button-type='custom']").css("color", rgb);
         /* Previous Page Custom :hover*/
         $("form button[data-button-type='previous-page']:hover,form button[data-button-type='custom']:hover").css("background-color", "rgba(" + tertiary.join() +", 0.8)");
       }
     } catch (e){
      /*
      Degrade gracefully. Likely not a local image or a browser that
      *supports canvas
      */
    }
  }

  /**
   * Forms Search using Twitter Typeahead
  **/
  $(function(){
    var matcher = function(strs) {
      return function findMatches(query, callback) {
          var matches, substringRegex;
          matches = [];
          substrRegex = new RegExp(query, 'i');
          $.each(strs, function(i, str) {
            if (substrRegex.test(str)) {
              matches.push(str);
            }
          });
          callback(matches);
      };
    };
    var formNames = [];
    var forms = {};
    /* http://my.server.com/kinetic/default/app/api/v1/kapps/default/forms */
    $.get(window.bundle.apiLocation() + "/kapps/" + window.bundle.kappSlug() + "/forms", function( data ) {
      forms = data.forms;
      $.each(forms, function(i,val) {
        formNames.push(val.name);
        forms[val.name] = val;
      });
    });
    $('.navbar-form .typeahead').typeahead({
        highlight:true
      },{
        name: 'forms',
        source: matcher(formNames),
      }).bind('typeahead:select', function(ev, suggestion) {
        window.location.replace(window.bundle.kappLocation() + "/" + forms[suggestion].slug)
    });
  });

/**
 * Applies the Jquery DataTables plugin to a rendered HTML table to provide
 * column sorting and Moment.js functionality to date/time values.
 *
 * @param {String} tableId The id of the table element.
 * @returns {undefined}
 */
function submissionsTable (tableId) {
    $('#'+tableId).DataTable({
        dom: '<"wrapper">t',
        columns: [ { defaultContent: ''}, null, null, null, null ],
        columnDefs: [
            {
                render: function ( cellData, type, row ) {
                    var span = $('<a>').attr('href', 'javascript:void(0);');
                    var iso8601date = cellData;
                    $(span).text(moment(iso8601date).fromNow())
                            .attr('title', moment(iso8601date).format('MMMM Do YYYY, h:mm:ss A'))
                            .addClass('time-ago')
                            .data('toggle', 'tooltip')
                            .data('placement', 'top');
                    var td = $('#'+tableId+' td:contains('+cellData+')');
                    td.html(span);
                    return td.html();
                },
                targets: 'date'
            },
            {
                orderable: false,
                targets: 'nosort'
            }
        ]
    });
}
