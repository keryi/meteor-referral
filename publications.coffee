Meteor.publish 'referralId', (id) ->
  return ReferralIds.find { _id: id }, { fields: { userId: 0 } }
