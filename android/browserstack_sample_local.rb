require 'rubygems'
require 'appium_lib'
require 'selenium-webdriver'
require 'browserstack/local'

# Set your access credentials
user_name = "BROWSERSTACK_USERNAME"
access_key = "BROWSERSTACK_ACCESS_KEY"

capabilities = {
	# Specify device and os_version for testing
	"platformName" => "android",
	"platformVersion" => "9.0",
	"deviceName" => "Google Pixel 3",

	# Set URL of the application under test
	"app" => "bs://<appID>",

	# Set other BrowserStack capabilities
	'bstack:options' => {
		"projectName" => "First Ruby project",
		"buildName" => "browserstack-build-1",
		"sessionName" => "BStack local_test",
		"debug" => "true",
		"local" => "true",
		"networkLogs" => "true",

		"userName": user_name,
    "accessKey": access_key
	},
}

# Start browserstack local
bs_local = BrowserStack::Local.new
bs_local_args = { "key" => access_key }
bs_local.start(bs_local_args)

# Initialize the remote Webdriver using BrowserStack remote URL
# and desired capabilities defined above
appium_driver = Appium::Driver.new({
	'caps' => capabilities,
	'appium_lib' => {
		:server_url => "http://hub.browserstack.com/wd/hub"
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
