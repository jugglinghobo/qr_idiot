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
    $("#new_image_input").on("change", "input", function() {
      var img_url = $(this).val();
      $("#new_image").html("<img id="+img_url+" src="+img_url+" />")
    });
  }

  return {
    initialize: function() {
      initClickHandler();
      initChangeListener();
    }
  };
}();

