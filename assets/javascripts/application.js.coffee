#= require polyfill.closest

#= require config

#= require variant_selector
#= require cart
#= require product
#= require svg4everybody
#= require plugins

document.addEventListener("DOMContentLoaded", ->
  new Cart()
  new Product()
  svg4everybody(polyfill: true)
  new DropdownInViewport()

  #handle first image size vs zoom
  image = document.querySelector('[data-image-zoom]')
  photos = document.querySelector('.product-container .photos')
  if image and photos
    testImage = new Image
    testImage.src = image.dataset.bgset
    testImage.onload = ->
      if (testImage.width < photos.offsetWidth)
        image.classList.remove('zoom')
        image.classList.add('no-zoom')
      else
        image.onmousemove = zoom
        image.classList.remove('no-zoom')
        image.classList.add('zoom')
)
window.onresize = ->
  new DropdownInViewport()

window.addEventListener("click", (event)->
  for el in document.querySelectorAll('.variant-selector')
    el.classList.remove('open')
)

for el in document.querySelectorAll('[data-quantity]')
  el.addEventListener("click", (event)->
    if !this.closest('.cart-page') and event.target.parentNode.dataset.addQuantity != "false"
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

for el in document.querySelectorAll('form[data-validate]')
  el.addEventListener("submit", (e)->
    e.preventDefault()
    err = false
    for field in el.querySelectorAll('[data-validate-field]')
      field.classList.remove('error')
      errEl = field.parentNode.querySelector('[data-type=error-message')
      field.parentNode.removeChild(errEl) if errEl

      if field.dataset.validateField == 'email' and (field.value == '' or !validateEmail(field.value))
        err = setValidation(field)
      if (field.dataset.validateField == 'password' or field.dataset.validateField == 'text') and (field.value == '')
        err = setValidation(field)

    if !err
      el.submit()
  )

validateEmail = (email) ->
  re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
  re.test email

setValidation = (field) ->
  field.classList.add('error')
  if field.dataset.error
    errormsg = document.createElement('DIV')
    errormsg.setAttribute('data-type', 'error-message')
    errormsg.innerHTML = field.dataset.error
    field.parentNode.appendChild(errormsg)
  true
