$(function() {

  $(".async-rater").live('click', function(e) {
    var modification = 0;
    var that = $(this);
    var conc = that.parent().find('.inactive-rater');
    var virgin = true;

    that.addClass('inactive-rater').removeClass('async-rater').attr('name', that.attr('href')).attr('href', '');

    if (conc.length > 0) {
      conc.removeClass('inactive-rater').addClass('async-rater').attr('href', conc.attr('name')).attr('name', '');
      virgin = false;
    }
    if (that.hasClass('check-true-unselected')) {
      modification = 2;
      if (virgin) {
        modification = 1;
      }
      else {
        conc.addClass("check-false-unselected").removeClass('check-false')
          .attr('title', "Уменьшить рейтинг файла " + that.attr('rel'));
      }

      that.removeClass('check-true-unselected').addClass('check-true').attr('title', "Вы уже увеличили рейтинг файла " + that.attr('rel'));

    }
    else if (that.hasClass('check-false-unselected')) {
      modification = -2;
      if (virgin) {
        modification = -1;
      }
      else {
        conc.addClass("check-true-unselected").removeClass('check-true').attr('title', "Увеличить рейтинг файла " + that.attr('rel'));
      }

      that.removeClass('check-false-unselected').addClass('check-false').attr('title', "Вы уже уменьшили рейтинг файла " + that.attr('rel'));
    }

    that.parents('.file-row').each(function(i) {
      var rating_container = $(this).find("> .file-row-rating");
      var rating_value = parseInt(rating_container.find("> span").text().replace(/ /g,''));
      rating_value = rating_value + modification;

      if (rating_value < 0)
        rating_container.html("<span class='bad-rating'>"+rating_value+"</span>");
      else if (rating_value > 0)
        rating_container.html("<span class='rating'>+ "+rating_value+"</span>");
      else
        rating_container.html("<span>"+rating_value+"</span>");

    });
  })

});
