## ZSH greeting
for i in $(seq 7); do
  for i in $(seq $(tput cols)); do
    printf █
  done
done | lolcat --freq=0.8 --spread $(tput cols)
