class @VariantSelector

  constructor: (selector) ->
    @lang = document.querySelector("meta[http-equiv='content-language']")?.content
    @variantSelector = "[data-variant-select]"
    @counter= new Date().getTime()

    # collecting data from options
    for varSel in document.querySelectorAll(selector+" "+@variantSelector)
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
            @markMissingOptions(radio)
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
    if container.closest('form').querySelector('[data-variant-select]').dataset.showLabels == 'true'
      div.innerHTML = '<label class="variant-title">' + lname + '</label>'
    div_selector.innerHTML = '<svg class=\"icon-full-arrow-down\"><use xmlns:xlink=\"http://www.w3.org/1999/xlink\" xlink:href=\"' + container.dataset.icon + '#icon-full-arrow-down\"></use></svg>'
    div_selector.appendChild(div_selected)
    div_selector.appendChild(selectList)
    div.appendChild(div_selector)
    container.appendChild(div)
    @toggleVariantSelect(div_selected)

    values = []
    # missing in matrix disabled by config
    lis = ""
    for obj in arr
      name = @getName(obj)
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
      @switchVariantData(target, opt)
    else
      alert "Didn't find option"

  changeSelectedVariantOption: (target)->
    if node = target.closest(".variant-selector").querySelector(".selected")
      node.textContent = target.value
      for el in target.closest(".variant-selector .variant-option-dropdown").querySelectorAll('li')
        el.classList.remove('active')
      target.closest(".variant-selector").querySelector(".variant-option-dropdown li[orig-value='" + target.value + "']").classList.add('active')

  markMissingOptions: (target) ->
    form = target.closest("form")

    # uncheck all dropdown elements
    for dropdown_input in form.querySelectorAll("[data-attribute-radio]")
      dropdown_input.closest('li').classList.remove('not-present')

    # collect all possible values
    attrs = {}
    for node in form.querySelectorAll("[data-#{target.name}='#{target.value}']")
      continue if node.json.stock == 0 # if not tracking then value is null
      for attr in node.json.attributes
        continue if ("attribute-" + attr.name) == target.name # comment out if merk on both sides
        attrs[attr.name] ?= []
        attrs[attr.name].push(attr.value) if attrs[attr.name].indexOf(attr.value) == -1

    # mark not existing variants
    for name, vals of attrs
      for dropdown_input in form.querySelectorAll("[data-attribute-radio][name='attribute-#{name}']")
        if vals.indexOf(dropdown_input.value) == -1
          dropdown_input.closest('li').classList.add('not-present')


  toggleVariantSelect: (el) ->
    el.onclick = (event) ->
      event.stopPropagation()
      for el in document.querySelectorAll('.variant-selector')
        if el != event.target.closest(".variant-selector")
          el.classList.remove('open')
      this.closest(".variant-selector").classList.toggle('open')

  switchVariantData: (el, opt) ->
    container = el.closest('[data-product-form]').parentNode
    if node = container.querySelector('[data-variant-sku-container]')
      node.querySelector('[data-variant-sku]').innerHTML = opt.json.sku
      if opt.json.sku?
        node.classList.add('visible')
      else
        node.classList.remove('visible')

    container.querySelector('[data-current-price]').innerHTML = opt.dataset.price
    if opt.dataset.discount_price
      container.querySelector('[data-price]').innerHTML = opt.dataset.price
      container.querySelector('[data-current-price]').innerHTML = opt.dataset.discount_price
      container.querySelector('.compare-price').classList.add('visible')
      container.querySelector('.actual-price').classList.add('discount')
    else
      container.querySelector('.compare-price').classList.remove('visible')
      container.querySelector('.actual-price').classList.remove('discount')
