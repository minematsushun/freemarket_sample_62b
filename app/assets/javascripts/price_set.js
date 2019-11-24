$(document).on('turbolinks:load', function () {
  money();
  ('#sell_center').on('keyup'function () {
    money();
  });
}