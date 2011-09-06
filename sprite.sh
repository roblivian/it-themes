#!/bin/bash

# right nav images only have 1 variant.
montage -tile 5x1 -geometry 20x20+0+0 -channel rgba -alpha on -gamma 5 -gravity South srcimgs/119-piggy-bank.png srcimgs/123-id-card.png srcimgs/19-gear.png srcimgs/24-gift.png srcimgs/56-cloud.png -background none images/rightnav.png

# build hover state for main nav icons.
genfiles=()
for f in srcimgs/120-headphones.png srcimgs/80-shopping-cart.png srcimgs/09-chat-2.png srcimgs/179-notepad.png srcimgs/111-user.png
do
  convert -channel rgba -alpha on $f -gamma 5 -background none $f.light.png
  genfiles+=( `echo $f.light.png` )
done

montage -tile 5x2 -geometry 24x24+0+0 -channel rgba -alpha on -gravity South srcimgs/120-headphones.png srcimgs/80-shopping-cart.png srcimgs/09-chat-2.png srcimgs/179-notepad.png srcimgs/111-user.png ${genfiles[@]} -background none images/nav.png

# clean up.
for f in "${genfiles[@]}"
do
  rm $f
done
unset genfiles

# make sure everything is fully compressed.
pngcrush -q -brute images/rightnav.png images/rightnav_crush.png
mv images/rightnav_crush.png images/rightnav.png
pngcrush -q -brute images/nav.png images/nav_crush.png
mv images/nav_crush.png images/nav.png
