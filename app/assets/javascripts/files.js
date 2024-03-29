$(function() {

    $('.parent .expand').live('click',
      function() {
        var root = $(this).closest('.parent');
        var node = root.find("> .node");
        var expander = $(this);
        if ( node.is(":visible") ) {
          node.hide();
          expander.closest('.file-row').removeClass("collapsed-block");
          if (expander.hasClass('blue-collapse')) {
            expander.removeClass('blue-collapse').addClass('blue-expand');
          }
        }
        else {
          node.show();
          expander.closest('.file-row').addClass("collapsed-block");
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
        root.find('.file-row').addClass('collapsed-block');
      }
    );


    //Показать больше по клику на многоточие
    $('.show-more').click(function() {
      $(this).closest('.less-block').hide();
      $(this).closest('.with-more').find('.more-block').show();
    });

    $(".slate").hide();

    $(".logged-in .my-files .file-row").live("contextmenu",function(e){
      if (e.which === 3) {
        e.preventDefault();
        var checkbox = $(this).closest('.file-row').find(' > .mover-checkbox');
        if ($(this).hasClass("selected")) {
          $(this).removeClass("selected");
          $(this).find('> .file-row-title .slate').show();
          checkbox.prop("checked", false);
          if ($('.selected').length == 0) {
            $(".file-row .slate").hide();
          }
        }
        else
        {
          $(this).addClass("selected");
          $(".file-row:not(.selected) .slate").show();
          $(this).find('> .file-row-title .slate').hide();
          checkbox.prop("checked", true);
        }
      }
      return false;
    });


    $(".logged-in .action-link").live('click', function(e) {
        e.preventDefault();
        var where = $(this).attr('value');
        var form = $(this).closest('.mover-form');
        form.find("input[name=destination]").val(where);
        form.submit();
    });


    $('.short-desc > a').live('click', function(e) {
       e.preventDefault();
       $(this).parent().hide();
       $(this).closest('.file-row-previews').find('.full-desc').show()
    });

});
