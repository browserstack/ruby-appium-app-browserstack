require 'rubygems'
require 'appium_lib'
require 'selenium-webdriver'

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

# Test case for the BrowserStack sample Android app. 
# If you have uploaded your app, update the test case here. 
wait = Selenium::WebDriver::Wait.new(:timeout => 30)
wait.until { driver.find_element(:accessibility_id, "Search Wikipedia").displayed? }
element = driver.find_element(:accessibility_id, "Search Wikipedia")
element.click

wait.until { driver.find_element(:id, "org.wikipedia.alpha:id/search_src_text").displayed? }
search_box = driver.find_element(:id, "org.wikipedia.alpha:id/search_src_text")
search_box.send_keys("BrowserStack")
sleep 5

results = driver.find_elements(:class, "android.widget.TextView")
if results.count > 0
	puts "Found results - Test Passed"
else
	puts "No results found - Test Failed"
end

# Invoke driver.quit() after the test is done to indicate that the test is completed.
driver.quit
