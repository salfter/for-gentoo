# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI="3"
GCONF_DEBUG="no"

inherit autotools gnome2 mate-desktop.org

DESCRIPTION="User Interface routines for MATE"
HOMEPAGE="http://mate-desktop.org"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="doc test"

# gtk+-2.14 dep instead of 2.12 ensures system doesn't loose VFS capabilities in GtkFilechooser
RDEPEND=">=dev-libs/libxml2-2.4.20:2
	mate-base/libmate
	mate-base/libmatecanvas
	mate-base/libmatecomponentui
	mate-base/mate-conf
	>=x11-libs/pango-1.1.2
	>=dev-libs/glib-2.16:2
	>=x11-libs/gtk+-2.14:2
	mate-base/mate-vfs
	>=gnome-base/libglade-2:2.0
	mate-base/mate-keyring
	>=dev-libs/popt-1.5"
DEPEND="${RDEPEND}
	sys-devel/gettext
	virtual/pkgconfig
	>=dev-util/intltool-0.40
	doc? ( >=dev-util/gtk-doc-1 )"

PDEPEND="x11-themes/mate-icon-theme"

DOCS="AUTHORS ChangeLog NEWS README"

src_prepare() {
	gtkdocize || die
	eautoreconf
	gnome2_src_prepare

	if ! use test; then
		sed 's/ test-gnome//' -i Makefile.am Makefile.in || die "sed failed"
	fi
}