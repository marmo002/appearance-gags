//GOT TO NEXT TAB WHEN CLICK ON BUTTON
function bookingsNextTab(){
  $(".bookings-next").on('click', function(e){
    e.preventDefault()
    let listTabId =  $(this).parent().attr('id');
    let nextTab = $('a[href="#'+listTabId+'"]').next();
    console.log( nextTab );
    if (nextTab) {
      $( nextTab ).tab('show')
    } else {
      console.log("bookings js: No next tab was found");
    }
  });
}

$(function () {

  //GOT TO NEXT TAB WHEN CLICK ON BUTTON
  bookingsNextTab();

  document.addEventListener("turbolinks:load", function(){

    //GOT TO NEXT TAB WHEN CLICK ON BUTTON
    bookingsNextTab();

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
