Router.map ->
  @route 'referralSignup',
    path: '/referral/:_id',
    waitOn: ->
      return Meteor.subscribe 'referralId', this.params._id
    data: ->
      return ReferralIds.findOne this.params._id
