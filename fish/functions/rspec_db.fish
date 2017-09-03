function rspec_db
	env RAILS_ENV=test bundle exec rake db:drop db:setup
  rspec $argv
end
