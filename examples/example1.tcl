#!/usr/bin/tclsh

package require Gnocl
set but [gnocl::button -text "Hello World" -onClicked {puts "Hello World"}]
gnocl::window -title "Hello World Example" -child $but -onDestroy { exit }
gnocl::mainLoop
