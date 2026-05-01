button_size=100
padding=@PADDING@
padding_h=$(( (@SCREEN_WIDTH@ - $button_size * 5 - $padding * 4) / 2 ))
padding_v=$(( (@SCREEN_HEIGHT@ - $button_size) / 2 ))
wlogout -b 5 -L $padding_h -R $padding_h -T $padding_v -B $padding_v -c $padding -r $padding
