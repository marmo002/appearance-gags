document.addEventListener("turbolinks:load", function(){

  $(function () {
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
  });

});
