$(document).ready(function(){
  $('.slideshow').each(function() {
    var autoPlay = $(this).data('autoplay'),
        animationSpeed = $(this).data('animation-speed');

    $(this).slick({
      dots: true,
      autoplay: autoPlay,
      prevArrow: '<div class="slick-prev"></div>',
      nextArrow: '<div class="slick-next"></div>',
      autoplaySpeed: animationSpeed * 1000,
      lazyLoad: 'ondemand'
    });
  });
  $('.testimonial-slider').each(function() {
    $(this).slick({
      prevArrow: '<div class="slick-prev"></div>',
      nextArrow: '<div class="slick-next"></div>',
      slidesToShow: 3,
      slidesToScroll: 3,
      responsive: [
        {
          breakpoint: 1024,
          settings: {
            slidesToShow: 2,
            slidesToScroll: 2
          }
        },
        {
          breakpoint: 768,
          settings: {
            slidesToShow: 1
          }
        }
      ]
    });
  });

  setImageType();
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

function setImageType() {
  $('[data-type=collection] .product .image img').each(function() {
    if ($(this).width() > $(this).height()){
      $(this).addClass('landscape');
    } else {
      $(this).addClass('portrait');
    }
  });
}

// (function() {
//   var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };
//
//   window.Base = (function() {
//     Base.subscribeTo = [];
//
//     Base.selector = null;
//
//     Base.bindMethod = 'bindMany';
//
//     Base.scope = document;
//
//     Base.bindMany = function(selector, context) {
//       var collection, instance,
//         _this = this;
//
//       if (context == null) {
//         context = this.scope;
//       }
//       collection = [];
//       instance = this;
//       if ($(selector, context).length > 0) {
//         $(selector, context).each(function(index, element) {
//           var el;
//
//           el = $(element);
//           return collection.push(new instance(el));
//         });
//       }
//       return collection;
//     };
//
//     Base.bindOne = function(selector, context) {
//       var el;
//
//       if (context == null) {
//         context = this.scope;
//       }
//       if ($(selector, context).length > 0) {
//         el = $(selector, context);
//         return new this(el);
//       }
//     };
//
//     Base.bindCollection = function(selector, context) {
//       var el;
//
//       if (context == null) {
//         context = this.scope;
//       }
//       if ($(selector, context).length > 0) {
//         el = $(selector, context);
//         return new this(el);
//       }
//     };
//
//     Base.init = function() {
//       if (this.selector) {
//         this[this.bindMethod].apply(this, [this.selector]);
//         return this.handleSubscriptions();
//       }
//     };
//
//     Base.handleSubscriptions = function() {
//       var event, _i, _len, _ref, _results,
//         _this = this;
//
//       _ref = this.subscribeTo;
//       _results = [];
//       for (_i = 0, _len = _ref.length; _i < _len; _i++) {
//         event = _ref[_i];
//         _results.push(($(this.scope)).on(event, function(e) {
//           return _this[_this.bindMethod].apply(_this, [_this.selector, e.target]);
//         }));
//       }
//       return _results;
//     };
//
//     Base.prototype.reBind = function() {
//       return this.constructor(this.container);
//     };
//
//     function Base(container) {
//       this.container = container;
//       this.reBind = __bind(this.reBind, this);
//     }
//
//     return Base;
//
//   })();
//
// }).call(this);
//
//
// // Custom Select
//
// (function() {
//   var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
//     __hasProp = {}.hasOwnProperty,
//     __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };
//
//   window.CustomSelect = (function(_super) {
//     __extends(CustomSelect, _super);
//
//     CustomSelect.subscribeTo = ["variantSelectsAdded"]
//     CustomSelect.selector = "*[data-behaviour='select']";
//
//     function CustomSelect(container) {
//       this.container = container;
//       this.checkPlaceholder = __bind(this.checkPlaceholder, this);
//       this.wrap = __bind(this.wrap, this);
//       this.initChangeListener = __bind(this.initChangeListener, this);
//       this.updateValue = __bind(this.updateValue, this);
//       this.initVisibilityListeners = __bind(this.initVisibilityListeners, this);
//       CustomSelect.__super__.constructor.call(this, this.container);
//       this.theme = this.container.data('theme' || '');
//       this.wrap();
//       this.wrapper = this.container.parent('.select');
//       if (this.container.hasClass('hidden')) {
//         this.wrapper.addClass('hidden');
//       }
//       this.initVisibilityListeners();
//       this.checkPlaceholder();
//     }
//
//     CustomSelect.prototype.initVisibilityListeners = function() {
//       var _this = this;
//
//       this.container.on('customSelect:hide', function() {
//         _this.container.addClass('hidden');
//         return _this.wrapper.addClass('hidden');
//       });
//       this.container.on('customSelect:show', function() {
//         _this.container.removeClass('hidden');
//         return _this.wrapper.removeClass('hidden');
//       });
//       return this.container.on('customSelect:update', function() {
//         return _this.updateValue();
//       });
//     };
//
//     CustomSelect.prototype.updateValue = function() {
//       var value;
//
//       if (this.valueEl) {
//         value = ($('option:selected', this.container)).text();
//         this.checkPlaceholder();
//         return this.valueEl.text(value);
//       }
//     };
//
//     CustomSelect.prototype.initChangeListener = function() {
//       var _this = this;
//
//       return this.container.on('change', function() {
//         var value;
//
//         value = ($('option:selected', _this.container)).text();
//         _this.checkPlaceholder();
//         return _this.valueEl.text(value);
//       });
//     };
//
//     CustomSelect.prototype.wrap = function() {
//       var selected, value;
//
//       var box_select = '';
//       var trigger_color = ['variant-värv', 'variant-color', 'variant-colour'];
//       if ($.inArray(this.container.attr('id').toLowerCase(), trigger_color) > -1) {
//         box_select = 'data-behavior-box-select';
//       }
//
//       if (!this.container.data('is-wrapped')) {
//         this.id = this.container.attr('id');
//         if (this.id) {
//           this.container.wrap("<div class=\"select " + this.theme + " has-id-" + this.id + "\" " + box_select + " />");
//         } else {
//           this.container.wrap("<div class=\"select " + this.theme + "\" />");
//         }
//         value = ($('option:selected', this.container)).text();
//         this.container.before('<span class="selected"><span class="value">' + value + '</span><span class="caret"></span></span>');
//         selected = $(this.container.siblings('.selected'));
//         this.valueEl = $('.value', selected);
//         this.initChangeListener();
//         return this.container.data('is-wrapped', true);
//       }
//     };
//
//     CustomSelect.prototype.checkPlaceholder = function() {
//       if (!/\S/.test(this.container.val())) {
//         return ($(this.container.parent('.select'))).addClass('placeholder');
//       } else {
//         return ($(this.container.parent('.select'))).removeClass('placeholder');
//       }
//     };
//
//     return CustomSelect;
//
//   })(window.Base);
//
//   jQuery(function() {
//     return window.CustomSelect.init();
//   });
//
// }).call(this);
//
// // Custom Select
//
// (function() {
//   var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
//     __hasProp = {}.hasOwnProperty,
//     __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };
//
//   window.ProductDetails = (function(_super) {
//     __extends(ProductDetails, _super);
//
//     ProductDetails.selector = "*[data-product-details]";
//
//     function ProductDetails(container) {
//       this.container = container;
//       this.handleVariantSelect = __bind(this.handleVariantSelect, this);
//       this.variantSelect = $('*[data-variant-select]', this.container);
//       this.variantContainer = $('*[data-variant-container]', this.container);
//       this.previousPrice = $('*[data-previous-price]', this.container);
//       this.currentPrice = $('*[data-current-price]', this.container);
//       this.sku = $('*[data-variant-sku]', this.container);
//       this.variantWidth = $('*[data-variant-width]', this.container);
//       this.variantHeight = $('*[data-variant-height]', this.container);
//       this.variantDepth = $('*[data-variant-depth]', this.container);
//       this.variantWeight = $('*[data-variant-weight]', this.container);
//       this.currencySymbol = container.data('currency-symbol');
//       this.variantData = [];
//       this.variantAttributeSelectTemplate = $('#variant-select-template', this.container).html();
//       this.constraints = {};
//       this.lastConstraint = {};
//       this.attributeSelects = {};
//       this.availableVariants = [];
//       this.first = true;
//       this.currentOptions = {};
//
//       this.initVariantData();
//       this.initVariantSelects();
//       this.hideVariantSelect();
//       this.initVariantSelectChange();
//     };
//
//     ProductDetails.prototype.initVariantSelectChange = function() {
//       var _this = this;
//       this.variantSelect.on('change', function() {
//         var current = $('option:selected', _this.variantSelect);
//         var data = current.data('variant');
//         if (data) {
//           var splitPrice = data.current_price.split('.');
//           var format = '0,0';
//           if (parseInt(splitPrice[1], 10) != 0) {
//             format = '0,0.00'
//           }
//           var formattedPrice = numeral(data.current_price).format(format);
//           var old_price = $('.compare-price');
//           if (data.has_discount) {
//             _this.previousPrice.removeClass('hidden');
//             old_price.show();
//           } else {
//             _this.previousPrice.addClass('hidden');
//             old_price.hide();
//           }
//           _this.currentPrice.html(_this.currencySymbol + formattedPrice);
//           var data_sku = $('[data-variant-sku-container]');
//           data_sku.hide();
//           if (data.sku) {
//             data_sku.show();
//             _this.sku.html(data.sku);
//           }
//
//           _this.variantWidth.html(data.width);
//           _this.variantHeight.html(data.height);
//           _this.variantDepth.html(data.depth);
//           _this.variantWeight.html(data.weight);
//           _this.checkTechData(data);
//         }
//       });
//     };
//
//     ProductDetails.prototype.checkTechData = function(data) {
//       var data_container = $('[data-tech-info-header]');
//       var data_width = $('[data-variant-width-container]');
//       var data_height = $('[data-variant-height-container]');
//       var data_depth = $('[data-variant-depth-container]');
//       var data_weight = $('[data-variant-weight-container]');
//       if (data.width || data.height || data.depth || data.weight) {
//         data_container.show();
//
//         data_width.hide();
//         if (data.width)
//           data_width.show();
//         data_height.hide();
//         if (data.height)
//           data_height.show();
//         data_depth.hide();
//         if (data.depth)
//           data_depth.show();
//         data_weight.hide();
//         if (data.weight)
//           data_weight.show();
//       } else {
//         data_container.hide();
//         $('.tabs-horizontal.headings li:visible:first-of-type').trigger('click');
//       }
//     };
//
//     ProductDetails.prototype.initVariantData = function() {
//       var _this = this;
//
//       $('option', this.variantSelect).each(function(index, value){
//         var variant = $(value);
//         var data = variant.data('variant');
//
//         if(data){
//           _this.variantData.push(data);
//         }
//       });
//     };
//
//     ProductDetails.prototype.initVariantSelects = function() {
//       var _this = this;
//       var selects = {};
//       $(this.variantData).each(function(index, variant){
//         $(variant.attributes).each(function(index, attr){
//           if(selects[attr.name]){
//             selects[attr.name].push(attr);
//           }else{
//             selects[attr.name] = [attr];
//           }
//         });
//       });
//       $.each(selects, function(name, variant){
//         _this.attributeSelects[name] = $(_.template(_this.variantAttributeSelectTemplate, {name: name, options: _this.optionsForSelect(variant).join(' ')})).appendTo(_this.variantContainer);
//       });
//       $('select', this.variantContainer).on('change', _this.handleVariantSelect);
//       this.variantContainer.trigger('variantSelectsAdded');
//     };
//
//     ProductDetails.prototype.handleVariantSelect = function(e) {
//       var _this = this;
//       var select = $(e.currentTarget);
//       var currentOption = $('option:selected', select);
//       var name = select.attr('name');
//       if(currentOption.val()){
//         var constraint = {name: name, value: currentOption.val()};
//         _this.lastConstraint = constraint;
//         _this.constraints[name] = constraint;
//       }else{
//         if(_this.lastConstraint == currentOption.val()){
//           _this.lastConstraint = {};
//         }
//         if(_this.constraints[name]){
//           delete _this.constraints[name];
//         }
//       }
//       this.updateConstraints()
//     };
//
//     ProductDetails.prototype.updateConstraints = function(e) {
//       var _this = this;
//       _this.availableVariants = [];
//       $(this.variantData).each(function(index, variant){
//         var variantAvailable = true;
//         var constraint = _this.lastConstraint;
//         var constraintFound = false;
//         $(variant.attributes).each(function(index, attr){
//           if(constraint.name == attr.name && constraint.value == attr.value){
//             constraintFound = true;
//             return false;
//           }
//         });
//         if(!constraintFound){
//           variantAvailable = false;
//         }
//
//         if(variantAvailable){
//           _this.availableVariants.push(variant);
//         }
//       });
//       _this.constrainedVariants();
//     };
//
//     ProductDetails.prototype.constrainedVariants = function() {
//       var _this = this;
//       var selects = {};
//       $(_this.availableVariants).each(function(index, variant){
//         $(variant.attributes).each(function(index, attr){
//           if(selects[attr.name]){
//             selects[attr.name].push(attr);
//           }else{
//             selects[attr.name] = [attr];
//           }
//         });
//       });
//       $.each(selects, function(key, variant){
//         var options = _this.optionsForSelect(variant);
//         var select = $('select', _this.attributeSelects[key]);
//         var placeholder = $('option:first', select);
//         var optionElements = $('option', select);
//         var selected = $('option:selected', select);
//         var index = 0;
//
//         if(_this.lastConstraint.name == key){
//         }else{
//           if(placeholder[0] == selected[0] && _this.first){
//             index = 0;
//             options[index] = $('<select>').append($(options[index]).attr('selected', 'selected')).html();
//           }else{
//             $.each(options, function(ind, val){
//               var opt =  $(val)
//               if(selected.val() == opt.val()){
//                 options[ind] = $('<select>').append($(options[ind]).attr('selected', 'selected')).html();
//               }
//             });
//           }
//           select.html(options.join(' '));
//           select.trigger('customSelect:update');
//         }
//         selected = $('option:selected', select);
//         if(selected.val() && selected.val() != ""){
//           _this.currentOptions[key] = selected.val();
//         }else{
//           delete _this.currentOptions[key];
//         }
//       });
//       _this.first = false;
//       _this.selectVariant();
//     };
//
//     //jquery unique orders the array, we don't waht it here
//     ProductDetails.prototype.uniqueOption = function(arr) {
//       var unique = arr.filter(function(itm,i,arr) {
//         return i == arr.indexOf(itm);
//       });
//
//       return unique;
//     };
//
//     ProductDetails.prototype.optionsForSelect = function(variant) {
//       var values = $.map(variant, function(el){return el.value;});
//
//       var options = this.uniqueOption(values).map(function(value){
//         return '<option value="' + value +'">' + value + '</option>';
//       });
//
//       return options;
//     };
//
//     ProductDetails.prototype.selectVariant = function() {
//       var _this = this;
//       if(Object.keys(_this.attributeSelects).length == Object.keys(_this.currentOptions).length){
//         var matchingVariantId = false;
//         $(this.variantData).each(function(index, variant){
//           var attributesMatch = true;
//           $(variant.attributes).each(function(index, attr){
//             if(_this.currentOptions[attr.name] != attr.value){
//               attributesMatch = false;
//             }
//           });
//           if(attributesMatch){
//             matchingVariantId = variant.id;
//           }
//         });
//         _this.variantSelect.val(matchingVariantId);
//         _this.variantSelect.trigger('change');
//       }else{
//         var NEEDED_HANDLE = ['variant-värv', 'variant-color', 'variant-colour'];
//         var attr_value = $('[data-behavior-box-select] div.active').data("value");
//
//         var matchingVariant = '';
//         this.variantData.forEach(function(variant){
//           if (matchingVariant !== '') return;
//
//           var arr = variant.attributes;
//           if (arr == null) arr = [];
//           arr.forEach(function(attr){
//             if (NEEDED_HANDLE.indexOf('variant-'+attr.name.toLowerCase()) > -1 && attr.value === attr_value){
//               matchingVariant = variant;
//               return;
//             }
//           });
//         });
//
//         //if(typeof(_this.we_bind) == 'undefined') _this.we_bind = true;
//         //if (matchingVariant !== '' && typeof(_this.we_bind) !== 'undefined'){
//         if (matchingVariant !== ''){
//           // removing elements
//           // rendering options,
//           // rendering selects
//           // click on color selected
//           _this.variantContainer.html('');
//           _this.initVariantSelects();
//           //bindColorSelecters();
//           _this.we_bind = false;
//           matchingVariant.attributes.forEach(function(attr){
//             if (NEEDED_HANDLE.indexOf('variant-'+attr.name.toLowerCase()) > -1){
//               var box_select = $('select', '[data-behavior-box-select]');
//               $('.box-select-item').removeClass('active');
//               $('[data-behavior-box-select] div[data-value="'+attr.value+'"]').addClass('active');
//               box_select.val(attr.value);
//               box_select.trigger('change');
//               return;
//             }
//           });
//
//         }else{
//           _this.we_bind = true;
//         }
//         _this.variantSelect.val(matchingVariant ? matchingVariant.id : '');
//         _this.variantSelect.trigger('change');
//       }
//     };
//
//     ProductDetails.prototype.hideVariantSelect = function() {
//       var _this = this;
//
//       _this.variantSelect.trigger('customSelect:hide');
//     };
//
//     return ProductDetails;
//
//   })(window.Base);
//
//   jQuery(function() {
//     return window.ProductDetails.init();
//   });
//
// }).call(this);
//
// function product_preview(){
//     $("*[data-lrg-img]").on('click', function(e){
//         e = $(e.target).closest(".slick-slide");
//         $("*[data-product-preview]").attr('src', e.data("lrg-img"));
//
//         img_zoom = $('[data-cloudzoom]').data('CloudZoom');
//         img_zoom.loadImage(e.data("lrg-img"), e.data("zoom-img"))
//     });
// }
//
//
// jQuery(document).ready(function(){
//   // $(document).foundation();
//   (function() {
//     var initCart = function(){
//       $('.cart-item').each(function(index, value){
//         var form = $(value).closest('form');
//         var field = $('.quantity input', value);
//         var increase = $('[data-increase-quantity]', value);
//         var decrease = $('[data-decrease-quantity]', value);
//         var url = form.attr('action');
//         var method = form.attr('method');
//         var remove = $('.remove-cart-item', value);
//
//         increase.on('click', function(){
//           field.val(parseInt(field.val(), 10) + 1);
//           field.trigger('input');
//         });
//
//         decrease.on('click', function(){
//           var newVal = parseInt(field.val(), 10) - 1;
//           if(newVal<0){
//             newVal = 0;
//           }
//           field.val(newVal);
//           field.trigger('input');
//         });
//
//         remove.on('click', function(){
//           field.val(0);
//           field.trigger('input');
//         });
//
//         var timeout = 0;
//         field.on('input', function(e){
//           clearTimeout(timeout);
//           timeout = setTimeout(function(){
//             $.ajax(url+".json?include=liquid",
//               {
//                 type: method,
//                 data: form.serialize()
//               }).always(function(data){
//                 parser=new DOMParser();
//                 htmlDoc=parser.parseFromString(data.liquid, "text/html");
//                 var newCart = htmlDoc.querySelector('#js-cart-content');
//                 var oldCart = $('#js-cart-content');
//
//                 if (data.error) {
//                   err = htmlDoc.querySelector('.flash.error');
//                   flash = $(".flash.error");
//                   if (flash.length==1) {
//                     flash.replaceWith(err);
//                   } else {
//                     $("#js-cart-content").before(err);
//                   }
//                   $(".flash.error").show();
//                 } else {
//                   $(".flash.error").hide();
//                 }
//
//                 oldCart.replaceWith(newCart);
//                 initCart();
//              });
//             }, 300);
//         })
//       });
//     };
//
//     var initAddToCart = function(){
//       $('form.add-to-cart-form').on('submit', function(e){
//         e.preventDefault();
//         var form = $(e.currentTarget);
//         $.ajax({
//             url: form.attr('action'),
//             type: form.attr('method'),
//             data: form.serializeArray(),
//             dataType: "JSON"
//           }
//         ).done(function(json){
//             window.location.reload(false);
//           });
//       });
//     };
//
//     initCart();
// //    initAddToCart();
//
//     //flasherror show & hide
// 		var error = $('.flasherror');
// 		if (error.length) {
// 			error.slideDown();
//
// 			$('body').on('click', error, function() {
// 				error.slideUp();
// 			});
// 		}
//
// 		if ($('.slider').length) {
// 			$('.slider').show();
// 		}
//
//     //randomize products list
//     if ($('.randomize-list').length) {
//       var returner;
//       var list = document.querySelector('.randomize-list');
//
//       //randomize elements
//       for(var i = list.children.length; i >= 0; i--){
//         list.appendChild(list.children[Math.random() * i | 0]);
//       }
//
//       //get custom display count
//       var count = $('.randomize-list').data('show-only');
//       if (parseInt(count))
//         count++;
//       else
//         //default is 4 + 1
//         count = 5;
//
//       //remove all elements except first N = display count
//       $('.randomize-list>div:nth-child(n+'+count+')').remove();
//       //show elements list
//       $('.randomize-list').show();
//     }
//
//     //setSectionsOrder();
//
//     //if (Modernizr.svg) {
//     //  $('img[src*="svg"]').attr('src', function() {
//     //    return $(this).attr('src').replace('.svg', '.png');
//     //  });
//     //}
//
//     var mq_small = 768,
//         mq_medium = 1280;
//
//     positions = function() {
//       var insertPosition;
//       insertPosition = function(position_target) {
//         var positions_src, target;
//         positions_src = $('.positions.active');
//         target = position_target;
//         positions_src.find('[data-position]').each(function() {
//           var elem_src, elem_target, position;
//           position = $(this).attr('data-position');
//           if (position.length) {
//             elem_src = positions_src.find('[data-position="' + position + '"]');
//             elem_target = target.find('[data-position="' + position + '"]');
//             return elem_src.children().appendTo(elem_target);
//           }
//         });
//         positions_src.removeClass('active');
//         return position_target.addClass('active');
//       };
//       $(document).on("smallWindow", function() {
//         return insertPosition($('.positions.show-for-small'));
//       });
//       $(document).on("mediumWindow", function() {
//         return insertPosition($('.positions.show-for-medium-only'));
//       });
//       $(document).on("largeWindow", function() {
//         return insertPosition($('.positions.show-for-large-up'));
//       });
//     };
//     positions();
//
//     current_window = '';
//     mediaQueries = function() {
//       if ($("html").hasClass("lt-ie9")) {
//         $.event.trigger("mediumWindow");
//         return current_window = 'medium';
//       } else if (window.matchMedia('only screen and (min-width: ' + mq_medium + 'px)').matches) {
//         if (current_window !== 'large') {
//           $.event.trigger("largeWindow");
//           return current_window = 'large';
//         }
//       } else if (window.matchMedia('only screen and (min-width: ' + mq_small + 'px)').matches) {
//         if (current_window !== 'medium') {
//           $.event.trigger("mediumWindow");
//           return current_window = 'medium';
//         }
//       } else {
//         if (current_window !== 'small') {
//           $.event.trigger("smallWindow");
//           return current_window = 'small';
//         }
//       }
//     };
//     mediaQueries();
//     $(window).resize(function() {
//       return mediaQueries();
//     });
//
//     var custom_select = $('.cart-form [data-behaviour=select]:not([data-variant-select])'), i;
//     for (i = 0; i < custom_select.length; ++i) {
//       //console.log(custom_select[i]);
//       $(custom_select[i]).trigger('change');
//     }
//
//     // register form validation
//     var err = $('[data-form-error]');
//     $('[data-behavior=register]').on('submit', function() {
//       var _this = this;
//       var error = false;
//       err.html('');
//       $('input[type=text]:not([data-type=email])', this).each(function() {
//         $(this).removeClass('error');
//         if ($(this).val().length == 0) {
//           $(this).addClass('error');
//           err.append('<div>'+$(this).data('error')+'</div>');
//           error = true;
//         }
//       });
//       var email = $('input[data-type=email]', this);
//       email.removeClass('error');
//       if (!isEmail(email.val()) || email.val().length == 0) {
//         err.append('<div>'+email.data('error')+'</div>');
//         email.addClass('error');
//         error = true;
//       }
//       $('input[type=password]', this).each(function() {
//         $(this).removeClass('error');
//         if ($(this).val().length == 0) {
//           $(this).addClass('error');
//           err.append('<div>'+$(this).data('error')+'</div>');
//           error = true;
//         }
//       });
//       if ($('input[data-type=password]').val() != $('input[data-type=password_confirmation]').val()) {
//         $('input[data-type=password]').addClass('error');
//         $('input[data-type=password_confirmation]').addClass('error');
//         err.append('<div>'+$(_this).data('error')+'</div>');
//         error = true;
//       }
//
//       if (error)
//         return false;
//       return true;
//     });
//
//   }).call(this);
// });
//
// function imageError(image) {
//   image.remove();
// }
// function isEmail(email) {
//   var regex = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/;
//   return regex.test(email);
// }
