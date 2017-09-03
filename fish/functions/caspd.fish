function caspd
	git push -f $argv[1] $argv[2]:master ; heroku run rake db:migrate -r $argv[1] ;
end
