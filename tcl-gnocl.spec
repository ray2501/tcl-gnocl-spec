#
# spec file for package tcl-gnocl
#

%define packagename gnocl

Name:           tcl-gnocl
BuildRequires:  gcc
BuildRequires:  make
BuildRequires:  pkg-config
BuildRequires:  tcl-devel >= 8.4
BuildRequires:  libglade2-devel
BuildRequires:  libnotify-devel
BuildRequires:  glib2-devel >= 2.24
Version:        0.9.96_040520
Release:        0
Summary:        GTK+/Gnome extension for Tcl
License:        BSD-3-Clause
Group:          Development/Languages/Tcl
BuildRoot:      %{_tmppath}/%{name}-%{version}-build
URL:            https://sourceforge.net/projects/gnocl
Source0:        %packagename-%version.tar.gz

%description
Gnocl is a GTK+/Gnome extension for the programming language Tcl.
    
%prep
%setup -q -n %{packagename}-%{version}

%build
cd src
make

%install
mkdir -p %buildroot%tcl_archdir/%{packagename}%{version}
cd src
cp pkgIndex.tcl %buildroot%tcl_archdir/%{packagename}%{version}
cp gnocl.so %buildroot%tcl_archdir/%{packagename}%{version}

%clean
rm -rf %buildroot

%files
%defattr(-,root,root)
%tcl_archdir
%doc license.terms NEWS README

%changelog
