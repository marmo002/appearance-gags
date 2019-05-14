//NUMBER LEFT TABS
function numberBookingMenu(){
  let bookingBullets = $('.booking-form-index');
  for (var i = 0; i < bookingBullets.length; i++) {
    bookingBullets[i].innerText = i + 1;
  }
}

//when user selects
function enableNextOnChange(){
  $('input[type=radio]').change(function(e){
    console.log(e);
    console.log("----------------------");
    let tabContainer = $(this).parents('.tab-pane');
    tabContainer.attr('data-permit', true);
    let nextButton = $(tabContainer).children('button');
    console.log(nextButton);
    nextButton.attr("disabled", false);
  });
}

//GOT TO NEXT TAB WHEN CLICK ON BUTTON
function bookingsNextTab(){
  $(".bookings-next").on('click', function(e){
    e.preventDefault()
    const parentContainer =  $(this).parents('.tab-pane')[0];
    console.log("next button parent container");
    console.log($(parentContainer).attr('data-permit'));
    if ( $(parentContainer).attr('data-permit') ) {
      let listTabId =  $(this).parent().attr('id');
      let nextTab = $('a[href="#'+listTabId+'"]').next();
      console.log( nextTab );
      if (nextTab) {
        $( nextTab ).tab('show')
      } else {
        console.log("bookings js: No next tab was found");
      }
    } else {
      console.log("Please select an option");
    }
  });
}

// CHECK IF THERE IS A RECORDING DATE
function setUpDatesDivs(hidden_field, embeddedDatePicker, placeHolder) {
  var recordingValue = $('#' + hidden_field).val();

  if (recordingValue.length > 0) {
    var readyDate = new Date(recordingValue);
    var recordingDate = readyDate.toDateString();
    var recordingTime = readyDate.toLocaleTimeString();
    var recordingText = recordingDate + " at " + recordingTime;

    //hide date picker
    $('#' + embeddedDatePicker).hide();

    //Add picked date to title, and toggle display block
    $('#' + placeHolder).text(recordingText);
    $('#' + placeHolder).parent().removeClass('d-none');
  } else {
    console.log('no recording date');
    console.log(recordingValue);
  }
}

$(function () {

  //GOT TO NEXT TAB WHEN CLICK ON BUTTON
  bookingsNextTab();

  //number bookings left menu
  numberBookingMenu();

  enableNextOnChange()

  document.addEventListener("turbolinks:load", function(){

    //GOT TO NEXT TAB WHEN CLICK ON BUTTON
    bookingsNextTab();

    //number bookings left menu
    numberBookingMenu();

    enableNextOnChange()

      // DATEPICKER OPTIONS
      $('#recording-datepicker').datetimepicker({
          format: 'L',
          disabledDates: [
              moment("4/25/2019"),
              new Date(2019, 04 - 1, 30),
              "11/22/2013 00:53"
          ],
          minDate: Date.now(),
          daysOfWeekDisabled: [0, 6]
      });


  });//end turbolinks


});//end document.ready
