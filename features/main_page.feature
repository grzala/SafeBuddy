Feature: Main Page
	As anyone
	Scenario: Enter main page
		Given I have entered the main page
		When I look at the page
		Then I should see general information
	Scenario: Enter main page while logged in
		Given I have entered the main page
		And I am logged in
		When I look at the page
		Then I should see general information
		And I should see a welcome message