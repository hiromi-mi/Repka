require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  caps = Selenium::WebDriver::Remote::Capabilities.chrome("chromeOptions" => {"args" => %w(--headless)})
  driven_by :selenium, using: :chrome, screen_size: [1400, 1400], options: { desired_capabilities: caps }

  def log_in_as(user, password: 'password')
    visit login_path
    fill_in 'Name', with: user.name
    fill_in 'Password', with: password
    click_button 'Log in'
  end

  # add 'exist' option
  def assert_selector(*args)
    unless args[-1].is_a?(Hash) and args[-1].include?(:exist) and not args[-1][:exist]
      args[-1].delete(:exist)
      super(*args)
    else
      args[-1].delete(:exist)
      assert_no_selector(*args)
    end
  end
end
