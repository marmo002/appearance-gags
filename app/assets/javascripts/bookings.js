const list = [
 "list-audio-hardware",
 "list-video-hardware",
 "list-computer",
 "list-browser",
 // "list-internet",
 "list-test"
]

//SHOW TAB ON LEFT SUBMENU
//ONLY IF TAB-PANE HAS DATA-PERMIT == TRUE
function subMenuRestrictions(elements){
  $(elements).on('click', function (e) {
    e.preventDefault();
    let tabPaneId = this.href.split('#')[1];
    // console.log(tabPaneId);
    let tabPane = $('#' + tabPaneId);
// console.log(tabPane.attr('data-permit'));

    if ( tabPane.attr('data-permit') ) {
      $(this).tab('show');
    }
  })
}

//NUMBER ALL LEFT TABS ON SUB-MENU
function numberBookingMenu(){
  //get spans from html where number will be placed
  let bookingBullets = $('.booking-form-index');
  for (var i = 0; i < bookingBullets.length; i++) {
    bookingBullets[i].innerText = i + 1 + ".";
  }
}

// GET RECORDING DATE FORM
function getRecordingForm(){
 $.ajax({
   url: "/booking_recording_form",
   context: document.body
 }).done(function(response) {
   $('#recording_date_container').html(response);
 });
 console.log("got recording form");
}

// GET TEST DATE FORM
function getTestForm(){
 $.ajax({
   url: "/booking_test_form",
   context: document.body
 }).done(function(response) {
   $('#test_date_container').html(response);
 });
 console.log("got test form");
}

//Removes menus and tab-panes from virtual booking
function inStudioFormSetUp(){

  // iterate throught const list. Setted up on top
  for (var i = 0; i < list.length; i++) {
   $("a[href='#" + list[i] + "']").remove();
   $("#" + list[i]).remove();
   // console.log(list[i]);
  }
  //number left menu items accordingtly
  numberBookingMenu();

  // GET RECORDING DATE FORM
  getRecordingForm();

}

//recreates elements for virtual booking
function virtualFormSetUp(){

  //get complete booking sub-menu
  $.ajax({
    url: "/booking_menu",
    context: document.body
  }).done(function(response) {
    $('#booking-list-tab').html(response);
     //number left menu items accordingtly
     numberBookingMenu();
     subMenuRestrictions('#booking-list-tab a');
  });

  // iterate throught const list. Setted up on top
  for (var i = 0; i < list.length; i++) {
   // $("a[href='#" + list[i] + "']").remove();
   $("#" + list[i]).remove();
   // console.log(list[i]);
  }
    // get second container in the list (.tab-pane)
    // and append the nodes we cloned on load
    let tabPane = $('.tab-pane')[1];
    // $(tabPane).after(element7);
    $(tabPane).after(element6);
    // $(tabPane).after(element5);
    $(tabPane).after(element4);
    $(tabPane).after(element3);
    $(tabPane).after(element2);
    $(tabPane).after(element1);

    // GET TEST DATE FORM
    getTestForm();

    //GOT TO NEXT TAB WHEN CLICK ON NEXT BUTTON
    bookingsNextTab();

    //LEFT MENU RESTRICTIONS
    subMenuRestrictions('#booking-list-tab a');

    //number bookings left menu
    numberBookingMenu();

    enableNextOnChange()
    enableNxtOnSpeedTest();

}

function enableNxtButton(elemt, status="enable"){
  let tabContainer = $(elemt).parents('.tab-pane');
  console.log(tabContainer);
  let nextButton = $(tabContainer).find('button');

  if (status == "enable") {
    tabContainer.attr('data-permit', true);
    nextButton.attr("disabled", false);
  }else{
    tabContainer.attr('data-permit', false);
    nextButton.attr("disabled", true);
  }
}

//when user selects option, enable next button
function enableNextOnChange(){
  $('input[type=radio]').change(function(e){
    let showType = this.value;
    // console.log(showType);
    switch (showType) {
      case 'in-studio':
        inStudioFormSetUp();
        console.log("in-studio choosen");
        break;
      case 'virtual':
        virtualFormSetUp();
        console.log("virtual choosen");
        break;
      default:
        console.log("select is neither in-studio nor virtual");
    }

    enableNxtButton(this);
  });
}

//when users fills speed test
function enableNxtOnSpeedTest(){
  const uploadInput = $('#booking_hardware_requirements_upload');
  let speedInputs = uploadInput.parents('.card-body').find('input');

  speedInputs.keyup(function(e){
    let allFilled = 0;

    for (var i = 0; i < speedInputs.length; i++) {
      let textLength = speedInputs[i].value.length;
      if (textLength < 1 ) {
        allFilled ++;
      }
    }

    if (allFilled === 0) {
      enableNxtButton(this);
    } else {
      enableNxtButton(this, "disable");
      console.log("some inputs are empty");
    }

  });

}

//GOT TO NEXT TAB WHEN CLICK ON NEXT BUTTON
function bookingsNextTab(){
  $(".bookings-next").on('click', function(e){
    e.preventDefault()
    const parentContainer =  $(this).parents('.tab-pane')[0];
// console.log(parentContainer);
// console.log($(parentContainer).attr('data-permit'));
    if ( $(parentContainer).attr('data-permit') ) {
      let listTabId =  $(parentContainer).attr('id');
      let nextTab = $('a[href="#'+listTabId+'"]').next();
// console.log( nextTab );
      if (nextTab) {
        $( nextTab ).tab('show')
        if ( window.innerWidth > 768 ) {
          var scrollPoint = 86;
        } else {
          var scrollPoint = 400;
        }
        $("html, body").animate({ scrollTop: scrollPoint }, "slow");
        // return true;
      } else {
        console.log("bookings js: No next tab was found");
      }
    } else {
      console.log("Parent doesn hava data-permit");
    }
  });
}

// CHECK IF THERE IS A RECORDING DATE
function setUpDatesDivs(hidden_field, embeddedDatePicker, placeHolder) {
  var recordingValue = $('#' + hidden_field).val();

  if (recordingValue && recordingValue.length > 0) {
    var readyDate = new Date(recordingValue);
    var recordingDate = readyDate.toDateString();
    var recordingTime = readyDate.toLocaleTimeString();
    var recordingText = recordingDate + " at " + recordingTime;

    //hide date picker
    $('#' + embeddedDatePicker).hide();

    //enable next button
    let elementInside = "#" + hidden_field;
    enableNxtButton(elementInside);

    //Add picked date to title, and toggle display block
    $('#' + placeHolder).text(recordingText);
    $('#' + placeHolder).parent().removeClass('d-none');
  } else {
    console.log('no recording date');
    console.log(recordingValue);
  }
}

//iterates throught all elements on class
//and calls back enableNxtButton per element
function enablePersonalTabNextButtons(buttonClass){
  let buttons = $(buttonClass);

  for (var i = 0; i < buttons.length; i++) {
    enableNxtButton(buttons[i]);
  }
}

$(function () {

  //GOT TO NEXT TAB WHEN CLICK ON NEXT BUTTON
  bookingsNextTab();

  //LEFT MENU RESTRICTIONS
  subMenuRestrictions('#booking-list-tab a');

  //number bookings left menu
  numberBookingMenu();

  enableNextOnChange();
  enableNxtOnSpeedTest();

  document.addEventListener("turbolinks:load", function(){

    //GOT TO NEXT TAB WHEN CLICK ON BUTTON
    bookingsNextTab();

    //LEFT MENU RESTRICTIONS
    subMenuRestrictions('#booking-list-tab a');

    //number bookings left menu
    numberBookingMenu();

    enableNextOnChange();
    enableNxtOnSpeedTest();


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
