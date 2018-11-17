#!/usr/bin/tclsh

set arch "x86_64"
set base "gnocl-0.9.96_101118"
set filename "gnocl-0.9.96-10-11-18.tar.bz2"
set fileurl "https://sourceforge.net/projects/gnocl/files/Gnocl-Nightly-Build/$filename"

set var [list wget $fileurl -O $filename]
exec >@stdout 2>@stderr {*}$var

set var [list tar xjvf $filename]
exec >@stdout 2>@stderr {*}$var

file copy gnocl-0.9.96/src/includes/gnocl.h gnocl-0.9.96/src/gnocl.h

set curDir [pwd]

cd gnocl-0.9.96/src
set var [list make clean]
exec >@stdout 2>@stderr {*}$var
cd $curDir

file rename gnocl-0.9.96 $base

set var [list tar czvf $base.tar.gz $base]
exec >@stdout 2>@stderr {*}$var

# Remove old file
file delete -force $filename

if {[file exists build]} {
    file delete -force build
}

file mkdir build/BUILD build/RPMS build/SOURCES build/SPECS build/SRPMS
file copy -force $base.tar.gz build/SOURCES
file copy -force assistant.c.patch build/SOURCES

set buildit [list rpmbuild --target $arch --define "_topdir [pwd]/build" -bb tcl-gnocl.spec]
exec >@stdout 2>@stderr {*}$buildit

# Remove our source code
file delete -force $base
file delete $base.tar.gz
