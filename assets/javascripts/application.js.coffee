#= require polyfill.closest

#= require config

#= require variant_selector
#= require cart
#= require sections

document.addEventListener("DOMContentLoaded", ->
  new VariantSelector()
  new Cart()
  )