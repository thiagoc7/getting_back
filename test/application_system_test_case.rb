require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  if ENV["SELENIUM_REMOTE_URL"]
    driven_by :selenium, using: :chrome, options: {
      url: ENV["SELENIUM_REMOTE_URL"],
      capabilities: [ :chrome ]
    }
  else
    driven_by :selenium, using: :headless_chrome, screen_size: [ 1400, 1400 ]
  end
end
