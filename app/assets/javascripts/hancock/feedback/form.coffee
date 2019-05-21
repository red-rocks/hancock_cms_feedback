window.hancock_cms.feedback.create_ajax_form = (form_selector = "#new_hancock_feedback_contact_message",
                                                wrapper_selector = "#hancock_feedback_contact_form")->

  $(document).on "ajax:send", form_selector, ()->
    $(form_selector).closest(wrapper_selector).addClass("hancock-ajax-sended")

  $(document).on "ajax:complete", form_selector, (event, xhr, status)->
    data = xhr.responseText
    wrapper = $(form_selector).closest(wrapper_selector).removeClass("hancock-ajax-sended")
    if $(data).find(".recaptcha_error").length > 0 or $(data).find(".fields_block").length == 0
      wrapper.html(data)
      window.hancock_cms.feedback.recaptcha_render(form_selector)
    else
      wrapper.find(".fields_block").replaceWith($(data).find(".fields_block"))

  $(document).on 'click, focus', form_selector + " .input", (e) ->
    $(e.currentTarget).removeClass("field_with_errors").find('.error').hide()



window.hancock_cms.feedback.set_feedback_form_reloader = (link_selector = "#hancock_cms_feedback_success .reload_feedback_form_link",
                                                          wrapper_selector = '#hancock_cms_feedback_success') ->

  $(document).delegate link_selector, 'click', (e) ->
    e.preventDefault()
    $(wrapper_selector).addClass('hancock-form-reload')
    $.get e.currentTarget.href, (data)->
      wrapper_data = $(data).find(wrapper_selector)
      if wrapper_data.length > 0
        $(wrapper_selector).replaceWith(wrapper_data)
      else
        $(wrapper_selector).replaceWith(data)
      window.hancock_cms.feedback.recaptcha_render(wrapper_selector)



window.hancock_cms.feedback.recaptcha_autoclick = (form_selector = "#new_hancock_feedback_contact_message")->
  $(form_selector).find(".recaptcha-checkbox-checkmark").click()

window.hancock_cms.feedback.recaptcha_render = (form_selector = "#new_hancock_feedback_contact_message")->
  if window.grecaptcha
    recaptcha = $(form_selector).find(".g-recaptcha")
    if recaptcha.length > 0 and 
      params = {
        sitekey:            recaptcha.data("sitekey"),
        theme:              recaptcha.data("theme"),
        type:               recaptcha.data("type"),
        size:               recaptcha.data("size"),
        tabindex:           recaptcha.data("tabindex"),
        callback:           recaptcha.data("callback"),
        'expired-callback': recaptcha.data("expired-callback")
      }
      window.grecaptcha.render(recaptcha[0], params)

window.hancock_cms.feedback.recaptcha_reset = ->
  window.grecaptcha and window.grecaptcha.reset()
