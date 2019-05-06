document.addEventListener("turbolinks:load", function(){
  //////////////////////////////////////
  //    Reveal password on click
  //////////////////////////////////////
  function changeInputType(){
    const passButton = $('#show-pass-button');

    passButton.click(function(e){
      let passInput = $('#pass-field');
      if (passInput[0].type === "password"){
        passInput[0].type = "text";
        $('#pass-confirmation')[0].type = "text";
        passButton.text('Hide');
      } else {
        passInput[0].type = "password";
        $('#pass-confirmation')[0].type = "password";
        passButton.text('Show');

      }
    });
  }

  changeInputType();

  // const userSearchInput =
  $("#user_search_form").keyup(function(e){
    console.log(e);

    var keySearch = e.currentTarget.value;
    console.log("------------");
    console.log(keySearch.length);

    if (keySearch.trim().length === 0) {
      document.location = "/users";
    }

    if (keySearch.trim().length > 0) {

      let clearButton = document.getElementById('clear_button');
      console.log(clearButton);
      if (!clearButton) {
        let temporaryClearButton = "<a id='clear_button' class='btn btn-outline-primary ml-2' href='/users'>Clear</a>";
        $('#users_search_form').append(temporaryClearButton);
      }

      $.ajax({
        url: "/users?utf8=✓&search=" + keySearch,
        method:'get',
        dataType: 'JSON'
      }).done(function(response) {
        const users_lists_container = $("#users_lists_container");
        users_lists_container.html("");

        // console.log(response);
        // console.log(response.length);
        $('#loaded').text(response.length);

        response.map(function(user) {
          if (user["signed_release"]) {
            var signedRelease ='<span class="badge badge-success">Signed release</span>';
          } else {
            var signedRelease ='<span class="badge badge-danger">Pending release</span>';
          }

          let contentString = '<div class="card mb-3">'+
          '<div class="card-body">' +

          '<h5 class="card-title mb-0">'+ user["userName"] +'</h5>' +
          '<p class="card-text">'+ signedRelease + '</p>' +
          '<h6 class="card-subtitle mb-3 text-muted">'+ user["email"] + '</h6>' +
          '<h6 class="card-subtitle mb-3 text-muted">'+ user["phone"] + '</h6>' +
          '<a href="/users/'+ user["userId"] + '" class="stretched-link">User profile</a>' +
          '</div>' +
          '</div>';

          // console.log(contentString);
          users_lists_container.append(contentString);
        });//response map end

      });
    } // if statment search term not empty

  });//user_search_form end

});//turbolinks end
