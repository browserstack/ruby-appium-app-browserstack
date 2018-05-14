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

driver.quit