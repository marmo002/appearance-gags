document.addEventListener("turbolinks:load", function(){
  // ADD RIGHT PARAMS TO URL WHEN CLICK ON DASHBOARD TAB
  $('.dashboard_navigation a').click(function(e){
    let tabPage = this.id
    $('#' + tabPage).tab('show');
    // document.location.search = "?page=" + tabPage;

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
    $('#' + tabName).tab('show')
  }// get dashboard tab from params and activate accordingtly

  // VALIDATE IMAGE FILE INPUT WITH JS
  $('input:file').change( function(e){

    var card_box = $(this).closest('.card');
    var avatar_img = card_box.find('.card-img')[0];

    if (this.files.lenght > 0) {
      var input_file = this.files[0]
      var fileType = input_file["type"];
      var validImageTypes = ["image/gif", "image/jpeg", "image/png"];

      card_box.removeClass("border_errors");
      card_box.find('small').hide();

      if ($.inArray(fileType, validImageTypes) < 0) {
        card_box.toggleClass("border_errors");
        card_box.find('small').text('File is not an image');
        card_box.find('small').show();
      } else {
        var img_src = window.URL.createObjectURL(input_file)

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

  });

  document.body.addEventListener('ajax:success', function(event) {

    var detail = event.detail;
    var data = detail[0], status = detail[1], xhr = detail[2];
    var srcElement = event.target;
    var model = srcElement.attributes.action.value.split('/')[1].split('_')[0];
    console.log(event);
    console.log("-------------");
    console.log(model);

    var all_inputs = $(srcElement).find('.border_errors');
    for (var i = 0; i < all_inputs.length; i++) {
      $(all_inputs[i]).removeClass("border_errors");
    }

    var all_small_tags = $(srcElement).find('small.alert-text');
    for (var i = 0; i < all_small_tags.length; i++) {
      $(all_small_tags[i]).hide();
    }

    if (data.status == "success") {

      if (data.action) {

        go_to_next_form(srcElement)

      } else {

        // success message
        displayMessages( data.type, data.message);

        // empty passwordfields if they have text
        $('#change_pass_form input[type="password"]').val('');
      }

    } else {

      displayMessages( 'danger', 'Please fix errors');

      for (const elm_id of Object.keys(data)) {
          // console.log(elm_id, data[elm_id]);

          var small_tag = $(srcElement).find("#" + elm_id);
          if (elm_id == "avatar") {
            var input_tag = $(srcElement).find(".avatar-card");
          } else if (elm_id == "companylogo") {
            var input_tag = $(srcElement).find(".companylogo-card");
          }else {
            var input_tag = $(srcElement).find("#"+model+"_" + elm_id);
          }
          // console.log(input_tag);

          input_tag.toggleClass("border_errors");

          small_tag.text(data[elm_id]);
          small_tag.show();
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
