When(/^I click register$/) do
  click_link("register");
end

When(/^fill in "(.*?)" with "(.*?)"$/) do |input, value|
	fill_in(input, :with => value)
end

When(/^submit register form$/) do
  click_button("register")
end

When(/^click login$/) do
  click_link("send-login-form")
end

Then(/^I should see the welcome message$/) do
  user = User.find(session[:user_id])
  expect(page).to have_content("Hello, " + user.name)
end

Then(/^I should be logged in$/) do
  expect(session[:user_id]).to be
end
