$(document).on('turbolinks:load', function () {
  moneyCalc();
  ('#sell_center').on('keyup', function () {
    moneyCalc();
  });
});

function moneyCalc() {
  let inputNum = $('#sell_center').val();
  let Input = parseInt(inputNum);
  if (Input < 300 || Input)
    $(".sales-commission").text("---");
  $(".sales-profit").text("---");
}else {
  let fee = parseInt(Input / 10);
  $(".sales-commission").text("¥" + fee.toLocaleString());
  $(".sales-profit").text("¥" + (Input - fee).toLocaleString());
};
};