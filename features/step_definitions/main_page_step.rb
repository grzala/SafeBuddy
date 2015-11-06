Given(/^I have entered the main page$/) do
  visit root_path
end

When(/^I look at the page$/) do
  #nothing to do
end

Then(/^I should see following information$/) do
  expect(page).to have_content('SafeBuddy')
end
