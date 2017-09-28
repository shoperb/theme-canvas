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
    el.querySelector('iframe').style.width = el.offsetWidth + 'px'
    el.querySelector('iframe').style.height = (el.offsetWidth  * 9 / 16) + 'px'

@runLazyLoad = (section) ->
  selector = '[data-section-id=' + section + '] .lazyload'

  new LazyLoad(
    elements_selector: selector
    callback_set: (el) ->
      el.classList.add 'loaded'
  )
