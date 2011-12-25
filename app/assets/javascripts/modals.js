$(function() {
  //Открываем по ссылке с этим классом модальное окно с id = rel этой ссылки
  $('.open-modal').click(function(e) {
      e.preventDefault();
      var modalWindow = $(this).attr('rel');
      $("#"+modalWindow).modal({
        closeClass: 'close-modal',
        autoResize: true
      });
  });

  //Если нужен переход от одного модального к другому
  $(".popuper").live('click', function() {
    $.modal.close();
  })


  $(".modal-filter").live('click', function(e) {
    e.preventDefault();
    var that = $(this);
    var value = that.text();
    $.modal.close();
    if (that.hasClass('univer-filter')) {
      $("#univer_filter").val(value);
      $("#univer_filter_text").text(value);
    }
    else if (that.hasClass('subject-filter')) {

    }
  });

  $("#clear-subject-filter").live('click', function(e) {
    e.preventDefault();
    $("#univer_filter_text").text("Все ВУЗы");
    $("#univer_filter").val("");
  });




})
