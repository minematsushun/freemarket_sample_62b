$(document).on('turbolinks:load', function () {
  $('#upload-image').on('change', function (e) {
    var preview = $(`#preview`)
    var reader = new FileReader();
    reader.onload = function (e) {
      $(preview).attr('src', e.target.result);
      var btn_wrapper = $('<div class="btn_wrapper"><div class="btn_edit">編集</div><div class="btn_delete">削除</div></div>');
      $('#btn').append(btn_wrapper);
    }
    $(document).on('click','.btn_delete', function() {
      $('#upload-image').val('');
      $(preview).remove()
      $('#btn').remove();
    })
    reader.readAsDataURL(e.target.files[0]);
  });
});