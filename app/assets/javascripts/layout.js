
$(document).ready(function() {

    var $busy = $("<span>").addClass('busy').text("Loading...");

    var showProfile = function(id) {
        $.fn.SimpleModal({
            width: 600,
            model: 'modal-ajax',
            title: 'User profile',
            param: {
                url: '/profile/'+id
            }
        }).addButton('Oki doki!', 'btn primary', function() { this.hideModal(); }).showModal();
    };

    setTimeout(function() {
        var counter = $('#countdown');

        $(function() {
            $('.chart').easyPieChart({
                size: 60,
                barColor: '#666',
                trackColor: '#bbb',
                scaleColor: '#aaa',
                animate: 500
            }).show();
        });

        if (counter && counter.length) {
            counter.countdown({
                date: counter.data('timestamp'),
                render: function(data) {
                    var days  = data.days ? '<div>' + this.leadingZeros(data.days, 2) + ' <span>days</span></div>' : '',
                        years = data.years ? '<div>' + this.leadingZeros(data.years, 4) + ' <span>years</span></div>' : '';

                    $(this.el).html(years + days + "<div>" + this.leadingZeros(data.hours, 2) + " <span>hrs</span></div><div>" + this.leadingZeros(data.min, 2) + " <span>min</span></div><div>" + this.leadingZeros(data.sec, 2) + " <span>sec</span></div>");
                }
            });
        }
    }, 1500);

    $('#teams').on('click', '.tabs li', function(e) {
        var $me = $(this),
            tab = $me.data('tab'),
            selected = $me.hasClass('selected');

        // hide currently opened tab

        $('#teams')
            .find('div.menu:visible').hide().end()
            .find('li.selected').removeClass('selected');

        if (!selected) {

            var $team = $me.closest('.team'),
                $menu = $team.find('div.menu[data-menu='+tab+']'),
                height = $menu.height();

            $me.addClass('selected');
            $menu.css({'opacity': 0, 'height': 0}).show().animate({opacity: 1, height: height}, 100);

            // members are loaded dynamically

            if (tab === 'members') {
                $menu.empty().append($busy);
                $.ajax({
                    url: '/members?id=' + $me.data('id'),
                    dataType: 'json',
                    success: function(json) {

                        var members = json.members,
                            $table  = $("<table>"),
                            counter = 0, tr;

                        for (var user, distance, i=0, n=members.length; i<n; i++) {
                            user = members[i].user;
							distance = members[i].distance || 0;

                            if (counter++ % 2 === 0) {
                                tr = $("<tr>");
                                $table.append(tr);
                            }
                            tr.append($("<td>").append($("<a>", {
                                'href': '#',
                                'data-user': user.id,
                                'class': 'icon icon-member member',
                                'title': 'Last synchronization: '+ (user.last_sync_date || '').split('T')[0]
                            }).text(user.name)).append($("<span>").text(distance + ' km')));
                        }
                        setTimeout(function() {
                            $menu.empty().append($table).css('height', 'auto');
                            $menu.find('a.member').tipsy({
                                gravity: $.fn.tipsy.autoNS,
                                opacity: 0.8,
                                delayIn: 200,
                                html:   true
                            });
                        }, 300);
                    }
                });
            }
        }
    });

    $('#profile').click(function() {
        showProfile($(this).data('user'));
    });

    $('#teams, #wrapper .fame').on('click', '.menu a.member', function() {
        showProfile($(this).data('user'));
    });

    $('#wrapper').on('click', '#comment_cancel_action', function() {
        $('#comment').empty();
        return false;
    });

    $('#wrapper .blog').on('click', '.article-nav ul.right li', function(ev) {
        var date = $(this).data('published'),
            chid = $(this).data('chid');

        $.get('/blogs/'+chid+'/'+date+'/'+($(this).hasClass('prev') ? 'prev' : 'next'), function(data) {
            var $blog = $('#wrapper .blog');
            $blog.animate({opacity: 0}, function() {
                $blog.html(data).animate({opacity: 1});
            });
        });
    });
    setTimeout(function() {
        $($('#teams .tabs li[data-tab=milestones]')[0]).trigger('click');
    },500);
});
