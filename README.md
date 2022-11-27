# NimColor

An easy to use module to print colors to the terminal.

This repo might see some back-end updates in the future due to this being a project for me to learn Nim, so it's not optimal nor pretty.
However, it is functioning.

## Examples


```nim
import nimcolor

echo "&red;This is red".color

echo "&underline;This has a nice underline".color

echo "&bgRed;This has a red background".color

echo "&invert;This has inverted colors".color

echo "&ff00ff;This has hex color ff00ff".color
```
![](images/example1.png)

## Name defined colors

```
reset       darkBlue      darkBlue      bgDarkPurple   purple        bgPurple    
bold        darkPurple    darkPurple    bgDarkCyan     cyan          bgCyan
underline   darkCyan      darkCyan      bgWhite        brightWhite   bgBrightWhite        
invert      bgReset       bgReset       gray           bgGray
black       bgDarkRed     bgDarkRed     red            bgRed
darkRed     bgDarkGreen   bgDarkGreen   green          bgGreen
darkGreen   bgGold        bgGold        yellow         bgYellow
gold        bgDarkBlue    bgDarkBlue    blue           bgBlue
```

## Notes

This is made solely for myself, so some functionalities might not be included.

As well as this being tested on a windows device *only*, without any extensive cross platform functionality testing being done.
Which means this may or may not function as expected on your device.