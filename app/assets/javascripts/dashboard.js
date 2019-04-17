document.addEventListener("turbolinks:load", function(){
  var url_string = window.location.href;
  var url = new URL(url_string);
  var tabName = url.searchParams.get("page");
    if (tabName) {
      $('#' + tabName).tab('show')
    }

 });
