$(document).on('turbolinks:load', function () {
  moneyCalc();
  $(function () {
    (document).on('keyup', '#sell.center', function () {
      moneyCalc();
    });
  });

  function moneyCalc() {
    let inputNum = $('#sell_center').val();
    let Input = parseInt(inputNum);
    if (Input < 300 || Input > 9999999 || inputNum == "") {
      $(".sales-commission").text("-");
      $(".sales-profit").text("-");
    } else {
      let fee = parseInt(Input / 10);
      $(".sales-commission").text("¥" + fee.toLocaleString());
      $(".sales-profit").text("¥" + (Input - fee).toLocaleString());
    };
  };
});