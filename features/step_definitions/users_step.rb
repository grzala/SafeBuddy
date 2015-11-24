When(/^I click register$/) do
  $session.click_link("Register");
end

When(/^I fill in "(.*?)" with "(.*?)"$/) do |input, value|
  $session.fill_in(input, :with => value)
end

When(/^submit register form$/) do
  $session.click_button("Register")
end

Then(/^I should see the welcome message for "(.*?)"$/) do |usr|
  expect($session).to have_content("Hello, " + usr)
end

When(/^I log in as "(.*?)" "(.*?)"$/) do |name, pass|
  $session.fill_in("username", :with => name)
  $session.fill_in("password", :with => pass)
  $session.click_link("send-login-form")

end

When(/^I click logout$/) do
  $session.click_link("logout")
end

Then(/^I should not see the welcome message for "(.*?)"$/) do |usr|
  expect($session).not_to have_content("Hello, " + usr)
end

Then(/^I should see the message "(.*?)"$/) do |message|
  expect($session).to have_content(message)
end
