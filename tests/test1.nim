# This is just an example to get you started. You may wish to put all of your
# tests into a single file, or separate them into multiple `test1`, `test2`
# etc. files (better names are recommended, just make sure the name starts with
# the letter 't').
#
# To run these tests, simply execute `nimble test`.

import unittest
import nimcolor
test "Name coloring":
    check "&red;".color == "\e[91m\e[0m"

test "Hex coloring":
    check "&ff0000;".color == "\e[38;2;255;0;0m\e[0m"

test "Rgb coloring":
    check "&255,0,0;".color == "\e[38;2;255;0;0m\e[0m"

test "Background coloring":
    check "&bgRed;".color == "\e[101m\e[0m"

test "Hex background coloring":
    check "&bgff0000;".color == "\e[48;2;255;0;0m\e[0m"

test "Rgb background coloring":
    check "&bg255,0,0;".color == "\e[48;2;255;0;0m\e[0m"