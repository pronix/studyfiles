$(function() {

    $('.parent .expand').live('click',
      function() {
        var root = $(this).closest('.parent');
        var node = root.find("> .node");
        var expander = $(this);
        if ( node.is(":visible") ) {
          node.hide();
          if (expander.hasClass('blue-collapse')) {
            expander.removeClass('blue-collapse').addClass('blue-expand');
          }
        }
        else {
          node.show();
          if (expander.hasClass('blue-expand')) {
            expander.removeClass('blue-expand').addClass('blue-collapse')
          }
        }
        return false;
      }
    );

    $('.parent .expand.expand-all').live('click',
      function() {
        var root = $(this).closest('.parent');
        root.find('.node').show();
        root.find('.blue-expand').removeClass('blue-expand').addClass('blue-collapse').show();
      }
    );


    //Показать больше по клику на многоточие
    $('.show-more').click(function() {
      $(this).closest('.less-block').hide();
      $(this).closest('.with-more').find('.more-block').show();
    });

    $(".file-row").bind("contextmenu",function(e){
      if (e.which === 3) {
        e.preventDefault();
        var checkbox = $(this).closest('.file-row').find(' > .mover-checkbox');
        if ($(this).hasClass("selected")) {
          $(this).removeClass("selected");
          checkbox.prop("checked", false);
        }
        else
        {
          $(this).addClass("selected");
          checkbox.prop("checked", true);
        }
      }
      return false;
    });


    $(".action-link").live('click', function(e) {
        e.preventDefault();
        var where = $(this).attr('value');
        var form = $(this).closest('.mover-form');
        form.find("input[name=destination]").val(where);
        form.submit();
    });

});
