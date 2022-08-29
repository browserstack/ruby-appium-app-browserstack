require 'rubygems'
require 'appium_lib'
require 'selenium-webdriver'
require 'browserstack/local'

capabilities = {
	# Specify device and os_version for testing
	"platformName" => "iOS",
	"platformVersion" => "12",
	"deviceName" => "iPhone XS",

	# Set URL of the application under test
	"app" => "bs://bs://<appID>",

	# Set other BrowserStack capabilities
	'bstack:options' => {
		"projectName" => "First Ruby project",
		"buildName" => "browserstack-build-1",
		"sessionName" => "single_test",
		"debug" => "true",
    "local" => "true"
		"networkLogs" => "true",

		# Set your access credentials
		"userName": "BROWSERSTACK_USERNAME",
    "accessKey": "BROWSERSTACK_ACCESS_KEY"
	},
}

# Start browserstack local
bs_local = BrowserStack::Local.new
bs_local_args = { "key" => access_key }
bs_local.start(bs_local_args)

# Initialize the remote Webdriver using BrowserStack remote URL
# and desired capabilities defined above
appium_driver = Appium::Driver.new({
  'caps' => caps,
  'appium_lib' => {
    :server_url => "http://hub.browserstack.com/wd/hub"
  }}, true)
driver = appium_driver.start_driver

# Initialize the remote Webdriver using BrowserStack remote URL
# and desired capabilities defined above
wait = Selenium::WebDriver::Wait.new(:timeout => 30)
wait.until { driver.find_element(:accessibility_id, "TestBrowserStackLocal").displayed? }
test_button = driver.find_element(:accessibility_id, "TestBrowserStackLocal")
test_button.click

wait.until do
  value = driver.find_element(:accessibility_id, "ResultBrowserStackLocal").attribute("value")
  !value.nil? && value.size > 0
end

result_element = driver.find_element(:accessibility_id, "ResultBrowserStackLocal")

if result_element.text.match('Up and running')
  puts "Test Passed"
else
  puts "Test Failed"
end

# Invoke driver.quit() after the test is done to indicate that the test is completed.
driver.quit

# Stop browserstack local
bs_local.stop
