#= require polyfill.closest

#= require config

#= require variant_selector
#= require cart
#= require product
#= require svg4everybody
#= require plugins

document.addEventListener("DOMContentLoaded", ->
  new LazyLoad({
    elements_selector: "iframe, img.lazyload"
  })
  new Cart()
  new Product()
  svg4everybody(polyfill: true)
  new DropdownInViewport()
  document.querySelector('[data-image-zoom]')?.onmousemove = zoom
)
window.onresize = ->
  new DropdownInViewport()

window.addEventListener("click", (event)->
  for el in document.querySelectorAll('.variant-selector')
    el.classList.remove('open')
)

for el in document.querySelectorAll('[data-quantity]')
  el.addEventListener("click", (event)->
    if !this.closest('.cart-page')
      input = event.target.parentNode.querySelector('#amount')
      diff = 0
      if event.target.dataset.quantity == 'decrease' and parseInt(input.value) > 0
        diff = -1
      else if event.target.dataset.quantity == 'increase'
        diff = 1

      input.value = parseInt(input.value) + diff
  )

for el in document.querySelectorAll('[data-fancy-dropdown-element]')
  el.addEventListener("click", (event)->
    if this.closest('form').elements["filter"].value
      this.closest('form').submit()
  )

for el in document.querySelectorAll('[data-sign-up]')
  el.addEventListener("click", (event)->
    if this.getAttribute('for') == 'business'
      for field in document.querySelectorAll('[data-business-only]')
        field.classList.remove('hidden')
    else
      for field in document.querySelectorAll('[data-business-only]')
        field.classList.add('hidden')
  )
