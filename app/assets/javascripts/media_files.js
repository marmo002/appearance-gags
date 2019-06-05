// $(document).ready(function() {
//
// });//end document.ready

$(document).on('turbolinks:load', function() {
  // -------------------------------------
  // bookingsSHow when click on Add button
  // get form for adding a new media file
  // -------------------------------------
  $("#addmedia-form-button").click(function(event){
    let bookingId = $(event.target).data("booking-id");
    let url = "/bookings/" + bookingId + "/media_files/new"
    // console.log(bookingId);

    $.ajax({
      url: url,
      context: document.body
    }).done(function(response) {
      // console.log(response);
      $('#mediafiles_add_form_container').html(response);
    });
  });

  // -------------------------------------
  // bookingsShow when click on approval files button
  // get model form for adding uploads to mediaFile
  // -------------------------------------
  $('#approvalFilesModal').on('show.bs.modal', function (event) {
    const button = $(event.relatedTarget); // Button that triggered the modal
    const mediaFileId = button.data('media-file'); // Extract info from data-* attributes
    const url = "/media_files/" + mediaFileId + "/edit";
    const modal = $(this);
    console.log(mediaFileId);

    $.ajax({
      url: url,
      context: document.body
    }).done(function(response) {
        modal.find('#uploads_container').html(response);
        imageValidation();
    });
  });

});//turbolinks load
