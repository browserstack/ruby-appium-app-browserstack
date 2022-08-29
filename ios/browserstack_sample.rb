require 'rubygems'
require 'appium_lib'
require 'selenium-webdriver'

capabilities = {
	# Specify device and os_version for testing
	"platformName" => "iOS",
	"platformVersion" => "13",
	"deviceName" => "iPhone 11 Pro",

	# Set URL of the application under test
	"app" => "bs://bs://<appID>",

	# Set other BrowserStack capabilities
	'bstack:options' => {
		"projectName" => "First Ruby project",
		"buildName" => "browserstack-build-1",
		"sessionName" => "single_test",
		"debug" => "true",
		"networkLogs" => "true",

		# Set your access credentials
		"userName": "BROWSERSTACK_USERNAME",
    "accessKey": "BROWSERSTACK_ACCESS_KEY"
	},
}

# Initialize the remote Webdriver using BrowserStack remote URL
# and desired capabilities defined above
appium_driver = Appium::Driver.new({
	'caps' => capabilities,
	'appium_lib' => {
		:server_url => "http://hub.browserstack.com/wd/hub"
	}}, true)
driver = appium_driver.start_driver

# Test case for the BrowserStack sample iOS app. 
# If you have uploaded your app, update the test case here. 
wait = Selenium::WebDriver::Wait.new(:timeout => 30)
wait.until { driver.find_element(:accessibility_id, "Text Button").displayed? }
textButton = driver.find_element(:accessibility_id, "Text Button")
textButton.click
 
wait.until { driver.find_element(:accessibility_id, "Text Input").displayed? }
textInput = driver.find_element(:accessibility_id, "Text Input")
textInput.send_keys("hello@browserstack.com"+"\n")
 
sleep 5
 
wait.until { driver.find_element(:accessibility_id, "Text Output").displayed? }
result = driver.find_element(:accessibility_id, "Text Output")

if (!result.nil?) && (result.text.eql? "hello@browserstack.com")
  puts "Test Passed"
else
  puts "Test Failed"
end

# Invoke driver.quit() after the test is done to indicate that the test is completed.
driver.quit