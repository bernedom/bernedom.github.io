#!/bin/bash

convert $1 -fuzz 15% -trim +repage \
\( -clone 0 -resize 177x100% -blur 0x10 \) \
+swap -gravity center -compose over -composite \
result.jpg