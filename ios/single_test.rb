require 'rubygems'
require 'appium_lib'
require 'selenium-webdriver'

username = 'BROWSERSTACK_USERNAME'
access_key = 'BROWSERSTACK_ACCESS_KEY'

caps = {}
caps['build'] = 'Ruby Appium Sample'
caps['name'] = 'single_test'
caps['device'] = 'iPhone 7 Plus'
caps['platformName'] = 'iOS'
caps['browserstack.debug'] = true
caps['app'] = 'bs://<hashed app-id>'

appium_driver = Appium::Driver.new({
	'caps' => caps,
	'appium_lib' => {
		:server_url => "http://#{username}:#{access_key}@hub-cloud.browserstack.com/wd/hub"
	}}, true)
driver = appium_driver.start_driver

wait = Selenium::WebDriver::Wait.new(:timeout => 30)
wait.until { driver.find_element(:accessibility_id, "Log In").displayed? }
login_button = driver.find_element(:accessibility_id, "Log In")
login_button.click

wait.until { driver.find_element(:accessibility_id, "Email address").displayed? }
email_input = driver.find_element(:accessibility_id, "Email address")
email_input.send_keys("hello@browserstack.com")

wait.until { driver.find_element(:accessibility_id, "Next").displayed? }
driver.find_element(:accessibility_id, "Next").click
sleep 5

results = driver.find_elements(:xpath, "//XCUIElementTypeStaticText")
if results.map(&:text).any?{|x| !x.nil? && x.match('not registered on WordPress.com')}
  puts "Test Passed"
else
  puts "Test Failed"
end

driver.quit
