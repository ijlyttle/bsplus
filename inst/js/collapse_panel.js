$('.panel-collapse-leader').on('show.bs.collapse', function () {

  /* This function is called whenver an element of class
   * 'panel-collapse-leader' has been expanded, or shown.
   */

  /*  finds all elements with a class name based
   *  the id attribute of this variable.
   *
   *  then, it expands that element
   */
  var id = $(this).attr('id');
  var follower = $('.'.concat(id).concat('-follower'));
  follower.collapse('show');

  /*  finds the closest parent with the class name 'panel'
   *
   *  then, it changes the class of that panel from
   *  'panel-success' to 'panel-primary'
   */
  var panel = $(this).closest('.panel');
  panel.addClass("panel-success");
  panel.removeClass("panel-primary");

});

$('.panel-collapse-leader').on('hide.bs.collapse', function () {

  /* This function is the converse of the 'show.bs.collapse' function
   */

  var id = $(this).attr('id');
  var follower = $('.'.concat(id).concat('-follower'));
  follower.collapse('hide');

  var panel = $(this).closest('.panel');
  panel.addClass("panel-primary");
  panel.removeClass("panel-success");

});
