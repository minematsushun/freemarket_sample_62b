$(document).on('turbolinks:load', function () {
  $('#upload-image').on('change', function (e) {
    var preview = $(`#preview`)
    var reader = new FileReader();
    reader.onload = function (e) {
      $(preview).attr('src', e.target.result);
    }
    reader.readAsDataURL(e.target.files[0]);
  });
  $(document).on('click','.btn_delete', function() {
    $('.preview_edit').remove()
    $('#btn').remove();
  })
});