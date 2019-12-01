$(document).on('turbolinks:load', function () {
  function appendOption(category) {
    var html = `<option value="${category.id}" data-category="${category.id}">${category.name}</option>`;
    return html;
  }

  $('#parent_category_edit').on('change', function () {
    var 
  });

  // 子カテゴリー欄
  $('#parent_category_edit').on('change', function () {
    var parentCategory = document.getElementById('#parent_category_edit').value
    if (parentCategory != "---") {

      $.ajax({
        url: 'category_children',
        type: 'GET',
        data: { name: parentCategory },
        dataType: 'json'
      })
        .done(function (children) {
          $('#child_category_edit').remove();
          $('#grandchild_category_edit').remove();
          var insertHTML = '';
          children.forEach(function (child) {
            insertHTML += appendOption(child);
          });
          appendChildrenBox(insertHTML);
        })
        .fail(function () {
          alert('カテゴリー取得に失敗しました');
        })
    } else {
      $('#child_category_edit').remove();
      $('#grandchild_category_edit').remove();
    }
  });

  // 孫カテゴリー欄
  $('.contents-box__category-section__category-box__tag#async-select-box').on('change', '#child_category_edit', function () {
    var childId = $('#child_category_edit option:selected').data('category');
    if (childId != "---") {
      $.ajax({
        url: 'category_grandchildren',
        type: 'GET',
        data: { child_id: childId },
        dataType: 'json'
      })
        .done(function (grandchildren) {
          if (grandchildren.length != 0) {
            $('#grandchild_category_edit').remove();
            var insertHTML = '';
            grandchildren.forEach(function (grandchild) {
              insertHTML += appendOption(grandchild);
            });
            appendGrandchildBox(insertHTML);
          }
        })
        .fail(function () {
          alert('カテゴリー取得に失敗しました');
        })
    } else {
      $('#grandchild_category_wdit').remove();
    }
  });

  // デリバリー欄
  $('#delivery_category').on('change', function () {
    var parentDelivery = document.getElementById('delivery_category').value
    if (parentDelivery != "---") {
      $.ajax({
        url: 'delivery_children',
        type: 'GET',
        data: { name: parentDelivery },
        dataType: 'json'
      })
        .done(function (children_second) {
          var insertHTML = '';
          children_second.forEach(function (children_second) {
            insertHTML += appendOptionsecond(children_second);
          });
          appendDeliveryChildrenBox(insertHTML);
        })
        .fail(function () {
          alert('カテゴリー取得に失敗しました');
        })
    } else {
      $('#grandchild_category').remove();
    }
  });
});