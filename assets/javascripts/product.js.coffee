class @Product
  constructor: ->
    for el in document.querySelectorAll(".product-container .thumbs .thumb")
      el.addEventListener("click", (event)->
        for tnb in el.parentNode.querySelectorAll('.thumb')
          tnb.classList.remove('active')
        this.classList.add('active')

        img = this.dataset.image
        for photo in this.parentNode.parentNode.querySelectorAll('.photos .photo')
          photo.classList.remove('visible')
        document.querySelector('[data-image=full-' + img + ']').classList.add('visible')
        document.querySelector('[data-image=full-' + img + ']').onmousemove = zoom
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
