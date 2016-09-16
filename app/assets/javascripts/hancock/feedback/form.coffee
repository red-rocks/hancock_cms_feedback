window.hancock_cms.feedback.create_ajax_form = (form_selector = "#new_hancock_feedback_contact_message",
                                                wrapper_selector = "#hancock_feedback_contact_form",
                                                animate = true)->

  if animate
    $(document).delegate form_selector, "ajax:send", ()->
      $(form_selector).animate(opacity: 0.01, 100)

    $(document).delegate form_selector, "ajax:complete", (event, xhr, status)->
      data = xhr.responseText
      if $(data).find('img').length > 0
        $(data).find('img').load ->
          $(form_selector).closest(wrapper_selector).stop().css(opacity: 0.01).replaceWith(data).css(opacity: "")
      else
        $(form_selector).closest(wrapper_selector).stop().css(opacity: 0.01).replaceWith(data).css(opacity: "")

  else
    $(document).delegate form_selector, "ajax:complete", (event, xhr, status)->
      $(form_selector).closest(wrapper_selector).replaceWith(xhr.responseText)


  $(document).delegate form_selector + " .input", 'click', (e) ->
    e.preventDefault()
    $(e.currentTarget).removeClass("field_with_errors").find('span.error').hide()
    return false


window.hancock_cms.feedback.set_update_captcha = (link_selector = "#new_hancock_feedback_contact_message .update_captcha_link",
                                                  captcha_selector = "#new_hancock_feedback_contact_message .simple_captcha",
                                                  animate = true) ->
  if animate
    $(document).delegate link_selector, 'click', (e) ->
      e.preventDefault()
      $(captcha_selector).animate(opacity: 0.01, 100)
      $.get e.currentTarget.href, (data)->
        $(data).find('img').load ->
          $(captcha_selector).stop().css(opacity: 0.01).replaceWith(data).find('input[type=text]').focus()

  else
    $(document).delegate link_selector, 'click', (e) ->
      e.preventDefault()
      $.get e.currentTarget.href, (data)->
          $(captcha_selector).replaceWith(data).find('input[type=text]').focus()

  $(document).delegate captcha_selector + " img", 'dblclick', (e)->
    e.preventDefault()
    $(link_selector).trigger 'click'
    return false



window.hancock_cms.feedback.set_feedback_form_reloader = (link_selector = "#hancock_cms_feedback_success .reload_feedback_form_link",
                                                          wrapper_selector = '#hancock_cms_feedback_success',
                                                          wrapper_form = $("<div id='hancock_cms_feedback_success'></div>"),
                                                          animate = true) ->
  if animate
    $(document).delegate link_selector, 'click', (e) ->
      e.preventDefault()
      $(wrapper_selector).animate(opacity: 0.01, 100)
      $.get e.currentTarget.href, (data)->
        data = wrapper_form.html(data)[0].outerHTML
        if $(data).find('img').length > 0
          $(data).find('img').load ->
            $(wrapper_selector).stop().css(opacity: 0.01).replaceWith(data).find('input[type=text]').focus()
        else
          $(wrapper_selector).stop().css(opacity: 0.01).replaceWith(data).find('input[type=text]').focus()
  else
    $(document).delegate link_selector, 'click', (e) ->
      e.preventDefault()
      $.get e.currentTarget.href, (data)->
        data = wrapper_form.html(data)[0].outerHTML
        if $(data).find('img').length > 0
          $(data).find('img').load ->
            $(wrapper_selector).replaceWith(data).find('input[type=text]').focus()
        else
          $(wrapper_selector).replaceWith(data).find('input[type=text]').focus()
