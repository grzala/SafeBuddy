Feature: register and login

	Scenario: Register and log in
		Given I have entered the main page
		When I click register
		And fill in "register_username" with "test"
		And fill in "register_password" with "testtest"
		And fill in "register_confirm_password" with "testtest"
		And fill in "register_email" with "test@test.com"
		And submit register form
		And fill in "username" with "test"
		And fill in "password" with "testtest"
		And click login
		Then I should see the welcome message
		And I should be logged in
		