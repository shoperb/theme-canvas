class @Cart
  constructor: ->
    for form in document.querySelectorAll("form[data-remote='true']")
      form.addEventListener "submit", @sendForm
    @initCart()

  initCart: =>
    inputChange = @make_event('input')

    for item in document.querySelectorAll(".cart-item")
      increase = item.querySelector('[data-quantity=increase]')
      decrease = item.querySelector('[data-quantity=decrease]')
      remove = item.querySelector('[data-remove-item]')
      field = item.querySelector('.cart-col-quantity input');

      increase.addEventListener 'click', (e) =>
        local_field = @field(e)
        local_field.value = parseInt(local_field.value, 10) + 1
        local_field.dispatchEvent inputChange

      decrease.addEventListener 'click', (e) =>
        local_field = @field(e)
        newVal = parseInt(local_field.value, 10) - 1
        newVal = 0 if newVal < 0
        local_field.value = newVal
        local_field.dispatchEvent inputChange
        @field()

      remove.addEventListener 'click', (e) =>
        local_field = @field(e)
        local_field.value = 0
        local_field.dispatchEvent inputChange
        @field()

      field.addEventListener 'input', ((e) =>
        e.target.closest('form').dispatchEvent @make_event('submit')
      )

  field: (e)->
    e.target.closest(".cart-item").querySelector('.cart-col-quantity input') if e

  sendForm: (e)=>
    if e.preventDefault
      e.preventDefault()
    else
      e.returnValue = false;

    f   = e.target || e.srcElement
    url = f.getAttribute('action')
    meth= f.getAttribute('method') || f.getAttribute('data-method') || 'GET'
    params= @serialize(f)

    xmlhttp =  if window.XMLHttpRequest then new XMLHttpRequest() else new ActiveXObject("Microsoft.XMLHTTP")
    xmlhttp.open(meth.toUpperCase(), url, true)
    xmlhttp.setRequestHeader("Accept",        "application/json")
    xmlhttp.setRequestHeader("Content-type",  "application/x-www-form-urlencoded; charset=UTF-8")
    xmlhttp.onreadystatechange = =>
      if xmlhttp.readyState is 4
        response = JSON.parse(xmlhttp.response || xmlhttp.responseText)
        if xmlhttp.status is 200
          if response.success
            @onSave(response, xmlhttp)
          else # better handling
            @onInvalid(response, xmlhttp)

          if xmlhttp.status is 500
            @onInvalid(response, xmlhttp)
        else
          @onFail(response, xmlhttp)
      return
    xmlhttp.send(params.join('&'))


  onSave: (data) =>
    parser=new DOMParser();
    htmlDoc=parser.parseFromString(data.liquid, "text/html"); # for chrome "text/xml"?

    newCart = htmlDoc.querySelector('#js-cart-content') || htmlDoc.querySelector('#empty-cart');
    oldCart = document.querySelector('#js-cart-content');
    oldCart?.innerHTML = newCart.innerHTML;

    oldErr = document.querySelector('.flash.error .message');
    oldErr?.innerHTML = data.messages;

    count = 0
    count += item.quantity for item in data.items if data.items?
    document.querySelector(".cart-container .cart-items")?.innerHTML = count
    document.querySelector("#submit-to-checkout").remove() if count == 0

    # binds
    document.querySelector('#js-cart-content form[data-remote="true"]')?.addEventListener 'submit', @sendForm
    @initCart();

  onInvalid: (response) ->
    @onSave(response)

  onFail: (response, xhr) ->
    console.log(response)
    console.log(xhr)
    console.log(xhr.status)

  make_event: (type) ->
    try
      return new Event(type, cancelable: true)
    catch
      event = document.createEvent('HTMLEvents')
      event.initEvent(type, true, false)
      return event
  
  serialize: (form) ->
    return  if not form or form.nodeName isnt "FORM"
    i = undefined
    j = undefined
    q = {}
    i = form.elements.length - 1
    while i >= 0
      if !form.elements[i].name or form.elements[i].disabled
        i = i - 1
        continue
      switch form.elements[i].nodeName
        when "INPUT"
          switch form.elements[i].type
            when "text", "password", "button", "reset", "submit", "number"
              q[form.elements[i].name] = encodeURIComponent(form.elements[i].value)
            when "hidden"
              q[form.elements[i].name] = encodeURIComponent(form.elements[i].value) unless q[form.elements[i].name]
            when "checkbox", "radio"
              q[form.elements[i].name] = encodeURIComponent(form.elements[i].value) if form.elements[i].checked
#            when "file"
        when "TEXTAREA"
          q[form.elements[i].name] = encodeURIComponent(form.elements[i].value)
        when "SELECT"
          switch form.elements[i].type
            when "select-one"
              q[form.elements[i].name] = encodeURIComponent(form.elements[i].value)
            when "select-multiple"
              j = form.elements[i].options.length - 1
              while j >= 0
                q[form.elements[i].name] = encodeURIComponent(form.elements[i].options[j].value)  if form.elements[i].options[j].selected
                j = j - 1
        when "BUTTON"
          switch form.elements[i].type
            when "reset", "submit", "button"
              q[form.elements[i].name] = encodeURIComponent(form.elements[i].value)
      i = i - 1

    for k, v of q
      "#{k}=#{v}"
