if Meteor.isServer
  Meteor.startup ->
    if Meteor.users.find().count() == 0
      userId = Accounts.createUser
        email: faker.internet.email()
      Accounts.setPassword userId, 'password'
      ReferralIds.insert
        userId: userId
