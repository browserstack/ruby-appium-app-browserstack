require 'rubygems'
require 'appium_lib'
require 'selenium-webdriver'
require 'browserstack/local'

username = 'BROWSERSTACK_USERNAME'
access_key = 'BROWSERSTACK_ACCESS_KEY'

caps = {}
caps['build'] = 'Ruby Appium Sample'
caps['name'] = 'local_test'
caps['device'] = 'Google Pixel'
caps['realMobile'] = true
caps['browserstack.local'] = true
caps['browserstack.debug'] = true
caps['app'] = 'bs://<hashed app-id>'

bs_local = BrowserStack::Local.new
bs_local_args = { "key" => access_key }
bs_local.start(bs_local_args)

appium_driver = Appium::Driver.new({
	'caps' => caps,
	'appium_lib' => {
		:server_url => "http://#{username}:#{access_key}@hub-cloud.browserstack.com/wd/hub"
	}}, true)
driver = appium_driver.start_driver

wait = Selenium::WebDriver::Wait.new(:timeout => 30)
wait.until { driver.find_element(:id, "com.example.android.basicnetworking:id/test_action").displayed? }
element = driver.find_element(:id, "com.example.android.basicnetworking:id/test_action")
element.click

wait.until { driver.find_element(:class, "android.widget.TextView").displayed? }
text_elements = driver.find_elements(:class, "android.widget.TextView")

if text_elements.map(&:text).any?{|x| x.match('Up and running')}
  puts "Up and Running - Test Passed"
else
  puts "Local Testing setup not working - Test Failed"
end

driver.quit
bs_local.stop
