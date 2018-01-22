class @Product
  constructor: ->
    for el in document.querySelectorAll(".product-container .thumbs .thumb")
      el.addEventListener("click", (event)->
        for tnb in el.parentNode.querySelectorAll('.thumb')
          tnb.classList.remove('active')
        this.classList.add('active')

        switchImage(this)
      )

    # product gallery
    if document.querySelector('.product-container .photos .container')
      document.querySelector('.product-container .photos .container').addEventListener("click", (event)->
        document.querySelector('.product-gallery-container').classList.add('show')

        active_image = 0
        gallery = document.querySelector('.product-gallery-container .product-gallery')
        thumbs = this.parentNode.parentNode.querySelectorAll('.thumbs .thumb')
        for el in thumbs
          gal_item = document.createElement("DIV")
          gal_item.innerHTML = '<img src="' + el.dataset.imageurl + '">' if el.dataset.imageurl
          gallery.appendChild(gal_item);
          if el.classList.contains('active')
            active_image = el.dataset.image

        if thumbs.length > 1
          window.slider = tns(
            container: gallery
            items: 1
            slideBy: 'page'
            nav: false,
            controlsText: ['<div class="slideshow-prev"><i class="icon-arrow slider"></i></div>',
              '<div class="slideshow-next"><i class="icon-arrow slider next"></i></div>'],
            arrowKeys: true
            mouseDrag: true
            lazyload: true
          )
          window.slider.goTo(active_image - 1)
      )

    if document.querySelector('[data-close-gallery]')
      document.querySelector('[data-close-gallery]').addEventListener("click", (event)->
        if window.slider
          window.slider.destroy()
        document.querySelector('.product-gallery-container').classList.remove('show')
      )

    document.addEventListener 'keydown', (event) ->
      gallery = document.querySelector('.product-gallery-container')
      if gallery and gallery.classList.contains('show')
          if event.key == 'ArrowLeft'
            if window.slider
              gallery.querySelector('button[data-controls=prev]').click()
          else if event.key == 'ArrowRight'
            if window.slider
              gallery.querySelector('button[data-controls=next]').click()
          else if event.key == 'Escape'
            gallery.querySelector('[data-close-gallery]').click()

@zoom = (e) ->
  try
    zoomer = e.currentTarget
    if e.offsetX then (offsetX = e.offsetX) else (offsetX = e.touches[0].pageX)
    if e.offsetY then (offsetY = e.offsetY) else (offsetX = e.touches[0].pageX)
    x = offsetX / zoomer.offsetWidth * 100
    y = offsetY / zoomer.offsetHeight * 100
    zoomer.style.backgroundPosition = x + '% ' + y + '%'
  catch
