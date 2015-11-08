Before do
	$session = Capybara::Session.new(:selenium)
end

After { Capybara.reset_sessions! }