$.fn.extend({
    animateCss: function (animationName) {
        var animationEnd = 'webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend';
        this.addClass('animated ' + animationName).one(animationEnd, function() {
            $(this).removeClass('animated ' + animationName);
        });
    }
});

$(function () {
    //BEGIN MENU SIDEBAR
    $('#sidebar').css('min-height', '100%');
    function collapseSidebar() {
        $('body').addClass('left-side-collapsed').removeClass('sidebar-colors');        
        $('#sidebar .menu-scroll').css('overflow', 'initial');
    }
    function showSidebar() {        
        $('body').removeClass('left-side-collapsed');
        $(".navbar-static-side").animateCss('fadeIn');
        $('#sidebar .menu-scroll').css('overflow', 'hidden');
    }
    $(window).on("resize", function () {
        if ($(this).width() < 768) {
            $('div.sidebar-collapse').addClass('collapse');  // animated slideOutLeft
        } else {
            $('div.sidebar-collapse').removeClass('collapse');
            $('div.sidebar-collapse').css('height', 'auto');
        }
    }).resize();

    $("#menu-toggle").click(function(){
        if ($('body').hasClass('left-side-collapsed')) {
            showSidebar();
        } else {
            collapseSidebar();            
        }
    });
    //$('#sidebar').hover(showSidebar,collapseSidebar);
    $('#sidebar').hover(function() {
        setTimeout(function() {
            showSidebar();
        }, 600);
    }, function() {
        setTimeout(function() {
            collapseSidebar();
        }, 600);
    });

    //END MENU SIDEBAR


    //BEGIN TOPBAR DROPDOWN
    /*
    $('.dropdown-slimscroll').slimScroll({
        "height": '250px',
        "wheelStep": 5
    });
    */
    //END TOPBAR DROPDOWN

    //BEGIN CHECKBOX & RADIO
    /*
    if($('#demo-checkbox-radio').length <= 0){
        $('input[type="checkbox"]:not(".switch")').iCheck({
            checkboxClass: 'icheckbox_minimal-grey',
            increaseArea: '20%' // optional
        });
        $('input[type="radio"]:not(".switch")').iCheck({
            radioClass: 'iradio_minimal-grey',
            increaseArea: '20%' // optional
        });
    }
    */
    //END CHECKBOX & RADIO

    //BEGIN TOOTLIP
    //$("[data-toggle='tooltip'], [data-hover='tooltip']").tooltip();
    //END TOOLTIP

    //BEGIN POPOVER
    //$("[data-toggle='popover'], [data-hover='popover']").popover();
    //END POPOVER

    //BEGIN THEME SETTING
    /*
    $('#theme-setting > a.btn-theme-setting').click(function(){
        if($('#theme-setting').css('right') < '0'){
            $('#theme-setting').css('right', '0');
        } else {
            $('#theme-setting').css('right', '-250px');
        }
    });

    // Begin Change Theme Color
    var list_style = $('#theme-setting > .content-theme-setting > select#list-style');
    var list_color = $('#theme-setting > .content-theme-setting > ul#list-color > li');
    // FUNCTION CHANGE URL STYLE ON HEAD TAG
    var setTheme = function (style, color) {
        $.cookie('style',style);
        $.cookie('color',color);
        $('#theme-change').attr('href', 'css/themes/'+ style + '/' + color + '.css');
    }
    
    // INITIALIZE THEME FROM COOKIE
    // HAVE TO SET VALUE FOR STYLE&COLOR BEFORE AND AFTER ACTIVE THEME
    if ($.cookie('style')) {
        list_style.find('option').each(function(){
            if($(this).attr('value') == $.cookie('style')) {
                $(this).attr('selected', 'selected');
            }
        });
        list_color.removeClass("active");
        list_color.each(function(){
            if($(this).attr('data-color') == $.cookie('color')){
                $(this).addClass('active');
            }
        });
        setTheme($.cookie('style'), $.cookie('color'));
    };
   
    // SELECT EVENT
    list_style.on('change', function() {
        list_color.each(function() {
            if($(this).hasClass('active')){
                color_active  = $(this).attr('data-color');
            }
        });
        setTheme($(this).val(), color_active);
    });
    // LI CLICK EVENT
    list_color.on('click', function() {
        list_color.removeClass('active');
        $(this).addClass('active');
        setTheme(list_style.val(), $(this).attr('data-color'));
    });
    // End Change Theme Color
    //END THEME SETTING
    
    //BEGIN FULL SCREEN
    $('.btn-fullscreen').click(function() {

        if (!document.fullscreenElement &&    // alternative standard method
            !document.mozFullScreenElement && !document.webkitFullscreenElement && !document.msFullscreenElement ) {  // current working methods
            if (document.documentElement.requestFullscreen) {
                document.documentElement.requestFullscreen();
            } else if (document.documentElement.msRequestFullscreen) {
                document.documentElement.msRequestFullscreen();
            } else if (document.documentElement.mozRequestFullScreen) {
                document.documentElement.mozRequestFullScreen();
            } else if (document.documentElement.webkitRequestFullscreen) {
                document.documentElement.webkitRequestFullscreen(Element.ALLOW_KEYBOARD_INPUT);
            }
        } else {
            if (document.exitFullscreen) {
                document.exitFullscreen();
            } else if (document.msExitFullscreen) {
                document.msExitFullscreen();
            } else if (document.mozCancelFullScreen) {
                document.mozCancelFullScreen();
            } else if (document.webkitExitFullscreen) {
                document.webkitExitFullscreen();
            }
        }
    });
    //END FULL SCREEN


    //BEGIN PORTLET
    $(".portlet").each(function(index, element) {
        var me = $(this);
        $(">.portlet-header>.tools>i", me).click(function(e){
            if($(this).hasClass('fa-chevron-up')){
                $(">.portlet-body", me).slideUp('fast');
                $(this).removeClass('fa-chevron-up').addClass('fa-chevron-down');
            }
            else if($(this).hasClass('fa-chevron-down')){
                $(">.portlet-body", me).slideDown('fast');
                $(this).removeClass('fa-chevron-down').addClass('fa-chevron-up');
            }
            else if($(this).hasClass('fa-cog')){
                //Show modal
            }
            else if($(this).hasClass('fa-refresh')){
                //$(">.portlet-body", me).hide();
                $(">.portlet-body", me).addClass('wait');

                setTimeout(function(){
                    //$(">.portlet-body>div", me).show();
                    $(">.portlet-body", me).removeClass('wait');
                }, 1000);
            }
            else if($(this).hasClass('fa-times')){
                me.remove();
            }
        });
    });
    //END PORTLET
    
    //BEGIN BACK TO TOP
    $(window).scroll(function(){
        if ($(this).scrollTop() < 200) {
            $('#totop') .fadeOut();
        } else {
            $('#totop') .fadeIn();
        }
    });
    $('#totop').on('click', function(){
        $('html, body').animate({scrollTop:0}, 'fast');
        return false;
    });
    //END BACK TO TOP

    //BEGIN CHECKBOX TABLE
    $('.checkall').on('ifChecked ifUnchecked', function(event) {
        if (event.type == 'ifChecked') {
            $(this).closest('table').find('input[type=checkbox]').iCheck('check');
        } else {
            $(this).closest('table').find('input[type=checkbox]').iCheck('uncheck');
        }
    });
    //END CHECKBOX TABLE

    
    $('.option-demo').hover(function() {
        $(this).append("<div class='demo-layout animated fadeInUp'><i class='fa fa-magic mrs'></i>Demo</div>");
    }, function() {
        $('.demo-layout').remove();
    });
    $('#header-topbar-page .demo-layout').live('click', function() {
        var HtmlOption = $(this).parent().detach();
        $('#header-topbar-option-demo').html(HtmlOption).addClass('animated flash').one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function(){
            $(this).removeClass('animated flash');
        });
        $('#header-topbar-option-demo').find('.demo-layout').remove();
        return false;
    });
    $('#title-breadcrumb-page .demo-layout').live('click', function() {
        var HtmlOption = $(this).parent().html();
        $('#title-breadcrumb-option-demo').html(HtmlOption).addClass('animated flash').one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function(){
            $(this).removeClass('animated flash');
        });
        $('#title-breadcrumb-option-demo').find('.demo-layout').remove();
        return false;
    });
    // CALL FUNCTION RESPONSIVE TABS
    fakewaffle.responsiveTabs(['xs', 'sm']);
    */
    var pathname = this.location.pathname;    
    arr = /^(\/\w+)/.exec(pathname);
    if (arr!==null) {
        console.log("Setting "+arr[0]+" active");
        $('a[href="'+arr[0]+'"]').parents("li").addClass('active');
    }


});



