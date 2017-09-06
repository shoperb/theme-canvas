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

    if document.querySelector('.product-container .photos .container')
      document.querySelector('.product-container .photos .container').addEventListener("click", (event)->
        document.querySelector('.product-gallery-container').classList.add('show')

        active_image = 0
        gallery = document.querySelector('.product-gallery-container .product-gallery')
        icon = gallery.dataset.arrowImage
        for el in this.parentNode.parentNode.querySelectorAll('.thumbs .thumb')
          gal_item = document.createElement("DIV")
          gal_item.innerHTML = '<img src="' + el.dataset.imageurl + '">' if el.dataset.imageurl
          gallery.appendChild(gal_item);
          if el.classList.contains('active')
            active_image = el.dataset.image

        $(gallery).slick({
          initialSlide: active_image - 1,
          prevArrow: '<div class="slick-prev"><svg class="icon-arrow-back"><use xlink:href="' + icon + '#icon-arrow"></use></svg></div>',
          nextArrow: '<div class="slick-next"><svg class="icon-arrow-next"><use xlink:href="' + icon + '#icon-arrow"></use></svg></div>'
        });
      )

    if document.querySelector('[data-close-gallery]')
      document.querySelector('[data-close-gallery]').addEventListener("click", (event)->
        gallery = document.querySelector('.product-gallery-container .product-gallery')
        $(gallery).slick('unslick');
        document.querySelector('.product-gallery-container').classList.remove('show')
      )

    document.addEventListener 'keydown', (event) ->
      gallery = document.querySelector('.product-gallery-container')
      if gallery and gallery.classList.contains('show')
        if event.key == 'ArrowLeft'
          gallery.querySelector('.slick-prev').click()
        else if event.key == 'ArrowRight'
          gallery.querySelector('.slick-next').click()
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
