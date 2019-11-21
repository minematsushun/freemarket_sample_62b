$(document).on('turbolinks:load', function () {
  function appendOption(category) {
    var html = `<option value="${category.id}" data-category="${category.id}">${category.name}</option>`;
    return html;
  }

  function appendChildrenBox(insertHTML) {
    var childSelectHtml = '';
    childSelectHtml = `<select class='category' name='item[child]' id='child_category'>
                        <option value='---' data-category='---'>---</option>
                          ${insertHTML}
                      </select>`;
    $('.contents-box__category-section__category-box__tag#async-select-box').append(childSelectHtml);
  }

  $('#parent_category').on('change', function () {
    var parentCategory = document.getElementById('parent_category').value;
    if (parentCategory != "---") {
      $.ajax({
        url: 'category_children',
        type: 'GET',
        data: { parent_name: parentCategory },
        dataType: 'json'
      })
        .done(function (children) {
          $('#child_category').remove();
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
      $('#grandchild_category').remove();
    }
  })
})