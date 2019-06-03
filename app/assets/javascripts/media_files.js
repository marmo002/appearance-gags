$(document).ready(function() {
  // bookingsSHow when click on Add button
  // get form for adding a new media file
  $("#addmedia-form-button").click(function(event){
    let bookingId = $(event.target).data("booking-id");
    let url = "/bookings/" + bookingId + "/media_files/new"
    console.log(bookingId);

    $.ajax({
      url: url,
      context: document.body
    }).done(function(response) {
      console.log(response);
      $('#mediafiles_add_form_container').html(response);
    });
  });

});//end document.ready
