@grailed
Feature: Open google search page

Scenario: I log into my grailed account
  Given I visit grailed website
  When I log into my grailed account
  Then I verify I am logged into my account

Scenario: I visit grailed.com
  # Given I go to the Shopstyle homepage
  Given I visit grailed website
  And I click on the footwear header
  When I search for "yeezy 700 waverunner" and I put sizes filter into view
  And I select size 11
  # And I check the seller feed for the lowest price
  And I click on a seller posting
  And I click on ask the seller a question
  And I log into my grailed account from the cell
  Then I verify I am logged into my account

Scenario: I visit grailed.com
  # Given I go to the Shopstyle homepage
  Given I visit grailed website
  And I test the category headers and verify the href
@1
Scenario: I visit grailed.com
  Given I visit grailed website
  And I click on the footwear header
  # When I search for "yeezy 700 waverunner" and I put sizes filter into view
  When I search for "yeezy belugas" and I put sizes filter into view
  And I select size 11
  # And I look for 770 in product cell
  And I check for the cheapest listing price