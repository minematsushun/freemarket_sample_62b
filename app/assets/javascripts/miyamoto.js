$(document).on('turbolinks:load', function () {
  $('#upload-image').on('change', function (e) {
    var preview = $(`#preview`)
    var reader = new FileReader();
    reader.onload = function (e) {
      $(preview).attr('src', e.target.result);
      $('.preview_edit').remove()
    }
    reader.readAsDataURL(e.target.files[0]);
  });
});