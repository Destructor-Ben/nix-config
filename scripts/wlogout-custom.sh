button_size=100
padding=10 # Hardcode, idc
padding_h=$(( (1920 - $button_size * 5 - $padding * 4) / 2 ))
padding_v=$(( (1080 - $button_size) / 2 ))
wlogout -b 5 -L $padding_h -R $padding_h -T $padding_v -B $padding_v -c $padding -r $padding
