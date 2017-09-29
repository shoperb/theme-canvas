class @Product
  constructor: ->
    for el in document.querySelectorAll(".product-container .thumbs .thumb")
      el.addEventListener("click", (event)->
        for tnb in el.parentNode.querySelectorAll('.thumb')
          tnb.classList.remove('active')
        this.classList.add('active')

        img = this.dataset
        photos = this.parentNode.parentNode.querySelector('.photos .container')
        current = document.querySelector('[data-image=full-' + img.image + ']')
        for photo in photos.querySelectorAll('.photo')
          photo.classList.remove('visible')
        current.classList.add('visible')
        current.onmousemove = zoom

        testImage = new Image
        testImage.src = img.imageurl
        testImage.onload = ->
          if (testImage.width < photos.offsetWidth)
            current.classList.remove('zoom')
            current.classList.add('no-zoom')
          else
            current.classList.remove('no-zoom')
            current.classList.add('zoom')
      )

    # product gallery
    if document.querySelector('.product-container .photos .container')
      document.querySelector('.product-container .photos .container').addEventListener("click", (event)->
        active_image = 0
        gallery = document.querySelector('.product-gallery-container .product-gallery')
        for el in this.parentNode.parentNode.querySelectorAll('.thumbs .thumb')
          gal_item = document.createElement("DIV")
          gal_item.innerHTML = '<img src="' + el.dataset.imageurl + '">' if el.dataset.imageurl
          gallery.appendChild(gal_item);
          if el.classList.contains('active')
            active_image = el.dataset.image

        window.slider = tns(
          container: gallery
          items: 1
          slideBy: 'page'
          nav: false,
          controlsText: ['<div class="slideshow-prev"><svg class="icon-arrow-back"><use xlink:href="' + gallery.dataset.arrowImage + '#icon-arrow"></use></svg></div>', '<div class="slideshow-next"><svg class="icon-arrow-next"><use xlink:href="' + gallery.dataset.arrowImage + '#icon-arrow"></use></svg></div>'],
          arrowKeys: true
          mouseDrag: true
          lazyload: true)
        window.slider.goTo(active_image - 1)

        document.querySelector('.product-gallery-container').classList.add('show')
      )

    if document.querySelector('[data-close-gallery]')
      document.querySelector('[data-close-gallery]').addEventListener("click", (event)->
        window.slider.destroy()
        document.querySelector('.product-gallery-container').classList.remove('show')
      )

    document.addEventListener 'keydown', (event) ->
      gallery = document.querySelector('.product-gallery-container')
      if gallery and gallery.classList.contains('show')
        if event.key == 'ArrowLeft'
          gallery.querySelector('button[data-controls=prev]').click()
        else if event.key == 'ArrowRight'
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
