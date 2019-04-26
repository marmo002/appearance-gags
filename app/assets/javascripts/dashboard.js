document.addEventListener("turbolinks:load", function(){
  // get dashboard tab from params and activate accordingtly
  var url_string = window.location.href;
  var url = new URL(url_string);
  var tabName = url.searchParams.get("page");

  if (tabName) {
    $('#' + tabName).tab('show')
  }
  // get dashboard tab from params and activate accordingtly

  document.body.addEventListener('ajax:success', function(event) {

    var detail = event.detail;
    var data = detail[0], status = detail[1], xhr = detail[2];
    console.log(detail);
    console.log("--------------");
    console.log("data: ");
    console.log(data);
    console.log("--------------");
    console.log("status: ");
    console.log(status);
    console.log("--------------");
    console.log("xhr: ");
    console.log(xhr);
    console.log("--------------");

    var all_inputs = $('.border_errors');
    for (var i = 0; i < all_inputs.length; i++) {
      $(all_inputs[i]).removeClass("border_errors");
    }

    var all_small_tags = $('small');
    for (var i = 0; i < all_small_tags.length; i++) {
      $(all_small_tags[i]).hide();
    }

    if (data.status == "success") {
      displayErrors( data.type, data.message);
    } else {

      displayErrors( 'danger', 'Please corrent errors');

      for (const elm_id of Object.keys(data)) {
          console.log(elm_id, data[elm_id]);
          var small_tag = $("#" + elm_id);
          if (elm_id == "avatar") {
            var input_tag = $(".avatar-card");
          } else {
            var input_tag = $("#user_" + elm_id);
          }

          input_tag.toggleClass("border_errors");

          small_tag.text(data[elm_id]);
          small_tag.show();
      }

    }


  });
  // ajax cycle for user dashboard profile form


  function displayErrors(type, message){
    var errorMessages = $('<div id="main-alerts" class="alert alert-' + type + ' flash-alerts" role="alert">'+ message +'</div>');
    $('body').prepend(errorMessages);

    setTimeout(function(){ $('#main-alerts').remove() }, 4200);

  }

  // RELEASE TAB SIGNED BUTTON
  $('#release-form').on("ajax:success", function(event, data, status, xhr){
    let releaseParagraph = $('<p class="text-secondary d-inline-block">You already accepted our release</p>');
    $('#release-form input[type="submit"]').remove();
    $('#release-form').append( releaseParagraph );
    $('#release-form').append( releaseParagraph );

    displayErrors( 'primary', 'Profile updated successfully');
  });

});
