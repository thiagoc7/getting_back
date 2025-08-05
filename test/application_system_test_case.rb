require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  if ENV["SELENIUM_REMOTE_URL"]
    chrome_options = Selenium::WebDriver::Chrome::Options.new
    chrome_options.add_argument("--headless")
    chrome_options.add_argument("--no-sandbox")
    chrome_options.add_argument("--disable-gpu")
    chrome_options.add_argument("--disable-dev-shm-usage")

    driven_by :selenium,
              using: :chrome,
              options: chrome_options,
              url: ENV["SELENIUM_REMOTE_URL"]
  else
    driven_by :selenium, using: :headless_chrome, screen_size: [ 1400, 1400 ]
  end
end
