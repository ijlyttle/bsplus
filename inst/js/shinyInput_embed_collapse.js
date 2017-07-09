$('.bsplus-shiny-collapse').on('show.bs.collapse', function () {

  var target = $(event.target);

  target.removeClass('fa-caret-right');
  target.addClass('fa-caret-down');

  console.log('show');
  // console.log(target.attr('class'));
});

$('.bsplus-shiny-collapse').on('hide.bs.collapse', function () {

  var target = $(event.target);

  target.removeClass('fa-caret-down');
  target.addClass('fa-caret-right');

  console.log('hide');
});
