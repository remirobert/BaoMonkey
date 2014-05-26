$(document).ready(function(){
	
	$('#main-slider ul').jcarousel({
		wrap: 'both',
		scroll: 1,
		auto: 6,
		visible: 1,
		initCallback: init_carousel,
		itemFirstInCallback: function(carousel, item, idx, state) {
			$('#main-slider .nav a').removeClass('active');
			$('#main-slider .nav a').eq(idx-1).addClass('active');
		}
	});
	
	$('.products-slider ul').jcarousel({
		wrap: 'both',
		scroll: 1,
		auto: 6,
		visible: 4,
		initCallback: init_carousel_two
	});
	
	$('.field').focus(function() {
	    if(this.title==this.value) {
	        this.value = '';
	    }
	}).blur(function(){
	    if(this.value=='') {
	        this.value = this.title;
	    }
	});
	
	$('a.product')
		.hover(function (){
			$(this).toggleClass("hover");
		}
	);

	if ($.browser.msie && $.browser.version.substr(0,1)<7) {
		DD_belatedPNG.fix('#search, #main, h1#logo a, #navigation ul li a:hover, #navigation ul li a.active, #main-slider, #main-slider .cnt a.btn, #main-slider .nav a, #main-slider .nav a:hover, #main-slider .nav a.active, .case h3, .row, .product, .products-slider .nav a.prev, .products-slider .nav a.next, #footer .col .field-wrapper, #footer .col input.submit-btn, #footer .social a.fb-link, #footer .social a.twitter-link, #footer .social a.behance-link, #footer .social a.blogger-link, #footer .social a.digg-link, #footer .partners ul li, #footer a.logo img');
	};

});	

function init_carousel(carousel, idx) {
	$('#main-slider .nav a').click(function(){
		var idx = $(this).index()+1;
		carousel.scroll( idx );
		return false;
	});
}

function init_carousel_two(carousel) {
	$('.products-slider .nav a.prev').click(function(){
		carousel.prev();
		return false;
	});
	$('.products-slider .nav a.next').click(function(){
		carousel.next();
		return false;
	});
}