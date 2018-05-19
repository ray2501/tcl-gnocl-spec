#!/usr/bin/tclsh

package require Gnocl
# create submenu for menu "File" with standard items "New" and 
# "Quit" (text, icon and accelerator). 'N', 'Q' respectively, 
# are underlined and are used as mnemonics.
set menu [gnocl::menu]
$menu add [gnocl::menuItem -text "%#New" -tooltip "Make new" \
      -onClicked {puts "That's new"}]
$menu add [gnocl::menuSeparator]
$menu add [gnocl::menuItem -text "%#Quit" -onClicked exit \
      -tooltip "Quit program"]

# create menu "File", 'F' is underlined and used as mnemonic
set file [gnocl::menuItem -text "%__File" -submenu $menu]

# create menu "Help" with item "About" 
set menu [gnocl::menu]
$menu add [gnocl::menuItem -text "%__About" \
      -tooltip "Show about dialog" \
      -onClicked {puts "Mini example (c) 2001 - 2003 P.G. Baum"}]
set help [gnocl::menuItem -text "%__Help" -submenu $menu]

# create toolbar with standard items "Quit" and "New"
set toolBar [gnocl::toolBar -style both]
$toolBar add item -text "%#Quit" -tooltip "Tooltip Quit" \
      -onClicked exit
$toolBar add space
$toolBar add item -text "%#New" -tooltip "Tooltip new" \
      -onClicked {puts "That's new"}

# create GTK+ application with menu, toolBar, statusbar 
# and a label as main widget
set box [gnocl::box -orientation vertical -borderWidth 0 -spacing 0]
set win [gnocl::window -child $box -title "Test Application" -onDestroy { exit } ]
$box add [gnocl::menuBar -children [list $file $help]]
$box add $toolBar 
$box add [gnocl::label -useMarkup 1 -text \
      {%<<span foreground="blue" size="large">Hello</span>\
      <span foreground="red" size="large">World</span>}] -expand 1
$box add [gnocl::statusBar] 

# enter GTK+ main loop
gnocl::mainLoop
