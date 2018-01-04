# filename: chrome_test.rb

require 'selenium-webdriver'
require 'rspec/expectations'
include RSpec::Matchers

def setup
  @driver = Selenium::WebDriver.for(
    :remote,
    url: 'http://192.168.1.125:4444/wd/hub',
    desired_capabilities: :chrome
  )
end

def teardown
  @driver.quit
end

def run
  setup
  yield
  teardown
end

run do
  @driver.get('http://invadelabs.com/')
  expect(@driver.title).to eql 'invadelabs.com'

  @driver.find_element(:css, "i.icon-reorder").click
  # expect(@driver.find_element(:link, 'Menu').text).to eql 'Menu'

  # @driver.find_element(:link, "Contact Me").click
  # expect(@driver.find_element(:link, 'Find owners').text).to eql 'Find owners'

  t = Time.now
  t_proc =  t.strftime "%Y.%m.%d.%H.%M.%S%z"

  @driver.save_screenshot("chrome_invadelabs.com.#{t_proc}.png")
end
