$(document).on('turbolinks:load', function () {
  $('#password-check').change(function() {
    if ($(this).prop('checked') ) {
      $('#password').attr('type','text');
    }else{
      $('#password').attr('type','password');
    }
  });
});