function datePicker(conatinerId){
  // DATEPICKER OPTIONS
  const dobPicker = $('#' + conatinerId);
  const pickedDate = dobPicker.find('input[type=text]').val();
  // console.log(pickedDate);

  dobPicker.datetimepicker({
    viewMode: 'years',
    format: 'YYYY/MM/DD'
    // maxDate: Date.now()
  });

  if (pickedDate) {
    let setDate = new Date(pickedDate);
    dobPicker.datetimepicker('defaultDate', setDate);
  }

  $('#user_dob').focus(function(e){

    dobPicker.datetimepicker('show');
  });
}

// when click on not applicable,
// it will disable form and
// next button will take user to release
function disableForm(isChecked, originalUrl){


}


function disableFormOnClick(){
  const notApplicableButton = $('#company-notapplication');
  const companyLegalFieldset = $('#company-legal-fieldset');
  const currentForm = companyLegalFieldset.parent('form');
  const originalNextUrl = currentForm.data('next');
  const subURL = '/welcome_release';

  const fromServer = notApplicableButton.prop('checked');

  if (fromServer) {
    companyLegalFieldset.prop("disabled", true);
    currentForm.attr('data-next', subURL);
  } else {
    companyLegalFieldset.prop("disabled", false);
    currentForm.attr('data-next', originalNextUrl);
  }

  notApplicableButton.change(function(e){
    var isChecked = notApplicableButton.prop('checked');

    if (isChecked) {
      companyLegalFieldset.prop("disabled", true);
      currentForm.attr('data-next', subURL);
    } else {
      companyLegalFieldset.prop("disabled", false);
      currentForm.attr('data-next', originalNextUrl);
    }
  })//onchange function end
}


$(function () {

  datePicker("user_dob_picker");

  disableFormOnClick();

  document.addEventListener("turbolinks:load", function(){

    datePicker("user_dob_picker");

    disableFormOnClick();


  });//end turbolinks


});//end document.ready
