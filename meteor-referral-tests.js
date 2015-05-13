Meteor.user = function() {
  return Meteor.users.findOne();
}

Tinytest.add('Refer by email', function(test) {
  Referrals.remove({});
  var referrer = Meteor.users.findOne();
  var email = faker.internet.email();
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
  test.equal(referral.refereeId, refereeId);
});

Tinytest.add('Register referee by referral link', function(test) {
  
});

Tinytest.add('Generate referral Id', function(test) {
  Meteor.call('generateReferralId', '1');
  var referralId = ReferralIds.findOne({ userId: '1' });
  test.isNotNulL(referralId);
  test.equal(referralId.userId, '1');

  test.throw(Meteor.call('generateReferralId', '1'));
});
