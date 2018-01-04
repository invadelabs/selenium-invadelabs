selenium-invadelabs
===================
Selenium dockerized with Stand Alone Chrome and Firefox on separate ports.

## Start Chrome Stand Alone Selenium
```
docker run -d -p 4444:4444 -v /dev/shm:/dev/shm selenium/standalone-chrome:3.8.1-chlorine
```

## Start Firefox Stand Alone Selenium
```
docker run -d -p 4445:4444 -v /dev/shm:/dev/shm selenium/standalone-firefox:3.8.1-chlorine
```

## Use Firefox 54 or earlier
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

## Install selenium-webdriver and rspec gems
```
rvm use latest
gem install selenium-webdriver
gem install rspec
```

## Test
Generate a screenshot from our tests with output files `chrome_#{time}.png` and `firefox_#{time}.png`
```
ruby ./chrome.rb
ruby ./firefox.rb
```
