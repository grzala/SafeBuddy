When(/^I submit the comment$/) do
	$session.click_button("add")
end

Then(/^I should see "(.*?)"$/) do |arg1|
  expect($session).to have_content(arg1)
end
