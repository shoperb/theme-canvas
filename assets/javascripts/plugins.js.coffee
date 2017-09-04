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
