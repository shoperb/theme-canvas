#= require polyfill.closest

#= require config

#= require variant_selector
#= require cart
#= require sections
#= require svg4everybody
# require plugins

document.addEventListener("DOMContentLoaded", ->
  new VariantSelector()
  new Cart()
  svg4everybody(polyfill: true)
#  new DropdownInViewport()
)

window.addEventListener("click", (event)->
  for el in document.querySelectorAll('.variant-selector')
    el.classList.remove('open')
)

for el in document.querySelectorAll('[data-quantity]')
  el.addEventListener("click", (event)->
    input = event.target.parentNode.querySelector('#amount')
    diff = 0
    if event.target.dataset.quantity == 'decrease' and parseInt(input.value) > 0
      diff = -1
    else if event.target.dataset.quantity == 'increase'
      diff = 1

    input.value = parseInt(input.value) + diff
  )