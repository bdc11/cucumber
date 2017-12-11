def set_env
  # Verbose logging in our test
  if ENV["VERBOSE"]
    @verbose = true
    puts "DEBUG LOGGING ENABLED.."
  else
    @verbose = false
  end

  set_target

end

def set_env_test
  # Verbose logging in our test
  if ENV["VERBOSE"]
    @verbose = true
    puts "DEBUG LOGGING ENABLED.."
  else
    @verbose = false
  end

  set_target

end

def set_target
  # Default to grailed
  @grailed_host = "https://www.grailed.com/"
  @adidas_host = "https://www.adidas.com/"
end

# After do |scenario|
#   if scenario.failed?
#     timestamp = "#{Time.zone.now.strftime('%Y-%m-%d-%H:%M:%S')}"
#     screenshot_name = "screenshot-#{scenario.title}-#{timestamp}.png"
#     # screenshot_path = "#{Rails.root.join('tmp/capybara')}/#{screenshot_name}"
#     screenshot_path = '/failures/' + time + '-' + "#{@driver}" + '-' + scenario_feature + '-' + scenario_name + '.png'
#     Capybara.page.save_screenshot(screenshot_path)
#   end
# end

# After do |scenario|
#   tags = []
#   scenario.tags.to_ary.each {|x| tags.push(x.name)}

#   if (scenario.failed? && tags.include?("@javascript"))
#     scenario_name = scenario.name.gsub /[^\w\-]/, '-'
#     scenario_feature = scenario.feature.name.gsub /[^\w\-]/, '-'
#     time = Time.now.strftime("%Y-%m-%d-%H%M")
#     screenshot_path = './failures/' + time + '-' + "#{@driver}" + '-' + scenario_feature + '-' + scenario_name + '.png'
#     if @headless != true

#       Capybara.current_session.driver.browser.save_screenshot(screenshot_path)  # Capybara drivers
#     else
#       save_screenshot(screenshot_path)  # phantomjs
#     end
#   end
# end


