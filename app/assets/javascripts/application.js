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
//= require froala_editor.min.js
//= require moment
//= require moment-timezone-with-data
//= require tempusdominus-bootstrap-4
//= require_tree .

document.addEventListener("turbolinks:load", function(){

  $('#release-text-area').froalaEditor()

  // ADD INPUT FILE IMAGE NAME TO IMAGE LABEL
  var customInputField = $('.custom-file-input');
  for (var i = 0; i < customInputField.length; i++) {
    $(customInputField[i]).change(function(){
      // console.log(this);
      var imageName = this.value;
      $(this).next().text(imageName);
    });
  }


 });
