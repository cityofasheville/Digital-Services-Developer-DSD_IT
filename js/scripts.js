$('a[href^="#"]').click(function(e) {
    $('html,body').animate({ scrollTop: $(this.hash).offset().top - 50}, 1000);
    return false;
    e.preventDefault();
});


$(document).ready( function () {
// Hide the Description, Close Button and Link to Site
  $('<span class="closeMe">Close Project</span>').appendTo('.projectDesc');
  $('.projectDesc a, .projectDesc p, .projectDesc span').hide();
// What happens when you click the project button

  $('.project').click(
    function() {
      var newGet = $(this).html();
      var projectDisplay = $('.projectDisplay');

      if (projectDisplay.is(':empty')) {
      // Add the description section if empty
        $(newGet).hide().appendTo('.projectDisplay').fadeIn(500);
        $('.projectDisplay .projectDesc a, .projectDisplay .projectDesc p, .projectDisplay .projectDesc span').fadeIn(250);
      } else {
      // If description is not empty, fade out, empty and add new project description
        projectDisplay.fadeOut(500, function (){
          projectDisplay.empty().append(newGet).fadeIn(250);
          $('.projectDisplay .projectDesc a, .projectDisplay .projectDesc p, .projectDisplay .projectDesc span').fadeIn(250);
        })
      };

      $('html, body').animate({
          // scrollTop: $(".projectDisplay").position().top
          scrollTop: projectDisplay.offset().top - 200
      }, 750);


     $(document).on('click', '.closeMe',
        function() {
          projectDisplay.fadeOut(500);
        }
      );

    });

  var countClick = 0
  var secretClick = $('#secretClick');
  var hiddenProject = $('#project9');
  secretClick.click(function() {
    countClick++;
    if (countClick == 1) {
      hiddenProject.hide();
    } else if(countClick == 3){
        hiddenProject.show();
        countClick = 0;
    }    
})
});
// End of Project Click Function
