@ReferralIds = new Mongo.Collection 'referral_ids'

# Initial thought is to
# Meteor.users.update {_id: userId}, {$set: referralId: random(id)}
# But try not to pollute the original documents, hence
# creating a document using referencing

# ReferralId._id is the referral_id to be userd in the referral link
Schemas.ReferralId =
  userId:
    type: String
    unique: true

ReferralIds.attachSchema Schemas.ReferralId
