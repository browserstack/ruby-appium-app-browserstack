require 'rubygems'
require 'appium_lib'
require 'selenium-webdriver'
require 'browserstack/local'

username = 'YOUR_USERNAME'
access_key = 'YOUR_ACCESS_KEY'

caps = {}
# Set your access credentials
caps['browserstack.user'] = username
caps['browserstack.key'] = access_key

# Set URL of the application under test
caps['app'] = 'bs://<app-id>'

# Specify device and os_version for testing
caps['device'] = 'Google Pixel 3'
caps['os_version'] = '9.0'

# Set browserstack.local capability as true
caps['browserstack.local'] = true

# Set other BrowserStack capabilities
caps['project'] = 'First Ruby project'
caps['build'] = 'Ruby Android Local'
caps['name'] = 'local_test'
caps['platformName'] = 'android'
caps['browserstack.debug'] = true

# Start browserstack local
bs_local = BrowserStack::Local.new
bs_local_args = { "key" => access_key }
bs_local.start(bs_local_args)

# Initialize the remote Webdriver using BrowserStack remote URL
# and desired capabilities defined above
appium_driver = Appium::Driver.new({
	'caps' => caps,
	'appium_lib' => {
		:server_url => "http://hub-cloud.browserstack.com/wd/hub"
	}}, true)
driver = appium_driver.start_driver

# Test case for the BrowserStack sample Android app. 
# If you have uploaded your app, update the test case here. 
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

# Invoke driver.quit() after the test is done to indicate that the test is completed.
driver.quit
# Stop browserstack local
bs_local.stop
