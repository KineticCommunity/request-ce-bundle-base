/**
 * On load grabs the dominant color from the logo and applies it to page
 * elements.
 * This only works for locally hosted images on the same domain due to security
 * constraints.
 */
$(window).load(function() {
   try {
     var colorThief = new ColorThief();
     var color = colorThief.getColor($('a.navbar-brand img')[0]);
     var rgb = "rgb(" + color[0] + "," + color[1]+ "," + color[2] + ")";
     $('.nav-pills > li.active > a').css("border-bottom", "4px solid " + rgb);
     $('.card-content .fa').css("color", rgb);
   } catch (e){
    /*
    Degrade gracefully. Likely not a local image or a browser that
    *supports canvas
    */
  }

  /* Typeahead Search for Forms */
  var substringMatcher = function(strs) {
  return function findMatches(q, cb) {
    var matches, substringRegex;
    // an array that will be populated with substring matches
    matches = [];
    // regex used to determine if a string contains the substring `q`
    substrRegex = new RegExp(q, 'i');
    // iterate through the pool of strings and for any string that
    // contains the substring `q`, add it to the `matches` array
    $.each(strs, function(i, str) {
      if (substrRegex.test(str)) {
        matches.push(str);
      }
    });
    cb(matches);
  };
};

var forms = ['Form A','Form B', 'Form C'];

$('.typeahead').typeahead({
  hint: true,
  highlight: true,
  minLength: 1
},
{
  name: 'states',
  source: substringMatcher(forms),
  prefetch: '${bundle.kappLocation}'
  templates: {
    notfound: '<p>No forms found matching search</p>'
  }
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
