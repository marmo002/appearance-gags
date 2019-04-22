document.addEventListener("turbolinks:load", function(){
  var url_string = window.location.href;
  var url = new URL(url_string);
  var tabName = url.searchParams.get("page");

  if (tabName) {
    $('#' + tabName).tab('show')
  }


  function displayErrors(type, message){
    var errorMessages = $('<div id="main-alerts" class="alert alert-' + type + ' flash-alerts" role="alert">'+ message +'</div>');
    $('body').prepend(errorMessages);

    setTimeout(function(){ $('#main-alerts').remove() }, 4200);

  }

  // RELEASE TAB SIGNED button
  $('#release-form').on("ajax:success", function(event, data, status, xhr){
    let releaseParagraph = $('<p class="text-secondary d-inline-block">You already accepted our release</p>');
    $('#release-form input[type="submit"]').remove();
    $('#release-form').append( releaseParagraph );
    $('#release-form').append( releaseParagraph );

    displayErrors( 'primary', 'Profile updated successfully');
  });

});
