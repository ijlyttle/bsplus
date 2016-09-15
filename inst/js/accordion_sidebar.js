$('.panel-collapse-leader').on('show.bs.collapse', function () {

  /* This function is called whenver an element of class
   * 'panel-collapse-leader' has been expanded, or shown.
   */

  /*  finds the closest parent with the class name 'panel' */
  var panel = $(this).closest('.panel');

  /* changes out the class of the panel (changes color) */
  panel.removeClass(panel.attr('class-inactive'));
  panel.addClass(panel.attr('class-active'));

  /* find and show the element that follows this panel */
  var panel_id = panel.attr('id');
  var follower = $('#'.concat(panel_id).concat('-follow'));

  follower.collapse('show');

});

$('.panel-collapse-leader').on('hide.bs.collapse', function () {

  var panel = $(this).closest('.panel');

  panel.removeClass(panel.attr('class-active'));
  panel.addClass(panel.attr('class-inactive'));

  /* find and show the element that follows this panel */
  var panel_id = panel.attr('id');
  var follower = $('#'.concat(panel_id).concat('-follow'));

  follower.collapse('hide');

});



