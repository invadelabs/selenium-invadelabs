require 'selenium-webdriver'
require 'rspec/expectations'
require 'sendgrid-ruby'

include SendGrid

include RSpec::Matchers

def setup
  @driver = Selenium::WebDriver.for(
    :remote,
    url: 'http://localhost:4444/wd/hub',
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

  @driver.find_element(:css, 'i.icon-reorder').click
  # expect(@driver.find_element(:link, 'Menu').text).to eql 'Menu'

  # @driver.find_element(:link, "Contact Me").click
  # expect(@driver.find_element(:link, 'Find owners').text).to eql 'Find owners'

  t = Time.now
  t_proc = t.strftime '%Y.%m.%d.%H.%M.%S%z'

  screenshot_name = "chrome_invadelabs.com.#{t_proc}.png"
  @driver.save_screenshot(screenshot_name)

  # Email the screenshot via sendgrid
  mail = Mail.new
  mail.from = Email.new(email: 'testing@invadelabs.com')
  mail.subject = "invadelabs.com #{screenshot_name}"

  personalization2 = Personalization.new
  # personalization2.add_to(Email.new(email: 'drewderivative@gmail.com', name: 'Drew'))
  personalization2.add_to(Email.new(email: 'drewderivative@gmail.com'))
  # personalization2.subject = 'Hello World from the Personalized SendGrid Ruby Library'
  mail.add_personalization(personalization2)

  # mail.add_content(Content.new(type: 'text/plain', value: 'some text here'))
  mail.add_content(Content.new(type: 'text/html', value: "<html><body>invadelabs.com #{screenshot_name}</body></html>"))

  attachment = Attachment.new
  attachment.content = Base64.strict_encode64(File.open(screenshot_name, 'rb').read)
  attachment.type = 'image/png'
  attachment.filename = screenshot_name
  attachment.disposition = 'attachment'
  attachment.content_id = 'Screenshot'
  mail.add_attachment(attachment)

  # leaving this out due to base64 encoding adding 600k to output
  # puts JSON.pretty_generate(mail.to_json)
  # puts mail.to_json

  sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'], host: 'https://api.sendgrid.com')
  response = sg.client.mail._('send').post(request_body: mail.to_json)
  puts response.status_code
  puts response.body
  puts response.headers
end
