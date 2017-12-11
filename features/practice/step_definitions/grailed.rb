require 'capybara/cucumber'
require 'rails-i18n'
require 'minitest'

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

And(/^I click on the "([^"]*)" category header$/) do |header|
  puts "checking all top category headers..." if @verbose

  case header

    when "outerwear" then find("div.sub-header-links").all("a")[0].click

    when "tops" then find("div.sub-header-links").all("a")[1].click

    when "bottoms" then find("div.sub-header-links").all("a")[2].click

    when "footwear" then find("div.sub-header-links").all("a")[3].click

    when "sneakers" then find("div.sub-header-links").all("a")[4].click

    when "tailoring" then find("div.sub-header-links").all("a")[5].click

    when "accessories" then find("div.sub-header-links").all("a")[6].click

  else
    fail "You selected a category header that does not exist!"
  end
  
end

Then(/^I verify the "([^"]*)" category is clicked under the category filter$/) do |category|
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

  case filter 

    when "Tops & Outerwear"
      find("p[data-reactid='.4.2.3.0.0.0.4.1.$Tops & Outerwear.1.$#{size}']").click
      sleep 0.5

    when "Bottoms & Pants"
      find("p[data-reactid='.4.2.3.0.0.0.4.1.$Bottoms & Pants.1.$#{size}']").click
      sleep 0.5

    when "Footwear"
      find("p[data-reactid='.4.2.3.0.0.0.4.1.$Footwear.1.$#{size}']").click
      sleep 0.5

    when "Tailoring"
      find("p[data-reactid='.4.2.3.0.0.0.4.1.$Tailoring.1.$#{size}']").click
      sleep 0.5

    when "Accessories"
      find("p[data-reactid='.4.2.3.0.0.0.4.1.$Accessories.1.$#{size}']").click
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
  modal.find("input[type='email']").set "brandochang1993@gmail.com"
  modal.find("input[type='password']").set("Chickent913").native.send_key(:enter)
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
    # puts @price_array.sort if @verbose #sort the area in ascending order
  puts @price_array.min if @verbose
  puts "Found the lowest price of #{@price_array.min}" if @verbose

  puts "================================================================================================="
  
  loop do 
    
    listing_link = all("div.feed-item a", :wait=>0)
    len = listing_link.size
    browse_links = listing_link[i]

    step "I scroll down to see more products"

    # puts i if @verbose
    # @a_href = browse_links[:href]  
    # puts "found the link href: #{@a_href}" if @verbose 

    i+=1

    begin
      if assert browse_links.find("span", :text=>"#{@price_array.min}", :wait=>0)
        browse_links.click
        break
      end
    rescue
      puts "Searching for listing with the lowest price..." if @verbose
    ensure
      loop
    end

    if (i >= 50)
      break
    end

  end
  url = URI.parse(current_url)
  puts "We found our cheapest listing: #{url}"
end


Given(/^I identify a product in the search results page that takes you to a \/([^"]*) page$/) do |product_page_type|
  step "I land on the shop category landing page and click on Shop All"
  @product_cell = -1
  i = 0
  while @product_cell != i
    product = all("ss-product-cell")[i]
    within(product) do
      find("div.product-cell-container").hover
      @elem = find("a.detail-link")
      href = @elem[:href]
      puts "found href in cell #{i} - #{href}" if @verbose
      page.execute_script "window.scrollBy(0,50)"
      if href.include?("/#{product_page_type}/")
        puts "found our cell - #{href}" if @verbose
        @product_href = href
        @product_cell = i
        @product_id = first("meta", :visible=>false)[:'product-id']
        @product_name = find("a.product-name").text
        break
      end
    end
    if @product_cell.eql? i then break else i+=1 end
  end
  step "I scroll down to see more products"
end

Then(/^I scroll down to see more products$/) do
  page.execute_script "window.scrollBy(0,3000)"
end

############helper############
def scroll_to(element)
  script = <<-JS
    arguments[0].scrollIntoView(true);
  JS

  Capybara.current_session.driver.browser.execute_script(script, element.native)
end
