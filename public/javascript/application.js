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
      $("#error").toggle(false);
      $("#new_image").toggle(false);
      var img_url = $(this).val();
      if(img_url !== "") {
        var loaded_image = $('<img />').load( function(){
          $("#loading").toggle(false);
          $("#error").toggle(false);
          $("#new_image").html(loaded_image);
          $("#new_image").toggle(true);
        }).error(function() {
          $("#loading").toggle(false);
          $("#new_image").toggle(false);
          $("#error").toggle(true);
        }).attr('src', img_url);
      };
    });

    $("#new_image_input").on("focusout", "input", function() {
      $("#loading").toggle(false);
      $("#error").toggle(false);
    })
  }

  return {
    initialize: function() {
      initClickHandler();
      initChangeListener();
    }
  };
}();

