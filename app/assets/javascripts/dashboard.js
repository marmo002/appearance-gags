
function displayMessages(type, message){
  var errorMessages = $(
    '<div id="main-alerts" class="alert alert-' + type + ' flash-alerts alert-dismissible fade show" role="alert">'+ message +'</div>'
  );
  $('body').prepend(errorMessages);

  setTimeout(function(){ $('#main-alerts').remove() }, 4200);

}

function getMediaFilesIndex(bookingId){

}

// VALIDATE IMAGE FILE INPUT WITH JS
function imageValidation(validImageTypes = ["image/gif", "image/jpeg", "image/png"]){
  $('input:file').change( function(e){
    var card_box = $(this).closest('.card');
    var avatar_img = card_box.find('.card-img')[0];

    if (this.files.length > 0) {
      console.log(this.files);
      var input_file = this.files;
      // var validImageTypes = ["image/gif", "image/jpeg", "image/png"];

      card_box.removeClass("border_errors");
      card_box.find('small').hide();
      let isImage = "";

      for (var i = 0; i < input_file.length; i++) {
        let fileType = input_file[i]["type"];
        let fileName = $(this).next().text();

        if (i === 0) {
          $(this).next().text(input_file[i].name);
        } else {
          $(this).next().text(fileName + ", " + input_file[i].name);
        }

        if ($.inArray(fileType, validImageTypes) < 0) {
          isImage = "wrong_file";
        } else {

          var img_src = window.URL.createObjectURL(input_file[i]);

          if ( avatar_img ) {
            avatar_img.src = img_src;
          } else {
            if (fileType === "application/pdf") {
              console.log("it's pdf");
              newUrl = '/pdf-placeholder.png';
              $('<div/>', {
                class: 'col-md-4 pl-3 align-self-center'
              })
              .append("<img src='" + newUrl + "' class='card-img'>")
              .prependTo( card_box.children('.row') );
            } else {
              $('<div/>', {
                class: 'col-md-4 pl-3 align-self-center'
              })
              .append("<img src='" + img_src + "' class='card-img'>")
              .prependTo( card_box.children('.row') );

            }
          }
        }

      }//end for loop

      if (isImage === "wrong_file") {
        card_box.toggleClass("border_errors");
        card_box.find('small').text('File is not an image');
        card_box.find('small').show();
      }

    }//check if any files -- end

  });//input:file change
}//imageValidation

function getCountryStates(countryid){
  let userStates = $("#user_state");
  // console.log(userStates);
  userStates.attr('placeholder', "Loading...");

  $.ajax({
    url: "/geo_states/" + countryid,
    context: document.body
  }).done(function(data){
    $("#user_state").val('');
    $("#user_state").attr('disabled', false);
    $("#user_city").attr('disabled', false);
    $("#user_state").attr('placeholder', "Province/State Region");
    $("#states-list").html('');
    // iterate throught response
    for (var i = 0; i < data.length; i++) {
      $("#states-list").append('<option data-geoid="'+ data[i]['geo_id'] +'">'+ data[i]['name'] +'</option>');
    }
  });
}

function getCountryStatesCompany(countryid){
  $("#user_company_province").attr('placeholder', "Loading...");

  $.ajax({
    url: "/geo_states/" + countryid,
    context: document.body
  }).done(function(data) {
    $("#user_company_province").attr('placeholder', "State/Province Region");
    $("#user_company_province").val('');
    $("#user_company_province").attr('disabled', false);
    // $("#user_city").attr('disabled', false);
    $("#company-states-list").html('');
    // iterate throught response
    for (var i = 0; i < data.length; i++) {
      $("#company-states-list").append('<option data-geoid="'+ data[i]['geo_id'] +'">'+ data[i]['name'] +'</option>');
    }
  });
}

function statesSetup(containerid){
  const locationInput = $("#" + containerid);

  locationInput.change(function(e){
    let itemId = $(this).find(':selected').data('geonameid');
    //get states for country and add it to state input
    if (containerid === "user_country") {
      getCountryStates(itemId);
    } else {
      getCountryStatesCompany(itemId);
    }

  });
}

// load texteditor
// for text areas
function tinyMCEload() {
  tinymce.remove();
  tinymce.init({
    selector: '#release-text-area',
    height: 400,
    plugins: [
      "advlist autolink link image lists charmap print preview hr anchor pagebreak",
      "searchreplace wordcount visualblocks visualchars code fullscreen insertdatetime media nonbreaking",
      "save table contextmenu directionality emoticons template paste textcolor"
    ]
  });

  
}

statesSetup("user_country");
statesSetup("user_company_country");


$(document).on("turbolinks:load", function(){

  statesSetup("user_country");
  statesSetup("user_company_country");

  tinyMCEload();

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
  imageValidation();

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
  // -------------------------------------
  document.body.addEventListener('ajax:success', function(event) {
    var detail = event.detail;
    var data = detail[0], status = detail[1], xhr = detail[2];
    var srcElement = event.target;

    // Clean input[file] value
    // on successfull update
    let inputFiles = $('input:file');
    for (let i = 0; i < inputFiles.length; i++) {
      $(inputFiles[i]).val("");
    }

    // var model = srcElement.attributes.action.value.split('/')[1].split('_')[0];
    $('.modal').each(function(){
        $(this).modal('hide');
    });

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
    } else if (data.model == "booking") {
      console.log(data);
      // success message
      window.location = data.booking_path;
      // displayMessages( data.type, data.message);
    } else if (data.model == "media_file") {

      const url = "/bookings/" + data.booking + "/media_files";

      $.ajax({
        url: url,
        context: document.body
      }).done(function(response) {
        $('#media_files_info').html(response);
        getFilesUploadForm();
      });

      displayMessages( data.type, data.message);
      //hide add-approval-files modal on successfull ajax

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
    var model = $(srcElement).data('model-name');
    console.log(event);
    console.log("-------model: -----------");
    console.log(model);

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

    } else if (data.model == "media_file") {
      // displayMessages( data.type, data.message);
      // $('#add_media_file').modal('hide');
    }
    //model bookings
  });
  // ajax cycle for user dashboard profile form

  // RELEASE TAB SIGNED BUTTON
  $('#release-form').on("ajax:success", function(event){
    let releaseParagraph = $('<p class="text-secondary d-inline-block">Released signed. Thank you</p>');
    $('#release-form input[type="submit"]').remove();
    $('#release-form').prepend( releaseParagraph );
    // $('#release-form').append( releaseParagraph );
  });

}); //turbolinks end
