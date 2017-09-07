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
  el = document.querySelector('[data-section-id=' + section + '] [data-section-block-id=' + id + '] [data-video-full-size]')
  el.style.height = el.offsetWidth * 9 / 16 + 'px'

@slideVideoResize = (section, id) ->
  el = document.querySelector('[data-section-id=' + section + '] .with-video[data-section-block-id=' + id + ']')
  el.querySelector('iframe').style.width = el.offsetWidth + 'px'
  el.querySelector('iframe').style.height = el.offsetWidth * 9 / 16 + 'px'
