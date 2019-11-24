$(document).on('turbolinks:load', function () {
  moneyCalc();
  ('#sell_center').on('keyup', function () {
    moneyCalc();
  });
});

function moneyCalc() {
  let inputNum = $('#sell_center').val();
}