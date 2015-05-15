@Referrals = new Mongo.Collection 'referrals'

@Schemas = {}
Schemas.Referral = new SimpleSchema
  # Person who refer others
  referrerId:
    type: String

  # Person who is being referred
  # When it is not null, referral is complete
  refereeId:
    type: String,
    defaultValue: null,
    optional: true

  email:
    type: String,
    regEx: SimpleSchema.RegEx.Email,
    unique: true

  createdAt:
    type: Date,
    autoValue: ->
      if this.isInsert
        return new Date;
      else if this.isUpsert
        return { $setOnInsert: new Date };
      else
        this.unset();

Referrals.attachSchema Schemas.Referral
