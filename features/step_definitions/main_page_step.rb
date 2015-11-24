Given(/^I have entered the main page$/) do
  $session.visit "localhost:3000/"
end

Given(/^I have navigated to "(.*?)"$/) do |location|
  $session.visit "localhost:3000" + location
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
  expect($session).to have_content('SafeBuddy')
end

Then(/^I should see a welcome message$/) do
  expect($session).to have_content('Hello, ' + User.find(session[:user_id]).name)
end

Then(/^I should see the logbox$/) do
  expect($session).to have_content("Login");
  expect($session).to have_content("username");
  expect($session).to have_content("password");
end

When(/^I submit the search$/) do
  $session.click_button("submit-search")
end


