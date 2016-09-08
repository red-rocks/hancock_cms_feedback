window.hancock_cms.feedback.create_ajax_form = (form_selector = "#new_hancock_feedback_contact_message", wrapper_selector = "#hancock_feedback_contact_form" )->

  $(document).delegate form_selector, "ajax:complete", (event, xhr, status)->
    $(event.currentTarget).closest(wrapper_selector).html(xhr.responseText)

  $(document).delegate form_selector + " .input", 'click', (e) ->
    e.preventDefault()
    $(e.currentTarget).removeClass("field_with_errors").find('span.error').hide()
    return false


window.hancock_cms.feedback.set_update_captcha = (link_selector = "#new_hancock_feedback_contact_message .update_captcha_link", captcha_selector = "#new_hancock_feedback_contact_message .simple_captcha") ->
  $(document).delegate link_selector, 'click', (e) ->
    e.preventDefault()
    $(captcha_selector).animate(opacity: 0.01, 100)
    $.get e.currentTarget.href, (data)->
      $(data).find('img').load ->
        $(captcha_selector).stop().css(opacity: 0.01).replaceWith(data).find('input[type=text]').focus()
    return false

  $(document).delegate captcha_selector + " img", 'dblclick', (e)->
    e.preventDefault()
    $(link_selector).trigger 'click'
    return false
