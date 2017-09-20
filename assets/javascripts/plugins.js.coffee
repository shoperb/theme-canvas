class @DropdownInViewport
  constructor: ->
    @CheckDroDown($('.fancy-dropdown'))

  CheckDroDown: (e) =>
    e.on 'mouseenter mouseleave', (el) ->
      viewportOffset = this.getBoundingClientRect()
      if this.parentNode.querySelector('ul')
        if viewportOffset.left + this.querySelector('ul').offsetWidth > window.innerWidth
          this.classList.add('direction-right')
        else
          this.classList.remove('direction-left')

@customVideoSize = (section, id) ->
  el = $('[data-section-id=' + section + '] [data-section-block-id=' + id + '] [data-video-full-size]')
  el.height(el.width()  * 9 / 16) if el

@slideVideoResize = (section, id) ->
  el = $('[data-section-id=' + section + '] .with-video[data-section-block-id=' + id + ']')
  if el
    $('iframe', el).width(el.width())
    $('iframe', el).height(el.width() * 9 / 16)

@runLazyLoad = (section) ->
  selector = '[data-section-id=' + section + '] .lazyload'

  new LazyLoad(
    elements_selector: selector
    callback_set: (el) ->
      el.classList.add 'loaded'
  )
