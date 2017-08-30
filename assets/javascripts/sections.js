$(document).ready(function() {
  // $('.slideshow').each(function() {
  //   var autoPlay = $(this).data('autoplay'),
  //       animationSpeed = $(this).data('animation-speed');

  //   $(this).slick({
  //     dots: true,
  //     autoplay: autoPlay,
  //     prevArrow: '<div class="slick-prev"><svg class="icon-arrow-back"><use xlink:href="' + $(this).data('arrow-image') + '#icon-arrow"></use></svg></div>',
  //     nextArrow: '<div class="slick-next"><svg class="icon-arrow-next"><use xlink:href="' + $(this).data('arrow-image') + '#icon-arrow"></use></svg></div>',
  //     autoplaySpeed: animationSpeed * 1000,
  //     lazyLoad: 'ondemand'
  //   });
  // });
  // $('.collection-slideshow').each(function() {
  //   $(this).slick({
  //     prevArrow: '<div class="slick-prev"><svg class="icon-arrow-back"><use xlink:href="' + $(this).data('arrow-image') + '#icon-arrow"></use></svg></div>',
  //     nextArrow: '<div class="slick-next"><svg class="icon-arrow-next"><use xlink:href="' + $(this).data('arrow-image') + '#icon-arrow"></use></svg></div>',
  //     slidesToShow: $(this).data('show-count'),
  //     slidesToScroll: $(this).data('show-count'),
  //     lazyLoad: 'ondemand'
  //     });
  // });
  // $('.testimonial-slider').each(function() {
  //   $(this).slick({
  //     prevArrow: '<div class="slick-prev"><svg class="icon-arrow-back"><use xlink:href="' + $(this).data('arrow-image') + '#icon-arrow"></use></svg></div>',
  //     nextArrow: '<div class="slick-next"><svg class="icon-arrow-next"><use xlink:href="' + $(this).data('arrow-image') + '#icon-arrow"></use></svg></div>',
  //     slidesToShow: 3,
  //     slidesToScroll: 3,
  //     responsive: [
  //       {
  //         breakpoint: 1024,
  //         settings: {
  //           slidesToShow: 2,
  //           slidesToScroll: 2
  //         }
  //       },
  //       {
  //         breakpoint: 768,
  //         settings: {
  //           slidesToShow: 1
  //         }
  //       }
  //     ]
  //   });
  // });
  // $('[data-toggle]').on('click', function() {
  //   var val = $(event.target).data('toggle');

  //   $('[data-item=main]', '#main-header').toggleClass('hidden');
  //   if (val === 'close') {
  //     $(event.target).parent().toggleClass('hidden');
  //   } else {
  //     $('.' + val + '-container').toggleClass('hidden');
  //   }
  // });

  // handleMapEvents();
  // setImageType();
  slideVideoResize();
  customVideoSize();
});
window.onresize = function() {
  slideVideoResize();
  customVideoSize();
};

function slideVideoResize() {
  $('.slideshow').each(function() {
    // set ratio to 16:9 as per YouTube
    $('iframe', this).width($(this).width());
    $('iframe', this).height($(this).width() * 9 / 16);
  });
}
function customVideoSize() {
  $('[data-video-full-size]').each(function() {
    $(this).height($(this).width() * 360 / 640);
  });
}
// function setImageType() {
//   $('[data-type=collection] .product .image img').each(function() {
//     if ($(this).width() > $(this).height()){
//       $(this).addClass('landscape');
//     } else {
//       $(this).addClass('portrait');
//     }
//   });
// }
// function handleMapEvents() {
//   var selector = '[data-type="location-and-contact"] .map-container';

//   $(selector).on('click', function () {
//     $('iframe', this).removeClass('scrolloff'); // set the pointer events true on click
//   });

//   $(selector).mouseleave(function () {
//     $('iframe', this).addClass('scrolloff'); // set the pointer events to none when mouse leaves the map area
//   });
// }
