focusErrorInput = (inputId) ->
  $(inputId).closest('.form-group').addClass('has-error')
  $(inputId).focus()

Template.referralSignup.events
  'submit form': (e, t) ->
    e.preventDefault()

    Errors.remove {}

    _.each $('.form-group'), (fg) ->
      $(fg).removeClass('has-error') if $(fg).hasClass('has-error')

    options =
      email: $('#email').val().trim()
      password: $('#password').val()

    if options.email is ''
      notifyError 'Please fill up an email'
      focusErrorInput('#email')
      return

    if options.password is ''
      notifyError 'Please fill up a password'
      focusErrorInput('#password')
      return

    if options.password isnt $('#password_confirmation').val()
      notifyError 'Password is not confirmed'
      focusErrorInput('#password_confirmation')
      return

    Meteor.call 'registerReferee', options, this._id, (err) ->
      if err
        notifyError err.reason
        return

Template.referralSignup.helpers
  errors: ->
    Errors.find()
