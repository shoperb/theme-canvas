#class @DropdownInViewport
#  constructor: ->
#    @CheckDroDown($('.menu-dropdown'))
#
#  CheckDroDown: (e) =>
#    e.on 'mouseenter mouseleave', (el) ->
#      console.log el.target
#      viewportOffset = el.target.getBoundingClientRect()
#      if el.target.parentNode.querySelector('ul')
#        debugger
#
#        console.log viewportOffset.left + el.target.querySelector('ul').offsetWidth
#        console.log window.innerWidth
#
#        if viewportOffset.left + el.target.querySelector('ul').offsetWidth > window.innerWidth
#          el.target.classList.add('direction-right')
#          console.log 'right'
#        else
#          el.target.classList.remove('direction-left')
#          console.log 'left'
