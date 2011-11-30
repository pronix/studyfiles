$(document).ready(function(){
  $(".sidebar .top-10 li:even").each(function(){
    $(this).addClass("odd");
  });

  //раскрыть список предметов
  $('.slide-subjects').click(function(){
    $(this).parent().next('.university-subjects-full').slideDown(400);
	$(this).parent().next('.university-subjects-full').css('display', 'inline-block');
	$(this).parent().css('display', 'none');
        return false
  });
});
