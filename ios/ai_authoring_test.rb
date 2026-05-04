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
caps['device'] = 'Google Pixel 3'
caps['os_version'] = '9.0'

# Set other BrowserStack capabilities
caps['project'] = 'AI Authoring Ruby project'
caps['build'] = 'ai-authoring-build-1'
caps['name'] = 'ai_authoring_test'

# Set the platform name
caps['platformName'] = 'android'

# Initialize the remote Webdriver using BrowserStack remote URL
appium_driver = Appium::Driver.new({
  'caps' => caps,
  'appium_lib' => {
    :server_url => "http://hub-cloud.browserstack.com/wd/hub"
  }}, true)
driver = appium_driver.start_driver

# Search using AI Agent commands
driver.execute_script('browserstack_executor: {"action": "ai", "arguments": ["Tap on Search Wikipedia"]}')
driver.execute_script('browserstack_executor: {"action": "ai", "arguments": ["Type India in the search field"]}')

# Verify results
driver.execute_script('browserstack_executor: {"action": "ai", "arguments": ["Verify search results are displayed"]}')

puts "AI Authoring Test Passed"

driver.quit
