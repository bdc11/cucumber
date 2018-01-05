require 'capybara/cucumber'
require 'rails-i18n'
require 'minitest'


And(/^I open a new tab$/) do
  find("div.feed").first("img", target="_blank").click
end

And(/^I visit grailed website$/) do
  selenium_init
  Capybara.app_host = @grailed_host
  visit('')
  # visit 'https://www.grailed.com/'
  puts "checking grailed website..."
end

And(/^I log into my grailed account$/) do
  find("a.enter", :wait=>0).click #unless nil?
  step "I log into my grailed account from the cell"
end

And(/^I sign up as a new user$/) do
  find("a.enter", :wait=>0).click
  sleep 1
  modal = find("div.ReactModal__Content")
  modal.find("input[type='email']").set @user_email
  modal.find("input[type='password']").set(@user_password).native.send_key(:enter)
  find("a", :text=>"YES").click
end


Then(/^I verify my new account is created$/) do
  confirm_signup = find("span.italic", :text=>@user_email) #checking that email on sign up page matches email we signed up with
  assert_equal confirm_signup.text, @user_email

  assert find("div.verify-email")
  verify_email = find("span.bold", :text=>@user_email) #checking that email on verify page matches email we signed up with
  assert_equal verify_email.text, @user_email
end


And(/^I click on the "([^"]*)" category header$/) do |header|
  puts "checking all top category headers..." if @verbose
  category_header = ("div[data-reactid='.3.1.1.$#{header}'")

  if has_css? category_header
    find(category_header).click
  else
    fail "You selected a category header that does not exist!"
  end  
end

Then(/^I verify the "([^"]*)" category is clicked under the category filter$/) do |category|  
  puts "Looking for page filters..." if @verbose
  begin
    side_filters = find("h3.filter-toggle", :text=>"SHOW FILTERS")
    assert side_filters
    page.first("div.filter-toggle-wrapper").click 
  rescue
    puts "Side filters are visible. Continuing..." if @verbose
  ensure 
    category_choice = find("div.categories-wrapper").find("div.filter-bottom")
    assert category_choice.find("div.#{category}-wrapper").find("p.toggle-all.active-indicator.active")
  end 
end

And(/^I search for "([^"]*)" and I put sizes filter into view$/) do |search|
  find("div.feed-settings-bar.container").find("input.search", :wait=>0).set "#{search}"
  sleep 0.5

  scroll_to(page.find("div.sizes-wrapper").find("h3", :text=>"SIZE"))
end

And(/^I select size "([^"]*)" within the "([^"]*)" filter$/) do |size, filter|
  size_filter = find("div.sizes-wrapper")
  size_filter.first("span", :text=>filter).find("span.triangle").click
  size_choice = ("p[data-reactid='.4.2.3.0.0.0.4.1.$#{filter}.1.$#{size}']")

  if has_css? size_choice
    find(size_choice).click
    sleep 0.5
  else
    fail "You selected a size filter that does not exist!"
  end
end

And(/^I click on ask the seller a question$/) do
  find("a.ask-question.button.white").click
  sleep 5
end

And(/^I check the seller feed for the lowest price$/) do
  assert find("div.feed")
end

And(/^I click on a seller posting$/) do
  cell = all("div.listing-metadata")[0]
  scroll_to(cell)
  cell.click
end

And(/^I log into my grailed account from the cell$/) do
  sleep 1
  modal = find("div.ReactModal__Content")
  modal.find("input[type='email']").set "kickz124@gmail.com"
  modal.find("input[type='password']").set("Password1").native.send_key(:enter)
end

Then(/^I verify I am logged into my account$/) do
  loggedIn = find("div.account.drop-down")
  assert loggedIn
  puts "I am logged in. #{loggedIn.text} is now visible" if @verbose
end


And(/^I test the category headers and verify the href$/) do

  puts "starting to check the category links..." if @verbose  

  i = 1
  
  loop do

    category_links = all("div.header-link a")

    len = category_links.size
    puts "there are #{len} header categories" if @verbose

    category_links = category_links[i]
 
    @href = category_links[:href]  
    puts "found the link href: #{@href}" if @verbose 
    
    category_links.click 

    assert_current_path @href, url: true #check the new page that loads matches the url from the href
    
    i += 1
    puts "check len: #{len}" if @verbose
    puts "check i: #{i}" if @verbose
    sleep 0.5

    if ( i >= len)
      break
    end

  end 
end

When(/^I go back to the previous page$/) do
  page.evaluate_script('window.history.back()')
  # sleep 0.5
end

And(/^I check for the cheapest listing price$/) do

  puts "checking the seller posts for the cheapest listing price..." if @verbose

  i = 0
  feed_cell = all("div.feed-item")
  all_prices = all("div.listing-price")
  @price_array = []
 
  all_prices.each do |price|

    @cell_price = price.text.gsub("$","") 
    @price_array = @price_array.push(@cell_price)
    @price_array = @price_array.map(&:to_i)

    # puts "Found a listing price of #{price.text}" if @verbose # in listing #{i}
  end

  puts @price_array if @verbose
  puts @price_array.min if @verbose
  puts "Found the lowest price of #{@price_array.min}"

  puts "================================================================================================="
  
  loop do 
    
    listing_link = all("div.feed-item a", :wait=>0)
    len = listing_link.size
    browse_links = listing_link[i]

    # step "I scroll down to see more products"

    # puts i if @verbose
    # @a_href = browse_links[:href]  
    # puts "found the link href: #{@a_href}" if @verbose 

    i+=1

    begin
      if assert browse_links.find("span", :text=>"#{@price_array.min}", :wait=>0)
        browse_links.click
        # window_opened_by { browse_links.click }
        break
      end
    rescue
      puts "Searching for listing with the lowest price..." 
    ensure
      loop
    end

    if (i >= 50)
      break
    end

  end
  url = URI.parse(current_url)
  puts "We found our cheapest listing: \n#{url}"
end

Then(/^I scroll down to see more products$/) do
  page.execute_script "window.scrollBy(0,3000)"
end

#TODO
And(/^I check the location of the item and shipping cost to "([^"]*)"$/) do |shipping|
  puts "Checking the location of the item..." 
  @seller_info = ("div.user-widget.medium")
  seller_box = find("div.listing-seller-profile")
  scroll_to(seller_box)


  seller_location = find(@seller_info).find("p.user-location")
  puts seller_location.text if @verbose

  puts "Checking shipping price..." 

  shipping_info = ("div.listing-shipping")
  if page.has_css? shipping_info
    shipping_cost = find(shipping_info).find("div.item",:text=>shipping).find("div.amount")
  end 
  puts "The item is located in #{seller_location.text} and shipping cost to #{shipping} is #{shipping_cost.text}"
end

And(/^I verify the seller feedback is good$/) do
  if page.has_css? ("a.green")
    feedback = find("div.right").find("a.green").text 
  else
    feedback = find("div.right").find("a").text
  end 

  feedback_check = feedback.gsub("/5","").gsub("Feedback","")

  if ((feedback_check.to_i) >= 4)
    puts "Seller has a feedback of #{feedback}!"
  else
    puts "BEWARE! Seller has a feedback of #{feedback}!"
  end

  seller_sales = find("div.right").find("h1.sub-title.semi-bold").find("a").text
  seller_sales = seller_sales.gsub("(","").gsub(")","").split(" ")
  seller_sales = seller_sales[1].to_i

    if seller_sales <= 0
      puts "BEWARE! Seller has zero prior sales!"
    elsif seller_sales <= 5
      puts "WARNING! Seller has very few sales. buy with caution!"
    else
      puts "Seller has #{seller_sales} sales!"
    end
end

Given(/^I generate a new user$/) do
  time = Time.now.to_i.to_s
  stamp = time + [SecureRandom.hex].pack('H*').gsub(/[^0-9a-z]/i, '')
  rand_numbers = SecureRandom.hex(13)
  # @user_email = "bc+grailed+#{stamp}@mailinator.com"
  # @user_email = "bcgrailed#{stamp}@gmail.com"
  @user_email = "bcrandemail#{stamp}@gmail.com"
  @user_name = "bcranduser#{rand_numbers}"
  @user_password = "Password1"
  puts "==> Generating New User Email ==> email: #{@user_email}" if @verbose
  puts "==> Generating New User Name ==> email: #{@user_name}" if @verbose
end

############helper############
def scroll_to(element)
  script = <<-JS
    arguments[0].scrollIntoView(true);
  JS
  Capybara.current_session.driver.browser.execute_script(script, element.native)
end

def open_new_tab
  driver = Selenium::WebDriver.for:chrome
  driver.keyboard.send_keys [:control, "t"]
end

def generate_code(number)
  charset = Array('A'..'Z') + Array('a'..'z')
  Array.new(number) { charset.sample }.join
end
 
