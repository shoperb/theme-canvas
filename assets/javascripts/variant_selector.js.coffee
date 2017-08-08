class @VariantSelector

  constructor: ->
    @lang = document.querySelector("meta[http-equiv='content-language']")?.content
    @variantSelector = "[data-variant-select]"
    @counter= new Date().getTime()

    # collecting data from options
    for varSel in document.querySelectorAll(@variantSelector)
      @counter += 1
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
    div = document.createElement("div")
    div_selector = document.createElement("div")
    div_selected = document.createElement("div")
    div.classList.add("variant-selector")
    div_selector.classList.add("variant-select")
    div_selected.classList.add("selected")
    selectList = document.createElement("ul");
    selectList.classList.add("variant-option-dropdown", 'variant-class-'+lname)
    div.innerHTML = '<label class="variant-title">' + lname + '</label>'
    div_selector.innerHTML = '<svg class=\"icon-arrow-down\"><use xmlns:xlink=\"http://www.w3.org/1999/xlink\" xlink:href=\"' + container.dataset.icon + '#icon-arrow-down\"></use></svg>'
    div_selector.appendChild(div_selected)
    div_selector.appendChild(selectList)
    div.appendChild(div_selector)
    container.appendChild(div)
    @toggleVariantSelect(div_selected)

    values = []
    # missing in matrix disabled by config
    # select data-sku
    lis = ""
    for obj in arr
      name   = @getName(obj)
      continue if values.indexOf(name) > -1

      # selectList.appendChild(li)
      lis += "<li orig-value='#{obj.value}'><label for='#{@counter}-attribute-#{name}'><input type='radio' id='#{@counter}-attribute-#{name}' data-attribute-radio name='attribute-#{lname}' value='#{name}'><span>#{name}</span></label></li>"
      values.push name
    selectList.innerHTML = lis
    @generateBoxOnSelect(selectList, lname)
    @generateColorOnSelect(selectList, lname)
    @addEventsOnSelect(selectList, lname)

  generateBoxOnSelect: (list, name)->
    return if shoperb_dropdown_to_box.indexOf(name) == -1
    list.closest('.variant-selector').classList.add("dropdown-box")

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
        @markMissingOptions(e.target)
  # what to do when you have changed option-
  # change option value
  selectNewVariantOnOptionChange: (target)->
    form     = target.closest("form")

    # lookup for selected option
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

  markMissingOptions: (target) ->
    form     = target.closest("form")

    selector = "[data-#{target.name}='#{target.value}']"
    for node in form.querySelectorAll(selector)
#      console.log node
#      console.log node.json
      node.classList.add('marked')

  toggleVariantSelect: (el) ->
    el.onclick = (event) ->
      event.stopPropagation()
      for el in document.querySelectorAll('.variant-selector')
        if el != event.target.closest(".variant-selector")
          el.classList.remove('open')
      this.closest(".variant-selector").classList.toggle('open')
