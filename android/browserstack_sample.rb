require 'rubygems'
require 'appium_lib'
require 'selenium-webdriver'
caps = {}
# Set your access credentials
caps['browserstack.user'] = 'christinamarie_Fi3wpZ'
caps['browserstack.key'] = 't3La1pRW7H2bqmAs4ppr'
# Set URL of the application under test
caps['app'] = 'bs://444bd0308813ae0dc236f8cd461c02d3afa7901d'
# Specify device and os_version for testing
caps['device'] = 'iPhone 15 Pro Max'
caps['os_version'] = '17'
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
		:server_url => "https://hub-cloud.browserstack.com/wd/hub"
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
