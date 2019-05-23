# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit qmake-utils eutils

DESCRIPTION="A good looking terminal emulator which mimics the old cathode display"
HOMEPAGE="https://github.com/Swordfish90/cool-retro-term"

SRC_URI="${HOMEPAGE}/archive/${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="x86 amd64"
RESTRICT="mirror"


LICENSE="LGPL-3.0"
SLOT="0"
IUSE=""

DEPEND="
	>=dev-qt/qtquickcontrols-5.2.0:5[widgets]
	>=dev-qt/qtgraphicaleffects-5.2.0:5
	>=dev-qt/qtdeclarative-5.2.0:5[localstorage]
	dev-qt/qmltermwidget
"

RDEPEND="${DEPEND}"


src_prepare(){
	sed -i '/qmltermwidget/d' ${PN}.pro
	eapply_user
}

src_configure(){
	eqmake5 ${PN}.pro PREFIX="${EPREFIX}/usr" DESKTOPDIR="${EPREFIX}/usr/share/applications" ICONDIR="${EPREFIX}/usr/share/pixmaps" 
}

src_compile(){
	emake INSTALL_ROOT="${D}" 
}

src_install(){
	emake INSTALL_ROOT="${D}" install 
}
