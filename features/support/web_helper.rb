require 'capybara/cucumber'
require 'selenium-webdriver'
require 'capybara/poltergeist'

Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

Capybara.javascript_driver = :chrome

Capybara.configure do |config|
  config.default_max_wait_time = 10 # seconds
  config.default_driver        = :selenium
end

def selenium_init
  set_env
  set_target
  puts "initializing selenium..." if @verbose
  puts "setting window size..." if @verbose
  # set_window_size

  Capybara.wait_on_first_by_default = true #trigger Capybara's waiting behavior for a minimum of 1 matching element to be found and return the first
  Capybara.default_max_wait_time = 10
end

def set_window_size
  #Set up default screen size
  #Desktop= 1024x768
  #Tablet(ipad)= 768X1024
  #Mobile(iphone6)=375X667
  window = Capybara.current_session.driver.browser.manage.window

  if ENV["MODE"].eql? "desktop"
    window.resize_to(1024, 768)
    @selenium_mode = "desktop"
    @selenium_res = "1024x768"
  elsif ENV["MODE"].eql? "tablet"
    window.resize_to(@selenium_device_width, @selenium_device_height)
  elsif ENV["MODE"].eql? "mobile"
    window.resize_to(@selenium_device_width, @selenium_device_height)
  else
    # window.maximize
    window.resize_to(1440, 873)
    puts window.size if @verbose
    @selenium_mode = "Maxumum Resolution for Screen"
    @selenium_res = "1440x873"
  end

  puts "Window size is set to #{@selenium_mode}, #{@selenium_res}" if @verbose
end

def set_window_size_to(width, height)

  window = Capybara.current_session.driver.browser.manage.window
  window.resize_to(width, height)

end