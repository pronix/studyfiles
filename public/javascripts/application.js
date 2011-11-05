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
  //регистраций и авторизация модальным окном
  $( "#registration-modal" ).dialog({
	  autoOpen: false,
	  closeText: '',
	  position: 'top',
	  width: 747,
	  height: 467
	});
	$( ".sign-in-up a" ).click(function() {
			$( "#registration-modal" ).dialog( "open" );
			return false;
	});
	$( ".close-modal" ).click(function() {
			$( "#registration-modal" ).dialog( "close" );
			return false;
	});
});
