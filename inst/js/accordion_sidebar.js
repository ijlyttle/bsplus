function bsplus_collpase_validator(target, collapse) {

  /* target    element that initiated the event
   * collapse  element that is acting on the event
   *
   * we want to return true/false on the question:
   *
   *  does the target (or any parent of the target) have an attribute
   *  called 'data-parent' with a value the same as the id of a parent of
   *  the collapse?
   *
   *  [name=”value”] - attribute selector
   *  .closest()
   */

  var query_id_parent = $(target).closest('[data-parent]').attr('data-parent');

  if (typeof query_id_parent === "undefined"){
    //console.log("data-parent undefined");
    //console.log(false);
    return false;
  }

  //console.log(query_id_parent);
  var elem_parent = $(collapse).closest(query_id_parent);

  //console.log(elem_parent);
  var result = elem_parent.length > 0;

  //console.log(result);
  return result;
}

$('.panel-collapse-leader').on('show.bs.collapse', function () {

  /* This function is called whenver an element of class
   * 'panel-collapse-leader' has been expanded, or shown.
   */

  var is_valid = false
  if (typeof event !== 'undefined') {
    is_valid = bsplus_collpase_validator(event.target, this);
  } else {
    //console.log("x40(b): event undefined ");
    is_valid = true
  }

  if (is_valid){
    /*  finds the closest parent with the class name 'panel' */
    var panel = $(this).closest('.panel');

    /* changes out the class of the panel (changes color) */
    panel.removeClass(panel.attr('class-inactive'));
    panel.addClass(panel.attr('class-active'));

    /* find and show the element that follows this panel */
    var panel_id = panel.attr('id');
    var follower = $('#'.concat(panel_id).concat('-follow'));

    follower.collapse('show');
  }


});

$('.panel-collapse-leader').on('hide.bs.collapse', function () {

  var is_valid = false
  if (typeof event !== 'undefined') {
    is_valid = bsplus_collpase_validator(event.target, this);
  } else {
    //console.log("x66(c): event NOT DEFINED");
    is_valid = true
  }

  if (is_valid){

    var panel = $(this).closest('.panel');

    panel.removeClass(panel.attr('class-active'));
    panel.addClass(panel.attr('class-inactive'));

    /* find and show the element that follows this panel */
    var panel_id = panel.attr('id');
    var follower = $('#'.concat(panel_id).concat('-follow'));

    follower.collapse('hide');
  }

});



