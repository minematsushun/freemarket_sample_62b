$(document).on('turbolinks:load', function () {
  function appendOption(category) {
    var html = `<option value="${category.id}" data-category="${category.id}">${category.name}</option>`;
    return html;
  }
  // 子カテゴリー
  function appendChildrenBox(insertHTML) {
    var childSelectHtml = '';
    childSelectHtml = `
                      <select class='select-default' name='item[child]' id='child_category_edit'>
                        <option value='---' data-category='---'>---</option>
                          ${insertHTML}
                      </select>
                      `;
    $('.contents-box__category-section__category-box__tag#async-select-box').append(childSelectHtml);
  }

  // 孫カテゴリー
  function appendGrandchildBox(insertHTML) {
    var grandchildSelectHtml = '';
    grandchildSelectHtml = `
                      <select class='select-default' name='item[category_id]' id='grandchild_category_edit'>
                        <option value='---' data-category='---'>---</option>
                          ${insertHTML}
                      </select>
                      `;
    $('.contents-box__category-section__category-box__tag#async-select-box').append(grandchildSelectHtml);
  }

  function appendOptionsecond(delivery) {
    var html = `<option value="${delivery.id}" data-category="${delivery.id}">${delivery.name}</option>`;
    return html;
  }

  // 子デリバリー
  function appendDeliveryChildrenBox(insertHTML) {
    var deliverySelectHtml = '';
    deliverySelectHtml = `
                        <div class='contents-box__category-section__category-box__tag#async-select-boxsecond'>
                        <div class='contents-box__category-section__category-box__tag' id='parent_delivery_edit'>
                          配送の方法
                        <div class='form-require'>
                          必須
                        </div>
                          <select class='select-default' name='item[delivery_id]' id='child_delivery_edit'>
                          <option value='---' data-category='---'>---</option>
                            ${insertHTML}
                          </div>
                        </select>
                        </div>
                      `;
    $('.contents-box__category-section__category-box#async-select-boxsecond').append(deliverySelectHtml);
  }

  // 親カテゴリー欄
  $('#parent_categoryedit').on('change', function () {
    var parentCategory = document.getElementById('parent_categoryedit').value
    if (parentCategory != "---") {
      $.ajax({
        url: '/items/category_children',
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
        .fail(function (a, b, c) {
          console.log(a.status)
          console.log(b)
          console.log(c)
          alert('カテゴリー取得に失敗しました');
        })
    } else {
      $('#grandchild_category_edit').remove();
    }
  });

  // 子カテゴリー欄
  $('.contents-box__category-section__category-box__tag#async-select-box').on('change', '#child_category_edit', function () {
    var childId = $('#child_category_edit option:selected').data('category');
    if (childId != "---") {
      $.ajax({
        url: '/items/category_grandchildren',
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
      $('#grandchild_category_edit').remove();
    }
  });

  // デリバリー欄
  $('#parent_delivery_edit').on('change', function () {
    var parentDelivery = document.getElementById('parent_delivery_edit').value
    if (parentDelivery != "---") {
      $.ajax({
        url: '/items/delivery_children',
        type: 'GET',
        data: { name: parentDelivery },
        dataType: 'json'
      })
        .done(function (children_second) {
          $('#async-select-boxthird').empty();
          $('#delivery-method_edit').remove();
          $('#child_delivery_edit').remove();
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
      $('#grandchild_category_edit').remove();
    }
  });
});