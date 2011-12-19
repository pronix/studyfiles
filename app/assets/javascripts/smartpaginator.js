(function($) {
    $.fn.extend({
        smartpaginator: function(options) {
            var settings = $.extend({
                totalrecords: 0,
                recordsperpage: 0,
                length: 10,
                next: '',
                prev: '',
                first: 'First',
                last: 'Last',
                go: 'Go',
                theme: 'green',
                display: 'double',
                initval: 1,
                datacontainer: '', //data container id
                dataelement: '', //children elements to be filtered e.g. tr or div
                onchange: null
            }, options);
            return this.each(function() {
                var currentPage = 0;
                var startPage = 0;
                var totalpages = parseInt(settings.totalrecords / settings.recordsperpage);
                if (settings.totalrecords % settings.recordsperpage > 0) totalpages++;
                var initialized = false;
                var container = $(this).addClass('pager').addClass(settings.theme);
                container.find('ul').remove();
                container.find('div').remove();
                container.find('span').remove();
                var dataContainer;
                var dataElements;
                if (settings.datacontainer != '') {
                    dataContainer = $('#' + settings.datacontainer);
                    dataElements = $('' + settings.dataelement + '', dataContainer);
                }
                var list = $('<ul/>');

                var btnPrev = $('<span id="origin-prev" class="prev"/>').text(settings.prev).click(function() { currentPage = parseInt(list.find('li a.active').text()) - 1; navigate(--currentPage); }).addClass('btn');

                var btnNext = $('<span id="origin-next" class="next"/>').text(settings.next).click(function() { currentPage = parseInt(list.find('li a.active').text()); navigate(currentPage); }).addClass('btn');

                var btnFirst = $("<span />").text("...").before($('<span id="origin-first"/>').before().text("1").click(function() { currentPage = 0; navigate(0); }));

                var btnLast = $('<span />').text("...").after($('<span id="origin-last"/>').text(settings.totalrecords).click(function() { currentPage = totalpages - 1; navigate(currentPage); }));

                //var inputPage = $('<input/>').attr('type', 'text').keydown(function(e) {
                //    if (isTextSelected(inputPage)) inputPage.val('');
                //    if (e.which >= 48 && e.which < 58) {
                //        var value = parseInt(inputPage.val() + (e.which - 48));
                //        if (!(value > 0 && value <= totalpages)) e.preventDefault();
                //    } else if (!(e.which == 8 || e.which == 46)) e.preventDefault();
                //});
                //var btnGo = $('<input/>').attr('type', 'button').attr('value', settings.go).addClass('btn').click(function() { if (inputPage.val() == '') return false; else { currentPage = parseInt(inputPage.val()) - 1; navigate(currentPage); } });
                container.append(btnPrev).append("<span class='pageinfo'>Страница/ы</span>").append(btnFirst).append(list).append(btnLast).append(btnNext).append($('<div/>').addClass('short'));
                if (settings.display == 'single') {
                    //btnGo.addClass('current');
                    //inputPage.addClass('current');
                }
                buildNavigation(startPage);
                if (settings.initval == 0) settings.initval = 1;
                currentPage = settings.initval - 1;
                navigate(currentPage);
                initialized = true;
                function showLabels(pageIndex) {
                    $("#pager-nav").find('span').remove();
                    var upper = (pageIndex + 1) * settings.recordsperpage;
                    if (upper > settings.totalrecords) upper = settings.totalrecords;
                    $("#pager-nav").append($('<span class="pageinfo"/>').text("Страница/ы       ").append($('<b/>').text(pageIndex * settings.recordsperpage + 1)))
                                             .append($('<span style="color: #aaaaaa"/>').text('/'))
                                             .append($('<span style="color: #aaaaaa"/>').append($('<b/>').text(settings.totalrecords)));
                }
                function buildNavigation(startPage) {
                    list.find('li').remove();
                    if (settings.totalrecords <= settings.recordsperpage) return;
                    for (var i = startPage; i < startPage + settings.length; i++) {
                        if (i == totalpages) break;
                        list.append($('<li/>')
                                    .append($('<a>').attr('id', (i + 1)).addClass(settings.theme).addClass('normal')
                                    .attr('href', 'javascript:void(0)')
                                    .text(i + 1))
                                    .click(function() {
                                        currentPage = startPage + $(this).closest('li').prevAll().length;
                                        navigate(currentPage);
                                    }));
                    }
                    showLabels(startPage);
                    //inputPage.val((startPage + 1));
                    list.find('li a').addClass(settings.theme).removeClass('active');
                    list.find('li:eq(0) a').addClass(settings.theme).addClass('active');
                    showRequiredButtons(startPage);
                }
                function navigate(topage) {
                    //make sure the page in between min and max page count
                    var index = topage;
                    var mid = settings.length / 2;
                    if (settings.length % 2 > 0) mid = (settings.length + 1) / 2;
                    var startIndex = 0;
                    if (topage >= 0 && topage < totalpages) {
                        if (topage >= mid) {
                            if (totalpages - topage > mid)
                                startIndex = topage - (mid - 1);
                            else if (totalpages > settings.length)
                                startIndex = totalpages - settings.length;
                        }
                        buildNavigation(startIndex); showLabels(currentPage);
                        list.find('li a').removeClass('active');
                        //inputPage.val(currentPage + 1);
                        list.find('li a[id="' + (index + 1) + '"]').addClass('active');
                        var recordStartIndex = currentPage * settings.recordsperpage;
                        var recordsEndIndex = recordStartIndex + settings.recordsperpage;
                        if (recordsEndIndex > settings.totalrecords)
                            recordsEndIndex = settings.totalrecords % recordsEndIndex;
                        if (initialized) {
                            if (settings.onchange != null) {
                                settings.onchange((currentPage + 1), recordStartIndex, recordsEndIndex);
                            }
                        }
                        if (dataContainer != null) {
                            if (dataContainer.length > 0) {
                                //hide all elements first
                                dataElements.css('display', 'none');
                                //display elements that need to be displayed
                                if ($(dataElements[0]).find('th').length > 0) { //if there is a header, keep it visible always
                                    $(dataElements[0]).css('display', '');
                                    recordStartIndex++;
                                    recordsEndIndex++;
                                }
                                for (var i = recordStartIndex; i < recordsEndIndex; i++)
                                    $(dataElements[i]).css('display', '');
                            }
                        }

                        showRequiredButtons();
                    }
                }
                function showRequiredButtons() {
                    if (totalpages > settings.length) {
                        if (currentPage > 0) { $(".prev").removeClass('current'); }
                        else { $(".prev").addClass('current'); }
                        if (currentPage > settings.length / 2 - 1) { $(".beg").removeClass("current"); btnFirst.show(); }
                        else { $(".beg").addClass('current'); btnFirst.hide(); }

                        if (currentPage == totalpages - 1) { $(".next").addClass('current'); }
                        else $(".next").removeClass('current');
                        if (totalpages > settings.length && currentPage < (totalpages - (settings.length / 2)) - 1) { $(".end").removeClass("current"); btnLast.show(); }
                        else { $(".end").addClass('current'); btnLast.hide(); };
                    }
                    else {
                        $(".beg").addClass('current');
                        $(".prev").addClass('current');
                        $(".next").addClass('current');
                        $(".end").addClass('current');
                        btnFirst.hide();
                        btnLast.hide();
                    }
                }
                function isTextSelected(el) {
                    var startPos = el.get(0).selectionStart;
                    var endPos = el.get(0).selectionEnd;
                    var doc = document.selection;
                    if (doc && doc.createRange().text.length != 0) {
                        return true;
                    } else if (!doc && el.val().substring(startPos, endPos).length != 0) {
                        return true;
                    }
                    return false;
                }
            });
        }
    });
})(jQuery);
