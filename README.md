# ruby-appium-app-browserstack

This repository demonstrates how to run Appium Ruby tests on BrowserStack App Automate.

## Based on

These code samples are currently based on:

- **appium_lib:** `12.0.1`
- **Protocol:** `W3C`
## Setup

### Requirements

1. Ruby >=2.6

  - If not installed, install Ruby from [here](https://www.ruby-lang.org/en/documentation/installation/)

2. Dependency Manager `bundler`

  - If not installed, run command `gem install bundler`  

### Install the dependencies

To install the dependencies, run the following command in the project's base directory :

```ruby
bundle install
```

**Note**: If you are using Windows, RubyInstaller has a known [issue](https://github.com/oneclick/rubyinstaller2/issues/96). Run the following script as a workaround to resolve it -

```ruby
gem install ffi
gem uninstall -aIx eventmachine
gem install eventmachine --platform=ruby
```

## Getting Started

Getting Started with Appium tests in Ruby on BrowserStack couldn't be easier!

### Run your first test :

**1. Upload your Android or iOS App**
Upload your Android app (.apk or .aab file) or iOS app (.ipa file) to BrowserStack servers using our REST API. Here is an example cURL request :

```
curl -u "YOUR_USERNAME:YOUR_ACCESS_KEY" \
-X POST "https://api-cloud.browserstack.com/app-automate/upload" \
-F "file=@/path/to/apk/file"
```

Ensure that @ symbol is prepended to the file path in the above request. Please note the `app_url` value returned in the API response. We will use this to set the application under test while configuring the test later on.

**Note**: If you do not have an .apk or .ipa file and are looking to simply try App Automate, you can download and test using our [sample Android app](https://www.browserstack.com/app-automate/sample-apps/android/WikipediaSample.apk) or [sample iOS app](https://www.browserstack.com/app-automate/sample-apps/ios/BStackSampleApp.ipa).

**2. Configure and run your first test**

Open `browserstack_sample.rb` file in `android` or `ios` directory :

- Replace `YOUR_USERNAME` & `YOUR_ACCESS_KEY` with your BrowserStack access credentials. Get your BrowserStack access credentials from [here](https://www.browserstack.com/accounts/settings)

- Replace `bs://<app-id>` wkth the URL obtained from app upload step

- Set the device and OS version

- If you have uploaded your own app update the test case

- Run `ruby browserstack_sample.rb`

- You can access the test execution results, and debugging information such as video recording, network logs on [App Automate dashboard](https://app-automate.browserstack.com/dashboard)

---

### Use Local testing for apps that access resources hosted in development or testing environments :

**1. Upload your Android or iOS App**

Upload your Android app (.apk or .aab file) or iOS app (.ipa file) that access resources hosted on your internal or test environments to BrowserStack servers using our REST API. Here is an example cURL request :

```
curl -u "YOUR_USERNAME:YOUR_ACCESS_KEY" \
-X POST "https://api-cloud.browserstack.com/app-automate/upload" \
-F "file=@/path/to/apk/file"
```

Ensure that @ symbol is prepended to the file path in the above request. Please note the `app_url` value returned in the API response. We will use this to set the application under test while configuring the test later on.

**Note**: If you do not have an .apk or .ipa file and are looking to simply try App Automate, you can download and test using our [sample Android Local app](https://www.browserstack.com/app-automate/sample-apps/android/LocalSample.apk) or [sample iOS Local app](https://www.browserstack.com/app-automate/sample-apps/ios/LocalSample.ipa).


**2. Configure and run your local test**

Open `browserstack_sample_local.rb` file in `android` or `ios` directory :

- Replace `YOUR_USERNAME` & `YOUR_ACCESS_KEY` with your BrowserStack access credentials. Get your BrowserStack access credentials from [here](https://www.browserstack.com/accounts/settings)

- Replace `bs://<app-id>` wkth the URL obtained from app upload step

- Set the device and OS version

- Ensure that `local` capability is set to `true`. Within the test script, there is code snippet that automatically establishes Local Testing connection to BrowserStack servers using Ruby binding for BrowserStack Local. 

- If you have uploaded your own app update the test case

- Run `ruby browserstack_sample_local.rb`

- You can access the test execution results, and debugging information such as video recording, network logs on [App Automate dashboard](https://app-automate.browserstack.com/dashboard)

## Integration with other frameworks

For other Ruby frameworks samples, refer to following repositories :

- [Cucumber](https://github.com/browserstack/cucumber-ruby-appium-app-browserstack)

Note: For other test frameworks supported by App-Automate refer our [Developer documentation](https://www.browserstack.com/docs/)

## Getting Help

If you are running into any issues or have any queries, please check [Browserstack Support page](https://www.browserstack.com/support/app-automate) or [get in touch with us](https://www.browserstack.com/contact?ref=help).
