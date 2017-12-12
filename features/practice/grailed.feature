@grailed
Feature: Visiting the grailed website


Scenario: A user searches for yeezys under footwear category and uses footwear size filter
  Given I visit grailed website
  And I click on the "footwear" category header
  Then I verify the "footwear" category is clicked under the category filter
  # And I open a new tab
@1
Scenario: A user searches for yeezys under footwear category and uses footwear size filter
  Given I visit grailed website
  And I click on the "footwear" category header
  And I verify the "footwear" category is clicked under the category filter
  When I search for "yeezy 700 waverunner" and I put sizes filter into view
  And I select size "11" within the "Footwear" filter
  And I check for the cheapest listing price
  And I check the location of the item and shipping cost to "United States"
  And I verify the seller feedback is good

Scenario: A user searches for belts under accessories category and uses accessories size filter
  Given I visit grailed website
  And I click on the "accessories" category header
  And I verify the "accessories" category is clicked under the category filter
  When I search for "belts" and I put sizes filter into view
  And I select size "28" within the "Accessories" filter
  And I check for the cheapest listing price

Scenario: A user searches for northface under outerwear category and uses tops & outerwear size filter
  Given I visit grailed website
  And I click on the "outerwear" category header
  And I verify the "outerwear" category is clicked under the category filter
  When I search for "northface" and I put sizes filter into view
  And I select size "m" within the "Tops & Outerwear" filter
  And I check for the cheapest listing price

Scenario: A user searches for supreme under tops category and uses tops & outerwear size filter
  Given I visit grailed website
  And I click on the "tops" category header
  When I search for "supreme" and I put sizes filter into view
  And I select size "m" within the "Tops & Outerwear" filter
  And I check for the cheapest listing price

Scenario: A user searches for calabasas joggers under bottoms category and uses bottoms & pants size filter
  Given I visit grailed website
  And I click on the "bottoms" category header
  And I verify the "bottoms" category is clicked under the category filter
  When I search for "calabasas joggers" and I put sizes filter into view
  And I select size "32" within the "Bottoms & Pants" filter
  And I check for the cheapest listing price

Scenario: A user searches for kaws 4 under sneakers category and uses footwear size filter
  Given I visit grailed website
  And I click on the "sneakers" category header
  When I search for "black kaws 4" and I put sizes filter into view
  And I select size "10=15" within the "Footwear" filter
  And I check for the cheapest listing price

Scenario: A user searches for kaws 4 under sneakers category and uses footwear size filter
  Given I visit grailed website
  And I click on the "tailoring" category header
  And I verify the "tailoring" category is clicked under the category filter
  When I search for "ralph lauren suit" and I put sizes filter into view
  And I select size "46l" within the "Tailoring" filter
  And I check for the cheapest listing price
