Meteor.user = function() {
  return Meteor.users.findOne();
}

Tinytest.add('Refer by email', function(test) {
  Referrals.remove({});
  ReferralIds.remove({});
  var referrer = Meteor.users.findOne();
  var email = faker.internet.email();
  ReferralIds.insert({
    userId: referrer._id
  });
  Meteor.call('referByEmail', email);
  test.equal(Referrals.find().count(), 1);
  var referral = Referrals.findOne();
  test.equal(referral.referrerId, referrer._id);
  test.equal(referral.email, email);
  test.isNull(referral.refereeId);
});

Tinytest.add('Register referee by email referral', function(test) {
  var email = faker.internet.email();
  var referrer = Meteor.users.findOne();
  var referralId = Referrals.insert({
    referrerId: referrer._id,
    email: email
  });
  var options = {
    email: email,
    password: 'password'
  };
  Meteor.call('registerReferee', options, referralId);
  var referral = Referrals.findOne({ email: email });
  var referee = Meteor.users.findOne({ _id: referral.refereeId });
  test.equal(referral.refereeId, referee._id);
});

Tinytest.add('Register referee by referral link', function(test) {
  // TODO
});

Tinytest.add('Generate referral Id', function(test) {
  Referrals.remove({});
  ReferralIds.remove({});
  var userId = _.random(99999999).toString();
  Meteor.call('generateReferralIdFor', userId);
  var referralId = ReferralIds.findOne({ userId: userId });
  test.isNotNull(referralId);
  test.equal(referralId.userId, userId);

  test.throws(function() {
    Meteor.call('generateReferralIdFor', userId)
  });
});
