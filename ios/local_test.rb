require 'rubygems'
require 'appium_lib'
require 'selenium-webdriver'
require 'browserstack/local'

username = 'BROWSERSTACK_USERNAME'
access_key = 'BROWSERSTACK_ACCESS_KEY'

caps = {}
caps['build'] = 'Ruby Appium Sample'
caps['name'] = 'local_test'
caps['device'] = 'iPhone 7 Plus'
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
    :server_url => "http://#{username}:#{access_key}@hub.browserstack.com/wd/hub"
  }}, true)
driver = appium_driver.start_driver

wait = Selenium::WebDriver::Wait.new(:timeout => 30)
wait.until { driver.find_element(:accessibility_id, "TestBrowserStackLocal").displayed? }
test_button = driver.find_element(:accessibility_id, "TestBrowserStackLocal")
test_button.click

wait.until do
  value = driver.find_element(:accessibility_id, "ResultBrowserStackLocal").attribute("value")
  !value.nil? && value.size > 0
end

result_element = driver.find_element(:accessibility_id, "ResultBrowserStackLocal")

if result_element.text.match("Up and running")
  puts "Test Passed"
else
  puts "Test Failed"
end

driver.quit
bs_local.stop
