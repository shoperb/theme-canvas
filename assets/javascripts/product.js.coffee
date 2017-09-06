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

@zoom = (e) ->
  try
    zoomer = e.currentTarget
    if e.offsetX then (offsetX = e.offsetX) else (offsetX = e.touches[0].pageX)
    if e.offsetY then (offsetY = e.offsetY) else (offsetX = e.touches[0].pageX)
    x = offsetX / zoomer.offsetWidth * 100
    y = offsetY / zoomer.offsetHeight * 100
    zoomer.style.backgroundPosition = x + '% ' + y + '%'
  catch
