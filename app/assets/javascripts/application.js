//= require jquery
//= require jquery_ujs
//= require jquery.simplemodal-1.4.1
//= require custom-form-elements
//= require smartpaginator
//= require files
//= require async_rater
//= require jquery-ui
//= require modals
//= require uploader/universalUploader


//Оборачиваем каждые size блоков в wrap
function wrap(elements, wrap, size) {
  var x, i = 0, c = -1, l = elements.length, n = [];
  for(i; i < l; i++){
    (x = i % size) ? n[c][x] = elements[i] : n[++c] = [elements[i]];
  }
  l = n.length;
  for(i = 0; i < l; i++) {
    $(n[i]).wrapAll(wrap);
  }
}

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



  //Очищалка инпутов
  $('.clearer').live('click', function() {
    $(this).parent('.clearable-container').find('.clearable').val('');
  });


  //Табы для Топ-10 юзеров\универов
  $('#tops-tabs').tabs();


  //Закрывалка блоков
  $('.close').live('click', function(e) {
    e.preventDefault();
    $(this).closest('.file-row-previews').find('.short-desc').show();
    container = $(this).parent('.closable').parent('.closable-container.with-bg');
    $(this).closest('.closable').remove();
    if ( container.children().length == 0) {
      container.css('background', 'none');
    }
  });


  //Что бы была работа форма загрузки как в дизайне
  $('.fakeupload input[type=file]').live('change', function() {
    $(this).parent().find("input[name=fakeupload]").val($(this).val());
    $("#ajaxuploader").submit();
  });


  //По клику на чекбокс в новостях обновляем страницу
  $(".news-item form > .checkbox").live('click', function() {
      $(this).parent('form').submit();
  });


  //Превью папки\документа открываем в новом окне
  $('.popup-preview').click(function(e) {
     e.preventDefault();
     window.open ($(this).attr('href'), 'newwindow', config='height=500, width=900, toolbar=no, menubar=no')
  });



  //Просмотрщик файлов

  //Удаляем пустые элементы документа
  $('#document-contents > div:not(#top-pager) *').filter(function() {
        return $.trim($(this).text()) === ''
    }).remove();

  //И каждые 8 элементов оборачиваем в страницу
  wrap($('#document-contents > div:not(#top-pager) > *'), '<div class="page"></div>', 8);

  //И генерируем пагинацию по этим страницам
  $('#pager').smartpaginator({ totalrecords: $("div.page").length,
                              recordsperpage: 1,
                              datacontainer: 'document-contents > div',
                              dataelement: 'div.page',
                              length: 18,
                              theme: 'black' });

  //Внешние ссылки для управления пагинацией
  $("#prev").click(function() {$("#origin-prev").click();});
  $("#next").click(function() {$("#origin-next").click();});
  $(".beg").click(function() { $("#origin-first").click();})
  $(".end").click(function() { $("#origin-last").click();})

  //Разворачивающиеся вопросы в FAQ
  $(".faq-block li h4").click(function() {
    $(this).addClass('choosed').parent().find('.gray-box').show();
  })

  //Навигация по нажатию на ctrl
  $(document).keydown(function(e) {
        if (e.keyCode == 37 && e.ctrlKey) {
          document.location = $(".pagination a.previous_page").attr('href');
        }
        else if (e.keyCode == 39 && e.ctrlKey) {
          document.location = $(".pagination a.next_page").attr('href');
        }
  });

  prevXhr = null;

  $('.modal-window .search-form-container.without-button-search .search-form').live("ajax:beforeSend", function(evt, xhr) {
    prevXhr = xhr;
  });

  $('.modal-window .search-form-container.without-button-search .search-form input').live('keyup', function(){
    if ($(this).val().length <= 60) {
        if (prevXhr) {
          prevXhr.abort();
          console.log('Aborting previous xhr request');
        }
        $(this).parent().submit();
    }
  });

});
