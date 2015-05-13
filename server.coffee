referrerName = (referrer) ->
  if referrer.profile and referrer.profile.firstName
    referrer.profile.firstName
  else if referrer.username
    referrer.username
  else
    referrer.emails[0].address

if Meteor.isServer
  Meteor.methods
    # generateReferralIdFor() should be called after successful signup
    # if bare registration is used, should be called after Account.createUser
    # if third party authentication system is used, need to hook
    # e.g. for useraccounts
    # AccountsTemplates.configure
    #   onSubmitHook: (err, state) ->
    #     if !err
    #       if state == 'signUp'
    #         Meteor.call 'generateReferralIdFor', Meteor.userId()
    generateReferralIdFor: (userId) ->
      ReferralIds.insert userId: userId

    referByEmail: (email) ->
      referrer = Meteor.user()
      throw new Meteor.Error 422, "Access denied." unless referrer
      # send an invitation email to email recipient

      referralId  = ReferralIds.findOne(userId: referrer._id)._id
      referralUrl = "#{Referral.config.product.hostUrl}/referral/#{referralId}"

      # TODO: make the whole email customizable at will
      Email.send
        to: email,
        from: Referral.config.email.from,
        subject: "#{referrerName referrer} invited you to #{Referral.config.product.name}"
        text: "#{referrerName referrer} wants you to try #{Referral.config.product.name}.
        #{Referral.config.product.description}.
        Click #{referralUrl} to sign up an account now.
        - The #{Referral.config.product.name} team"
      # record referral with referrer id and referee's email
      referral = Referrals.findOne { email: email }
      throw new Meteor.Error 422, "Referee with email: '" + email + "' exists" if referral

      Referrals.insert
        email: email
        referrerId: referrer._id

    registerReferee: (options, referralId) ->
      userId = Accounts.createUser options
      referral = Referrals.findOne { email: options.email }
      if referral
        Referrals.update { email: options.email }, { $set: refereeId: userId }
      else
        # this is referByLink / referByReferralId
        referralId = ReferralIds.findOne({ _id: referralId })
        if referralId
          Referrals.insert
            email: options.email
            referrerId: referralId.userId
            refereeId: userId
        else
          throw new Meteor.Error 404, 'Referral not found'
