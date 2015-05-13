Package.describe({
  name: 'keryi:meteor-referral',
  version: '0.0.1',
  summary: 'A simple referral system for Meteor',
  git: '',
  documentation: 'README.md'
});

var both = ['client', 'server'];

Package.onUse(function(api) {
  api.versionsFrom('1.1.0.2');
  api.use('coffeescript');
  api.use('accounts-base');
  api.use('mongo');
  api.use('email');
  api.use('templating');
  api.use('iron:router@1.0.7')
  api.use('aldeed:collection2@2.3.3');
  api.use('aldeed:simple-schema@1.3.2');
  api.addFiles('config.coffee', 'server');
  api.addFiles('referral-controller.coffee', both);
  api.addFiles('referral-signup.html', 'client');
  api.addFiles('referral-signup.coffee', 'client');
  api.addFiles('referrals.coffee', both);
  api.addFiles('referralIds.coffee', both);
  api.addFiles('publications.coffee', 'server');
  api.addFiles('server.coffee', 'server');
});

Package.onTest(function(api) {
  api.use('coffeescript');
  api.use('tinytest');
  api.use('accounts-base');
  api.use('accounts-password');
  api.use('digilord:faker@1.0.3');
  api.use('keryi:meteor-referral');
  api.addFiles('test-data.coffee', 'server');
  api.addFiles('meteor-referral-tests.js', 'server');
});
