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
  # set_params   #Set ENV[PARAM] to A/B tests URL query
  # set_api_auth
  # set_checkout_params

  # puts "BACK-END TARGETS:" if @verbose
  # puts "--->Setting ShopStyle Store API target to #{@host}" if @verbose
  # puts "--->Setting ShopStyle Admin Portal API target to #{@shopstyle_portal_api_host}" if @verbose
  # puts "--->Setting Checkout API target to #{@checkout_api_host}" if @verbose
  # puts "--->Setting Checkout Admin API target to #{@checkout_admin_api_host}" if @verbose
  # puts "--->Setting API authorization headers to #{@auth_type}" if @verbose
  # puts "FRONT-END TARGETS:" if @verbose
  # puts "--->Setting Designer Apparel target to #{@da_host}" if @verbose
  # puts "--->Setting ShopStyle Angular Web target to #{@shopstyle_host}" if @verbose
  # puts "--->Setting ShopStyle Angular 2 Web target to #{@shopstyle_ng2_host}" if @verbose
  # puts "--->Setting ShopStyle Collective target to #{@shopstyle_collective_host}" if @verbose
  # puts "--->Setting ShopStyle SDK target to #{@shopstyle_sdk_host}" if @verbose
end

def set_target
  # Default to grailed
  @grailed_host = "https://www.grailed.com/"
  @adidas_host = "https://www.adidas.com/"
  # @grailed_host = "https://www.google.com/"

  # if ENV["TARGET"].eql? "API11"

  #   @shopstyle_api_host = "https://shopstyleprodapi11.sugarops.com/api/"
  #   @shopstyle_host = "https://shopstyle.com/?api=prod:11"  

  # elsif ENV["TARGET"].eql? "PRODUCTION"
    
  #   if @locale.eql? "en"
  #     @shopstyle_host = "https://www.shopstyle.com/"
  #   elsif @locale.eql? "fr"
  #     @shopstyle_host = "https://www.shopstyle.fr/"
  #   elsif @locale.eql? "de"
  #     @shopstyle_host = "https://www.shopstyle.de/"
  #   elsif @locale.eql? "uk"
  #     @shopstyle_host = "https://www.shopstyle.co.uk/"
  #   elsif @locale.eql? "au"
  #     @shopstyle_host = "https://www.shopstyle.com.au/"
  #   elsif @locale.eql? "ca"
  #     @shopstyle_host = "https://www.shopstyle.ca/"
  #   elsif @locale.eql? "jp"
  #     @shopstyle_host = "https://www.shopstyle.co.jp/"
  #   elsif @locale.eql? "cn"
  #     @shopstyle_host = "https://www.shopstyle.cn/"
  #   else
  #     @shopstyle_host = "https://www.shopstyle.com/"
  #   end

  #   @shopstyle_ng2_host = @shopstyle_host
  #   @shopstyle_api_host = "https://www.shopstyle.com/api/"
  #   @da_host = "http://www.designerapparel.com/"
  #   @shopstyle_collective_host = "https://www.shopstylecollective.com/"  

  # elsif ENV["TARGET"].eql? "PREVIEW"
  #     @shopstyle_sdk_host = "https://checkout.shopstylepreview.com/"
  #     @shopstyle_host = "https://www.shopstyleqa.com/" 
  #     @shopstyle_api_host = "https://www.shopstylepreview.com/api/"
  #     @checkout_api_host = "https://checkout-api.shopstylepreview.com/checkout/"

  # elsif ENV["TARGET"].eql? "FTL-QA"
  #     @shopstyle_sdk_host = "https://checkout.shopstyleqa.com/"
  #     @shopstyle_host = "https://ftl-qa.shopstyleqa.com/"
  #     @shopstyle_api_host = "https://www.shopstyleqa.com/api/"
  #     @checkout_api_host = "https://checkout-api.shopstyleqa.com/checkout/"
  #     @shopstyle_ng2_host = @shopstyle_host

  # elsif ENV["TARGET"].eql? "FTL-CANARY"
  #     #@shopstyle_sdk_host = "https://checkout.shopstyleqa.com/"
  #     @shopstyle_host = "https://ftl-canary.shopstyle.com/"
  #     @shopstyle_api_host = "https://www.shopstyle.com/api/"
  #     #@checkout_api_host = "https://checkout-api.shopstyleqa.com/checkout/"
  #     @shopstyle_ng2_host = @shopstyle_host   

  # elsif ENV["TARGET"].eql? "Z"
  #     @shopstyle_sdk_host = "https://checkout.shopstyleqa.com/"
  #     #@shopstyle_host = "http://www.shopstyledev.com:3009/"
  #     @shopstyle_host = "http://b8a96fce.ngrok.io"
  #     @shopstyle_api_host = "http://b8a96fce.ngrok.io"
  #     #@shopstyle_api_host = "https://www.shopstyleqa.com/api/"
  #     @checkout_api_host = "https://checkout-api.shopstyleqa.com/checkout/"
  #     @shopstyle_ng2_host = @shopstyle_host

  # elsif ENV["TARGET"].eql? "LOCAL"
  #   @shopstyle_sdk_host = "http://checkout-local.shopstyleqa.com:3000"
  #   @shopstyle_host = "https://www.shopstyleqa.com/"
  #   @shopstyle_api_host = @shopstyle_host + "api/"
  #   @shopstyle_ng2_host = @shopstyle_host
  #   @checkout_api_host = "https://checkout-api.shopstyleqa.com/checkout/"
  #   @da_host = "http://www.designerapparelqa.com/"
  #   @shopstyle_collective_host = "https://test.shopstylecollective.com/"

  # else 

  #   if @locale.eql? "en"
  #     @shopstyle_host = "https://www.shopstyleqa.com/"
  #   elsif @locale.eql? "fr"
  #     @shopstyle_host = "https://www-fr.shopstyleqa.com/"
  #   elsif @locale.eql? "de"
  #     @shopstyle_host = "https://www-de.shopstyleqa.com/"
  #   elsif @locale.eql? "uk"
  #     @shopstyle_host = "https://www-gb.shopstyleqa.com/"
  #   elsif @locale.eql? "au"
  #     @shopstyle_host = "https://www-au.shopstyleqa.com/"
  #   elsif @locale.eql? "ca"
  #     @shopstyle_host = "https://www-ca.shopstyleqa.com/"
  #   elsif @locale.eql? "jp"
  #     @shopstyle_host = "https://www-jp.shopstyleqa.com/"
  #   elsif @locale.eql? "cn"
  #     @shopstyle_host = "https://www-cn.shopstyleqa.com/"
  #   else
  #     @shopstyle_host = "https://www.shopstyleqa.com/"
  #   end

  #   @shopstyle_sdk_host = "https://checkout.shopstyleqa.com/" 
  #   @shopstyle_api_host = @shopstyle_host + "api/"
  #   @shopstyle_portal_api_host = "http://portal.shopstyleqa.com/admin/"
  #   @shopstyle_ng2_host = @shopstyle_host
  #   @checkout_api_host = "https://checkout-api.shopstyleqa.com/checkout/"
  #   @checkout_admin_api_host = "https://checkout-admin.shopstyleqa.com/checkout/admin/"
  #   @da_host = "http://www.designerapparelqa.com/"
  #   @shopstyle_collective_host = "https://test.shopstylecollective.com/"  
  # end

  # @google_blogger_host = "https://www.blogger.com/"
  # @google_search_host = "https://google.com/"
  # @wp_blog_host = "http://popsugar.staging.wpengine.com/wp-admin"
  # @collective_testing_blog_host = "http://collectivetestingqa.blogspot.com/"
  # @host = @shopstyle_api_host
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


