class @Cart
#  constructor: ->
#    for form in document.querySelectorAll("form[data-remote='true']")
#      $(form).on 'submit', @sendForm
#    @initCart()
#
#
#  initCart: =>
#    $('.cart-item').each () ->
#      increase = $('[data-quantity=increase]', this)
#      decrease = $('[data-quantity=decrease]', this)
#      remove = $('[data-remove-item]', this)
#      field = $('.cart-col-quantity input', this);
#
#      increase.on 'click', ->
#        field.val parseInt(field.val(), 10) + 1
#        field.trigger 'input'
#
#      decrease.on 'click', ->
#        newVal = parseInt(field.val(), 10) - 1
#        if newVal < 0
#          newVal = 0
#        field.val newVal
#        field.trigger 'input'
#
#      remove.on 'click', ->
#        field.val 0
#        field.trigger 'input'
#
#      field.on 'input', (e) ->
#        $(e.target).closest("form").trigger('submit')
#        @sendForm
#
#  sendForm: (e)=>
#    if e.preventDefault
#      e.preventDefault()
#    else
#      e.returnValue = false;
#
#    f     = $(e.target)
#    url   = f.attr('action')
#    meth  = f.attr('method') || f.data('method') || 'GET'
#    params= f.serialize()
#
#
#    $.ajax({
#      method: meth,
#      url:    url,
#      data:   params,
#      dataType: 'json'
#    }).done( ( data )=>
#      newCart = $(data.liquid).find('#js-cart-content');
#      oldCart = $('#js-cart-content');
#      oldCart.html(newCart);
#
#      oldErr = $('.flash.error .message');
#      oldErr.html(data.messages);
#
#      count = 0
#      count += item.quantity for item in data.items
#      $(".cart-container .cart-items").html(count)
#
#      # binds
#      $('#js-cart-content').find("form[data-remote='true']").on 'submit', @sendForm
#      @initCart();
#    );



# class @Cart
#   constructor: ->
#     for form in document.querySelectorAll("form[data-remote='true']")
#       form.addEventListener 'submit', @sendForm


#   sendForm: (e)=>
#     if e.preventDefault
#       e.preventDefault()
#     else
#       e.returnValue = false;

#     f   = e.target || e.srcElement
#     url = f.getAttribute('action')
#     meth= f.getAttribute('method') || f.getAttribute('data-method') || 'GET'
#     params= serialize(f)

#     xmlhttp =  if window.XMLHttpRequest then new XMLHttpRequest() else new ActiveXObject("Microsoft.XMLHTTP")
#     xmlhttp.open(meth.toUpperCase(), url, true)
#     xmlhttp.setRequestHeader("Accept",        "application/json")
#     xmlhttp.setRequestHeader("Content-type",  "application/x-www-form-urlencoded; charset=UTF-8")
#     xmlhttp.onreadystatechange = =>
#       if xmlhttp.readyState is 4
#         response = JSON.parse(xmlhttp.response || xmlhttp.responseText)
#         if xmlhttp.status is 200
#           if response.success
#             @onSave(response, xmlhttp)
#           else # better handling
#             @onInvalid(response, xmlhttp)

#           if xmlhttp.status is 500
#             @onInvalid(response, xmlhttp)
#         else
#           @onFail(response, xmlhttp)
#       return

#     button = document.querySelector('[data-type=payment]')
#     button.disabled = true if button
#     xmlhttp.send(params.join('&'))


#   onSave: (response) =>
#     debugger
#     window.location = response.redirect if response.redirect

#     @setJS()

#   onInvalid: (response) ->
#     @onSave(response)

#   onFail: (response, xhr) ->
#     console.log(response)
#     console.log(xhr)
#     console.log(xhr.status)

#   setJS: ->
#     # TODO: add reinits here

#   serialize = (form) ->
#     return  if not form or form.nodeName isnt "FORM"
#     i = undefined
#     j = undefined
#     q = {}
#     i = form.elements.length - 1
#     while i >= 0
#       if !form.elements[i].name or form.elements[i].disabled
#         i = i - 1
#         continue
#       switch form.elements[i].nodeName
#         when "INPUT"
#           switch form.elements[i].type
#             when "text", "password", "button", "reset", "submit"
#               q[form.elements[i].name] = encodeURIComponent(form.elements[i].value)
#             when "hidden"
#               q[form.elements[i].name] = encodeURIComponent(form.elements[i].value) unless q[form.elements[i].name]
#             when "checkbox", "radio"
#               q[form.elements[i].name] = encodeURIComponent(form.elements[i].value) if form.elements[i].checked
# #            when "file"
#         when "TEXTAREA"
#           q[form.elements[i].name] = encodeURIComponent(form.elements[i].value)
#         when "SELECT"
#           switch form.elements[i].type
#             when "select-one"
#               q[form.elements[i].name] = encodeURIComponent(form.elements[i].value)
#             when "select-multiple"
#               j = form.elements[i].options.length - 1
#               while j >= 0
#                 q[form.elements[i].name] = encodeURIComponent(form.elements[i].options[j].value)  if form.elements[i].options[j].selected
#                 j = j - 1
#         when "BUTTON"
#           switch form.elements[i].type
#             when "reset", "submit", "button"
#               q[form.elements[i].name] = encodeURIComponent(form.elements[i].value)
#       i = i - 1


#     for k, v of q
#       "#{k}=#{v}"

