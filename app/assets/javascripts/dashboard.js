function getCountryStates(countryid){
  $.ajax({
    url: "/geo_states/" + countryid,
    context: document.body
  }).done(function(response) {
    $("#states-list").html('');
    // iterate throught response
    // $("#states-list").append('<option>'+ response+'</option>');

  });
}

function getStateCities(stateid){
  $.ajax({
    url: "http://api.geonames.org/childrenJSON?geonameId=" + countryid + "&username=getagrip",
    context: document.body
  }).done(function(response) {
    // $('#recording_date_container').html(response);
    console.log(response);
  });
}

function locationSetup(containerid){
  const locationInput = $("#" + containerid);

  locationInput.change(function(e){
    let itemId = $(this).find(':selected').data('geonameid');

    getCountryStates(itemId);

  });
}

document.addEventListener("turbolinks:load", function(){
  // getCountryStates("6252001");

  locationSetup("user_country");

  /*/ -------------------------------------
  // ADD RIGHT PARAMS TO URL WHEN CLICK ON DASHBOARD TAB
  // ------------------------------------- */
  $('.dashboard_navigation a').click(function(e){
    let tabPage = this.id;
    $('#' + tabPage).tab('show');

    window.history.pushState("string", "Title", "?page=" + tabPage );
  });// ADD RIGHT PARAMS TO URL WHEN CLICK ON DASHBOARD TAB

  // GET NEXT URL FROM SUBMENU
  function go_to_next_form(srcElement){
    let nextUrl = $(srcElement).attr("data-next");
    document.location = nextUrl;
  }// GET NEXT URL FROM SUBMENU

  // Get main menu item activated when on their page
  var url_string = window.location.href;
  var url = new URL(url_string);
  var tabName = url.searchParams.get("page");

  if (tabName) {
    $('#' + tabName).tab('show');
  }// get dashboard tab from params and activate accordingtly

  // VALIDATE IMAGE FILE INPUT WITH JS
  $('input:file').change( function(e){
    var card_box = $(this).closest('.card');
    var avatar_img = card_box.find('.card-img')[0];

    if (this.files.length > 0) {

      var input_file = this.files[0];
      var fileType = input_file["type"];
      var validImageTypes = ["image/gif", "image/jpeg", "image/png"];
    // console.log(input_file.name);
      $(this).next().text(input_file.name);
      card_box.removeClass("border_errors");
      card_box.find('small').hide();

      if ($.inArray(fileType, validImageTypes) < 0) {
        card_box.toggleClass("border_errors");
        card_box.find('small').text('File is not an image');
        card_box.find('small').show();
      } else {
        var img_src = window.URL.createObjectURL(input_file);

        if ( avatar_img ) {
          avatar_img.src = img_src;
        } else {
          $('<div/>', {
            class: 'col-md-4 pl-3 align-self-center'
          })
          .append("<img src='" + img_src + "' class='card-img'>")
          .prependTo( card_box.children('.row') );
        }
      }

    }//check if any files -- end

  });//input:file change

  $('[data-js-file-upload]').on("ajax:beforeSend", function(event){
    var detail = event.detail;
    var xhr = detail[0], options = detail[1];

    let nextUrl = $(this).data('next');
    let inputField = $(this).find('input[type=file]');

    if (inputField.val().length < 1) {
      event.preventDefault();
      document.location = nextUrl;
    }
  });

  // -------------------------------------
  // GET AJAX RESPONSE ON ALL AJAX CALLS AND
  // RETURN ERRORS OR SUCCESSFULL MESSAGES
  // ------------------------------------- */
  document.body.addEventListener('ajax:success', function(event) {
    var detail = event.detail;
    var data = detail[0], status = detail[1], xhr = detail[2];
    var srcElement = event.target;
    var model = srcElement.attributes.action.value.split('/')[1].split('_')[0];

    // clear red-border from input with error
    var all_inputs = $(srcElement).find('.border_errors');
    for (var i = 0; i < all_inputs.length; i++) {
      $(all_inputs[i]).removeClass("border_errors");
    }

    // hide small error tag from bellow inputs
    var all_small_tags = $(srcElement).find('small.alert-text');
    for (var i = 0; i < all_small_tags.length; i++) {
      $(all_small_tags[i]).hide();
    }

    if (data.model == "welcome-form") {
      go_to_next_form(srcElement)
    }else if (data.model == "booking") {
      // success message
      window.location = data.booking_path;
      // displayMessages( data.type, data.message);

    } else {
      // success message
      displayMessages( data.type, data.message);
      // empty passwordfields if they have text
      $('#change_pass_form input[type="password"]').val('');
    }

  });
  // ajax cycle for user dashboard profile form

  document.body.addEventListener('ajax:error', function(event) {
    console.log("something wrong happend");
    var detail = event.detail;
    var data = detail[0], status = detail[1], xhr = detail[2];
    var srcElement = event.target;
    var model = srcElement.attributes.action.value.split('/')[1].split('_')[0];
    console.log(data);

    displayMessages( 'danger', 'Please fix errors');

    for (const elm_id of Object.keys(data)) {
      var small_tag = $(srcElement).find("#" + elm_id);

      if (elm_id == "avatar") {
        var input_tag = $(srcElement).find(".avatar-card");
      } else if (elm_id == "companylogo") {
        var input_tag = $(srcElement).find(".companylogo-card");
      } else {
        var input_tag = $(srcElement).find("#"+model+"_" + elm_id);
      }

      input_tag.toggleClass("border_errors");
      small_tag.text(data[elm_id]);
      small_tag.show();
    }

    if (model === 'bookings') {

      let bookingMenuidList = $('#booking-list-tab a').map( function(e){
        return this.id.replace('_link', '');
      }).get();

      const errorsTitles = Object.keys(data);

      for (var i = 0; i < bookingMenuidList.length; i++) {
        let anchorId = bookingMenuidList[i]
        console.log(anchorId);
        console.log("---------");

        if (errorsTitles.includes(anchorId)) {
          $( "#" + anchorId + "_link" ).tab('show');
          break;
        }

      }



    }


  });
  // ajax cycle for user dashboard profile form


  function displayMessages(type, message){
    var errorMessages = $(
      '<div id="main-alerts" class="alert alert-' + type + ' flash-alerts alert-dismissible fade show" role="alert">'+ message +'</div>'
    );
    $('body').prepend(errorMessages);

    setTimeout(function(){ $('#main-alerts').remove() }, 4200);

  }

  // RELEASE TAB SIGNED BUTTON
  $('#release-form').on("ajax:success", function(event){
    let releaseParagraph = $('<p class="text-secondary d-inline-block">Released signed. Thank you</p>');
    $('#release-form input[type="submit"]').remove();
    $('#release-form').prepend( releaseParagraph );
    // $('#release-form').append( releaseParagraph );
  });

}); //turbolinks end
