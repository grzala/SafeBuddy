Feature: add and edit comments

	Scenario: add comment
		Given I have entered the main page
		When I log in as "test" "testtest"
		And fill in "comment-message" with "testComment"
		And I submit the comment
		Then I should see "comment by: test"
		And I should see "testComment"
