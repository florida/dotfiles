function fish_greeting
	for i in (seq 7)
    for i in (seq (tput cols))
      printf █
    end

  echo
  end | lolcat --freq=0.8 --spread (tput cols)
end
