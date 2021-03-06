# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/emul-linux-x86-medialibs/emul-linux-x86-medialibs-20140508-r2.ebuild,v 1.2 2014/05/29 21:15:13 mgorny Exp $

EAPI=5
inherit emul-linux-x86

LICENSE="APL-1.0 GPL-2 BSD BSD-2 public-domain LGPL-2 MPL-1.1 LGPL-2.1 !abi_x86_32? ( MPEG-4 )"
KEYWORDS="-* ~amd64"
IUSE="abi_x86_32 +pulseaudio"

DEPEND=""
# required libs
RDEPEND="
	!abi_x86_32? (
		~app-emulation/emul-linux-x86-baselibs-${PV}
		~app-emulation/emul-linux-x86-xlibs-${PV}
		~app-emulation/emul-linux-x86-db-${PV}
	)
	abi_x86_32? (
		app-arch/bzip2[abi_x86_32(-)]
		dev-libs/glib[abi_x86_32(-)]
		dev-libs/libxml2[abi_x86_32(-)]
		media-libs/alsa-lib[abi_x86_32(-)]
		media-libs/freetype[abi_x86_32(-)]
		media-libs/libpng[abi_x86_32(-)]
		media-libs/libvorbis[abi_x86_32(-)]
		media-sound/jack-audio-connection-kit[abi_x86_32(-)]
		sci-libs/fftw[abi_x86_32(-)]
		virtual/jpeg:62[abi_x86_32(-)]
		x11-libs/libX11[abi_x86_32(-)]
		x11-libs/libXext[abi_x86_32(-)]
		x11-libs/libXfixes[abi_x86_32(-)]
		pulseaudio? ( media-sound/pulseaudio[abi_x86_32(-)] )
	)
	!<=app-emulation/emul-linux-x86-sdl-20081109
	!<=app-emulation/emul-linux-x86-soundlibs-20110101"

# supplied libs
RDEPEND="${RDEPEND}
	abi_x86_32? (
		>=media-libs/libvpx-1.2.0_pre[abi_x86_32(-)]
		>=media-libs/xvid-1.3.2-r1[abi_x86_32(-)]
		>=media-sound/lame-3.99.5-r1[abi_x86_32(-)]
		>=media-libs/faac-1.28-r4[abi_x86_32(-)]
		>=media-libs/faad2-2.7-r3[abi_x86_32(-)]
		>=media-libs/libtheora-1.1.1-r1[abi_x86_32(-)]
		>=media-libs/libcuefile-477-r1[abi_x86_32(-)]
		>=media-libs/libreplaygain-477-r1[abi_x86_32(-)]
		>=media-libs/libmad-0.15.1b-r8[abi_x86_32(-)]
		>=media-libs/libdca-0.0.5-r3[abi_x86_32(-)]
		>=media-libs/speex-1.2_rc1-r2[abi_x86_32(-)]
		>=media-libs/libdvdread-4.2.0-r1[abi_x86_32(-)]
		>=media-libs/libdvdnav-4.2.0-r1[abi_x86_32(-)]
		>=media-libs/libv4l-0.9.5-r1[abi_x86_32(-)]
		>=media-libs/libid3tag-0.15.1b-r4[abi_x86_32(-)]
		>=media-libs/libshout-2.3.1-r1[abi_x86_32(-)]
		>=media-libs/libsidplay-2.1.1-r3:2[abi_x86_32(-)]
		>=media-libs/libsidplay-1.36.59-r1:1[abi_x86_32(-)]
		>=media-libs/x264-0.0.20130731[abi_x86_32(-)]
		>=media-libs/libiec61883-1.2.0-r1[abi_x86_32(-)]
		>=media-libs/a52dec-0.7.4-r7[abi_x86_32(-)]
		>=media-libs/libmimic-1.0.4-r2[abi_x86_32(-)]
		>=media-libs/libmms-0.6.2-r1[abi_x86_32(-)]
		>=media-libs/libvisual-0.4.0-r3:0.4[abi_x86_32(-)]
		>=media-libs/libmpeg2-0.5.1-r2[abi_x86_32(-)]
		>=dev-libs/liboil-0.3.17-r2[abi_x86_32(-)]
		>=sys-libs/libieee1284-0.2.11-r3[abi_x86_32(-)]
		>=dev-libs/fribidi-0.19.5-r2[abi_x86_32(-)]
		>=dev-libs/libcdio-0.92[abi_x86_32(-)]
		>=dev-libs/libcdio-paranoia-0.90_p1-r1[abi_x86_32(-)]
		>=virtual/ffmpeg-0.10.8:0[abi_x86_32(-)]
		>=media-libs/libdv-1.0.0-r3[abi_x86_32(-)]
		>=media-libs/libgphoto2-2.5.4-r1[abi_x86_32(-)]
		>=media-gfx/sane-backends-1.0.24-r4[abi_x86_32(-)]
		media-libs/gstreamer:0.10[abi_x86_32(-)]
		media-libs/gst-plugins-base:0.10[abi_x86_32(-)]
	)
	"
PDEPEND="!abi_x86_32? ( ~app-emulation/emul-linux-x86-soundlibs-${PV} )"

pkg_pretend() {
	if use abi_x86_32 && ! use pulseaudio; then
		ewarn "You have disabled USE=pulseaudio. This is known to break pre-built"
		ewarn "libavfilter. If you need it, please turn USE=pulseaudio back on."
	fi
}

src_prepare() {
	# Include all libv4l libs, bug #348277
	ALLOWED="${S}/usr/lib32/libv4l/"
	emul-linux-x86_src_prepare

	# Remove migrated stuff.
	use abi_x86_32 && rm -f $(sed "${FILESDIR}/remove-native-${PVR}" -e '/^#/d')
}
