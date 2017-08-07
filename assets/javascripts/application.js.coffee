#= require polyfill.closest

#= require config

#= require variant_selector
#= require cart
#= require sections

document.addEventListener("DOMContentLoaded", ->
  new VariantSelector()
  new Cart()
  )
window.addEventListener("click", (event)->
  for el in document.querySelectorAll('.variant-selector')
    el.classList.remove('open')
  )