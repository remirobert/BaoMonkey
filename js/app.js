/*----------------------------------------
	HERO FLEXSLIDER
----------------------------------------*/
$(document).ready(function() {
	$('#main-slider').flexslider({
		animation: "fade",//effects
		slideshowSpeed: 3500,//duration
		controlNav: false,
		directionNav: false
	});
});

/*----------------------------------------
	TOOLTIP
----------------------------------------*/
$('.social-icons a, .social-icons-bottom a').tooltip();

/*----------------------------------------
	SIDE MENU
----------------------------------------*/
$("#menu-close").click(function(e) {
        e.preventDefault();
        $("#sidebar-wrapper").toggleClass("active");
    });
    $("#menu-toggle").click(function(e) {
        e.preventDefault();
        $("#sidebar-wrapper").toggleClass("active");
    });

/*----------------------------------------
	PAGE SCROLL
----------------------------------------*/
$('a[href*=#]:not([href=#])').click(function() {
            if (location.pathname.replace(/^\//, '') == this.pathname.replace(/^\//, '') || location.hostname == this.hostname) {

                var target = $(this.hash);
                target = target.length ? target : $('[name=' + this.hash.slice(1) + ']');
                if (target.length) {
                    $('html,body').animate({
                        scrollTop: target.offset().top
                    }, 1000);
                    return false;
                }
            }
        });

/*----------------------------------------
    PARALLAX
----------------------------------------*/
$(window).load(function(){
  $('.flexslider').flexslider({
    animation: "slide",
    start: function(slider){
      $('body').removeClass('loading');
    }
  });
});

