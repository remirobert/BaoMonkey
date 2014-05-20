/* Here is the zoombox plugin configuration */

jQuery(function($){
    $('a.zoombox').zoombox();

    
    
    $('a.zoombox').zoombox({
        theme       : 'zoombox',        //available themes : zoombox,lightbox, prettyphoto, darkprettyphoto, simple
        opacity     : 0.8,              // Black overlay opacity
        duration    : 500,              // Animation duration
        animation   : true,             // Do we have to animate the box ?
        gallery     : false,             // Allow gallery thumb view
        autoplay : false                // Autoplay for video
    });
   
});