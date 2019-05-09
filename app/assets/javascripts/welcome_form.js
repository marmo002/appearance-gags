function datePicker(conatinerId){
  // DATEPICKER OPTIONS
  $('#' + conatinerId).datetimepicker({
    viewMode: 'years',
    format: 'DD/MM/YYYY'
  });
}

$(function () {

  datePicker("user_dob_picker");

  document.addEventListener("turbolinks:load", function(){



  });//end turbolinks


});//end document.ready
