Feature: Main Page
	As anyone
	Scenario: Enter main page
		Given I have entered the main page
		When I look at the page
		Then I should see general information
		
	Scenario: Enter main page while not logged in
		Given I have entered the main page
		And I am not logged in
		When I look at the page
		Then I should see the logbox
		
	Scenario: search
		Given I have entered the main page
		And I fill in "search" with "crime"
		When I submit the search
		Then I should see the message "Results for: crime"
		And I should see the message "just searching for crimes"
		And I should see the message "Comments:"
		And I should see the message "Articles:"
