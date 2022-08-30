require 'rubygems'
require 'appium_lib'
require 'selenium-webdriver'

caps = {}
# Set your access credentials
caps['browserstack.user'] = 'YOUR_USERNAME'
caps['browserstack.key'] = 'YOUR_ACCESS_KEY'

# Set URL of the application under test
caps['app'] = 'bs://<app-id>'

# Specify device and os_version for testing
caps['device'] = "iPhone 11 Pro"
caps['os_version'] = "13"

# Set other BrowserStack capabilities
caps['project'] = 'First Ruby project'
caps['build'] = 'browserstack-build-1'
caps['name'] = 'single_test'

#Set the platform name
caps['platformName'] = 'iOS'

# Initialize the remote Webdriver using BrowserStack remote URL
# and desired capabilities defined above
appium_driver = Appium::Driver.new({
	'caps' => caps,
	'appium_lib' => {
		:server_url => "http://hub-cloud.browserstack.com/wd/hub"
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