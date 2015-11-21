When(/^I submit the comment$/) do
	$session.click_button("add comment")
end

Then(/^I should see "(.*?)"$/) do |arg1|
  expect($session.page).to have_content(arg1)
end
