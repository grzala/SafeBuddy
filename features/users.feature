Feature: register and login
	

	Scenario: Register and log in
		Given I have entered the main page
		When I click register
		And I fill in "register_username" with "cucumbertest"
		And I fill in "register_password" with "testtest"
		And I fill in "register_confirm_password" with "testtest"
		And I fill in "register_email" with "test@test.com"
		And submit register form
		And I log in as "test" "testtest"
		Then I should see the welcome message for "test"
		
	Scenario: Log in and log out
		Given I have entered the main page
		When I log in as "test" "testtest"
		And I click logout
		Then I should not see the welcome message for "test"
		
	Scenario: Log in with wrong credentials
		Given I have entered the main page
		When I log in as "test2" "wrongpass"
		Then I should see the message "wrong username or password"
		
	Scenario: Get all register errors
		Given I have navigated to "/users/register"
		And I fill in "register_username" with "test"
		And I fill in "register_password" with "tet"
		And I fill in "register_confirm_password" with "tessssatas"
		And I fill in "register_email" with "smoke@weedeveryday"
		And submit register form
		Then I should see the message "the username is already taken"
		And I should see the message "the passwords you entered are different from each other"
		And I should see the message "the email must follow structure 'email@server.com'"
		And I should see the message "password must be at least 6 characters long"
