$(document).ready(function() {
  Application.initialize();
});

var Application = function() {

  var initClickHandler = function() {
    $("#agb_checkbox").on("change", function(e) {
      $("#upload_image").slideToggle()
    });
  }

  var initChangeListener = function() {
    $("#new_image_input").on("keyup", "input", function() {
      $("#loading").toggle(true);
      $("#new_image").toggle(false);
      var img_url = $(this).val();
      var loaded_image = $('<img />').load( function(){
        $("#loading").toggle(false);
        $("#new_image").html(loaded_image);
        $("#new_image").toggle(true);
      }).error(function() {
        $("#new_image").toggle(false);
      }).attr('src', img_url);
    });
  }

  return {
    initialize: function() {
      initClickHandler();
      initChangeListener();
    }
  };
}();

