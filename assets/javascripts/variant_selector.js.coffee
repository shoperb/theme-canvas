class @VariantSelector

  constructor: ->
    @lang = document.querySelector("meta[http-equiv='content-language']")?.content
    @variantSelector = "[data-variant-select]"

    # collecting data from options
    for varSel in document.querySelectorAll(@variantSelector)
      container = varSel.closest('form').querySelector('[data-variant-container]')

      @variantOptions = {}
      for opt in varSel.querySelectorAll("option")
        @parseOption(opt)
      for id, value of @variantOptions
        @generateOptionSelect(id, value, container)
      
      # check radio-buttons once page loaded
      json = varSel.querySelector("option[value='#{varSel.value}']").json
      for attr in json.attributes
        for radio in container.querySelectorAll("input[name='attribute-#{attr.name.toLowerCase()}']")
          if radio.value == @getName(attr)
            radio.checked = true
            @changeSelectedVariantOption(radio)
          else
            radio.checked = false

  parseOption: (opt)->
    if (js = opt.getAttribute("data-variant"))?
      json = JSON.parse(js)
      for attr in json.attributes
        # updating options to select easier later
        opt.setAttribute("data-attribute-#{attr.name}", @getName(attr))
        opt.json = json
        aname = attr.name.toLowerCase()
        @variantOptions[aname] ?= []
        @variantOptions[aname].push(attr)

  getName: (obj)->
    obj.value # system does translation itself
    # obj.translations?[@lang]?.value || obj.value

  generateOptionSelect: (lname, arr, container)->
    # add selector data-behavior-box-select
    div   = document.createElement("div")
    div_s = document.createElement("div")
    div.classList.add("variant-selector")
    div_s.classList.add("selected")
    selectList = document.createElement("ul");
    selectList.classList.add("variant-option-dropdown")
    selectList.classList.add(lname)
    div.innerHTML = '<svg class=\"icon-arrow-down\"><use xmlns:xlink=\"http://www.w3.org/1999/xlink\" xlink:href=\"/system/assets/images/icons.svg#icon-arrow-down\"></use></svg>'
    div.appendChild(div_s)
    div.appendChild(selectList)
    container.appendChild(div)
    @toggleVariantSelect(div_s)

    values = []
    # missing in matrix disabled by config
    # select data-sku
    lis = ""
    for obj in arr
      name   = @getName(obj)
      continue if values.indexOf(name) > -1

      # selectList.appendChild(li)
      lis += "<li orig-value='#{obj.value}'><label for='attribute-#{name}'><input type='radio' id='attribute-#{name}' data-attribute-radio name='attribute-#{lname}' value='#{name}'><span>#{name}</span></label></li>"
      values.push name
    selectList.innerHTML = lis
    @generateBoxOnSelect(selectList,lname)
    @generateColorOnSelect(selectList,lname)
    @addEventsOnSelect(selectList,lname)

  generateBoxOnSelect: (list, name)->
    return if shoperb_dropdown_to_box.indexOf(name) == -1
    list.classList.add("dropdown-box")

  generateColorOnSelect: (list, name)->
    return if shoperb_color_boxes.indexOf(name) == -1
    list.classList.add("dropdown-color")
    for el in list.querySelectorAll('li')
      if val = shoperb_colors[el.getAttribute('orig-value').toLowerCase()]
        el.style.background = val

  # for options select 
  addEventsOnSelect: (list, name)->
    for input in list.querySelectorAll('input')
      input.addEventListener 'change', (e)=>
        @selectNewVariantOnOptionChange(e.target)
        @changeSelectedVariantOption(e.target)
  # what to do when you have changed option-
  # change option value
  selectNewVariantOnOptionChange: (target)->
    form     = target.closest("form")
    selector = ""
    for inp in form.querySelectorAll("[data-attribute-radio]:checked")
      selector+="[data-#{inp.name}='#{inp.value}']"
    if opt = form.querySelector(selector)
      form.querySelector(@variantSelector).value = opt.value
    else
      alert "Didn't find option"

  changeSelectedVariantOption: (target)->
    if node = target.closest(".variant-selector").querySelector(".selected")
      node.textContent = target.value

  toggleVariantSelect: (el) ->
    el.onclick = (event) ->
      event.stopPropagation()
      for el in document.querySelectorAll('.variant-selector')
        if el != event.target.closest(".variant-selector")
          el.classList.remove('open')
      this.closest(".variant-selector").classList.toggle('open')
