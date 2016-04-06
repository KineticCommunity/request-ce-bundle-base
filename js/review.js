(function($){
$(function() {
  $('body').on('click', '[data-review]', function(event) {
    event.preventDefault();
    // Get the container (parent) where the page elements are stored in the DOM.  We look for
    // a special attribute named 'data-page' that should be applied in the form.jsp or other
    // display jsp.
    var container = $(this).closest('[data-page]').parent();
    var selectedPage = container.children('[data-page="' + $(this).attr('data-review') + '"]');
    if (selectedPage.length > 0) {
      // Ensure all of the other pages are hidden and show the selected page.
      container.children().hide();
      selectedPage.show();
    } else {
      // Make the ajax call to load the new page, upon success we ensure all of the other
      // pages are hidden and we apppend the new page to show it.
      // TODO:  Eventually this should be calling some kind of Bundle.ajax helper that handles
      // authentication and errors.
      $.get($(this).attr('href') + '&embedded', function(data) {
          container.children().hide();
          container.append(data);
      });
    }
  });
});
})(jQuery);