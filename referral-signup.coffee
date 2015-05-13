Template.referralSignup.events
  'click #submitReferralSignup': (e, t) ->
    options =
      email: $('#email').val().trim()
      password: $('#password').val()

    Meteor.call 'registerReferee', options, this._id, (err) ->
      if err
        # TODO: should notify error
        console.log err.reason
