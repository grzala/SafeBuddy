Given(/^I have entered the main page$/) do
  visit root_path
end

Given(/^I am logged in$/) do
  #elson
end

Given(/^I am not logged in$/) do
  #do not have to do anything
end

When(/^I look at the page$/) do
  #nothing to do
end

Then(/^I should see general information$/) do
  expect(page).to have_content('SafeBuddy')
end

Then(/^I should see a welcome message$/) do
  expect(page).to have_content('Hello, ' + User.find(session[:user_id]).name)
end

Then(/^I should see the logbox$/) do
  expect(page).to have_content("Log in");
  expect(page).to have_content("username");
  expect(page).to have_content("password");
end

