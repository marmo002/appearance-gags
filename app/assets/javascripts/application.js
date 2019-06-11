// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require jquery3
//= require popper
//= require bootstrap-sprockets
//= require moment
//= require moment-timezone-with-data
//= require tempusdominus-bootstrap-4
//= require_tree .


/*
 * jQuery autoResize (textarea auto-resizer)
 * @copyright James Padolsey http://james.padolsey.com
 * @version 1.04
 */

// autoresize all textareas
function textAreaAutoheight(){
  $("textarea").each(function(textarea) {
    $(this).height(this.scrollHeight);
  });
}

function textareaOnChange(){
  $("textarea").keyup(function(event){
    $(this).height("auto");
    $(this).height(this.scrollHeight);
  });
}

// autoresize all textareas
// textAreaAutoheight();
// textareaOnChange();

$(document).on('turbolinks:load', function () {

  // autoresize all textareas
  textAreaAutoheight();
  textareaOnChange();

  // $('#release-text-area').froalaEditor();

  tinymce.init({

    selector: '#release-text-area',
    height: 300,
    plugins: [
      "advlist autolink link image lists charmap print preview hr anchor pagebreak",
      "searchreplace wordcount visualblocks visualchars code fullscreen insertdatetime media nonbreaking",
      "save table contextmenu directionality emoticons template paste textcolor"
    ]

  });

  if (document.location.pathname == "/admin") {
    var currentPage = "/dashboard";
  } else {
    var currentPage = document.location.pathname;
  }

  const mainMenuAnchors = $('#main-menu a');

  for (var i = 0; i < mainMenuAnchors.length; i++) {
    let currentValue = mainMenuAnchors[i].attributes[1].nodeValue;

    if (currentValue && currentValue === currentPage) {

      $(mainMenuAnchors[i]).addClass('active');
    }

  }

});//turbolinks end
