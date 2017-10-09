class @DropdownInViewport
  constructor: ->
    @CheckDroDown('.fancy-dropdown')

  CheckDroDown: (selector) =>
    for e in document.querySelectorAll(selector)
      e.onmouseover = ->
        dropDownMouseEvent(e);
      e.onmouseout = ->
        dropDownMouseEvent(e);

@dropDownMouseEvent = (el) ->
  viewportOffset = el.getBoundingClientRect()
  if el.parentNode.querySelector('ul')
    if viewportOffset.left + el.querySelector('ul').offsetWidth > window.innerWidth
      el.classList.add('direction-right')
    else
      el.classList.remove('direction-left')

@customVideoSize = (section, id) ->
  el = document.querySelector('[data-section-id=' + section + '] [data-section-block-id=' + id + '] [data-video-full-size]')
  if el
    el.style.height = (el.offsetWidth  * 9 / 16) + 'px'

@slideVideoResize = (section, id) ->
  for el in document.querySelectorAll('[data-section-id=' + section + '] .with-video[data-section-block-id=' + id + ']')
    if el.offsetWidth > el.offsetHeight
      el.querySelector('iframe').style.width = el.offsetWidth + 'px'
      el.querySelector('iframe').style.height = (el.offsetWidth  * 9 / 16) + 'px'
    else
      el.querySelector('iframe').style.height = el.offsetHeight + 'px'
      el.querySelector('iframe').style.width = el.offsetWidth + 'px'

@runLazyLoad = (section) ->
  selector = '[data-section-id=' + section + '] .lazyload'

  new LazyLoad(
    elements_selector: selector
    callback_set: (el) ->
      el.classList.add 'loaded'
  )

@positionSliderArrows = (section) ->
  container = document.querySelector('[data-section-id=' + section + ']')

  for el in container.querySelectorAll('[data-controls]')
    el.style.top = parseInt(container.querySelector('.image').offsetHeight / 2 + 10) + 'px'

@randomizeList = ->
  list = document.querySelector('.randomize-list')
  current = document.querySelector('[data-product-handle]').dataset.productHandle

  if list
    returner = undefined
    i = list.children.length

    while i >= 0
      list.appendChild list.children[Math.random() * i | 0]
      i--

    count = list.dataset.showOnly
    if parseInt(count)
      count--
    else
      count = 3

    for el, i in list.querySelectorAll('.product-container')
      if i <= count and current and current == el.querySelector('a').dataset.productListHandle
        el.parentNode.removeChild(el)
        count++
      el.parentNode.removeChild(el) if i > count
    list.classList.add('show')

@switchImage = (_this, add = '') ->
  img = _this.dataset
  photos = document.querySelector('.product-container .photos .container')
  current = document.querySelector('[data-image=' + add + 'full-' + img.image + ']')
  if current
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
