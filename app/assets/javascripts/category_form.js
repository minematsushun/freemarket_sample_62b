$("#parent-form").on("change", function () {

  var parentValue = document.getElementById("parent-form").value;

  $.ajax({
    url: '/items/search',
    type: "GET",
    data: {
      parent_id: parentValue
    },
    dataType: 'json'
  })
})