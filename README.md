selenium-invadelabs [![Build Status](https://travis-ci.org/invadelabs/selenium-invadelabs.svg?branch=master)](https://travis-ci.org/invadelabs/selenium-invadelabs) [![Coverage Status](https://coveralls.io/repos/github/invadelabs/selenium-invadelabs/badge.svg)](https://coveralls.io/github/invadelabs/selenium-invadelabs)
===================

Triggered via travisci from commits to invadelabs.com repo and sends a screenshot from Selenium tests to Slack.

## Spin up if testing on local
```
docker run -d -p 4444:4444 -v /dev/shm:/dev/shm selenium/standalone-chrome:3.14.0-arsenic
docker run -d -p 4445:4444 -v /dev/shm:/dev/shm selenium/standalone-firefox:3.14.0-arsenic
```

## Install Firefox 54 or earlier for Selenium IDE
Selenium IDE isn't supported on Firefox >= 55
https://ftp.mozilla.org/pub/firefox/releases/54.0/linux-x86_64/en-US/firefox-54.0.tar.bz2

Download Firefox 54, create a new profile, and disable automatic updates.
```
tar jxvf firefox-54.0.tar.gz
./firefox-bin --ProfileManager --new-instance
Options > Preferences > Select the Advanced panel > Select the Update tab.
Check Never check for updates
```

## Install selenium-ide extension
https://addons.mozilla.org/en-US/firefox/addon/selenium-ide/

## Use Selenium IDE in Firefox
`Developer > Selenium IDE > Record`

## Install optipng, ruby-2.5.5, and gems
```
sudo apt-get install optipng
rbenv global 2.5.5
bundle install
```

## Test Locally
Generate a screenshot from our tests with output files `chrome_#{time}.png` and `firefox_#{time}.png` then slack / and or email them.
```
export SENDGRID_API_KEY="my awesome key"
export SLACK_API_TOKEN="my awesome key"
ruby ./selenium.rb
```
