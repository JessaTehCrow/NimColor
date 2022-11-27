import color

# Basic word-associated colors
echo "&red;this is red\n".color

# No automatic color reset after the end
echo color("&blue;this is blue", autoReset=false)
echo "This is also blue"
echo "&reset;This is no longer blue\n".color

# Custom rgb/hex based colors
echo "&ff00ff;This is purple in hex (ff00ff)".color
echo "&255,0,255;This is purple in rgb (255,0,255)".color

# Escape colors
echo colorEscape"&f4c8ff;This is color escaped".color
echo "&f4c7ff;This is color undone\n".color.unColor

# Specials (invert/underlind)
echo "&invert;This is inverted".color
echo "&underline;This is underlined\n".color

# Word associated background colors
echo "&bgDarkRed;&black;This is a red background".color

# custom rgb/hex background colors
echo "&bgf4c7ff;&black;This is a hex background (f4c7ff)".color
echo "&bg255,0,255;&black;This is a rgb background (255,0,255)\n".color
