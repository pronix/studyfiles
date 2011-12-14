//= require jquery
//= require jquery_ujs

$(document).ready(function(){

  //TODO переделать только для старых бразуеров
  $(".sidebar .top-10 li:even").each(function(){
    $(this).addClass("odd");
  });

  //раскрыть список предметов
  $('.expand-subjects-list').click(function(){
    $(this).closest('.university-short-info').find('.expanded-subjects-list').slideDown(400);
    $(this).closest('.subjects-list').css('display', 'none');
    return false
  });

  $('.open-modal').click(function(e) {
      e.preventDefault();
      var modalWindow = $(this).attr('rel');
      $("#"+modalWindow).modal({
        closeClass: 'close-modal',
        autoResize: true
      });
  });


  //Очищалка инпутов
  $('.clearer').click(function() {
    $(this).parent('.clearable-container').find('.clearable').val('');
  });

  $('#tops-tabs').tabs();

  //Закрывалка блоков
  $('.close').live('click', function(e) {
    e.preventDefault();
    container = $(this).parent('.closable').parent('.closable-container.with-bg');
    $(this).parent('.closable').remove();
    if ( container.children().length == 0) {
      container.css('background', 'none');
    }
  });

});
