# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools gnome2-utils
KEYWORDS="~amd64 ~x86"
MY_PV="d8be50f"
[[ -n ${PV%%*_p*} ]] && MY_PV="v${PV}"
SRC_URI="https://gitlab.com/jenslody/${PN}/-/archive/${MY_PV}/${PN}-${MY_PV}.tar.bz2 -> ${P}.tar.bz2 "
#RESTRICT="primaryuri"
S="${WORKDIR}/${PN}-${MY_PV#v}"

DESCRIPTION="A simple extension for displaying weather informations from several cities in GNOME Shell"
HOMEPAGE="https://github.com/jenslody/${PN}"

LICENSE="GPL-3+"
SLOT="0"
IUSE="nls"

DEPEND="
	app-eselect/eselect-gnome-shell-extensions
"
RDEPEND="
	${DEPEND}
	>=gnome-base/gnome-shell-3.34
"
BDEPEND="
	nls? ( sys-devel/gettext )
"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local _v=$(sed -e '/^\(Version\|Release\):/!d; s:[^0-9.]::g' \
		"${S}"/${PN}.spec |tr '\n' '.')
	_v=${_v%..}
	if [[ -z ${PV%%*_p*} ]]; then
		_v=${_v}.${MY_PV}
	fi
	econf \
		$(use_enable nls) \
		GIT_VERSION=${_v:-${PV}}
}

pkg_preinst() {
	gnome2_schemas_savelist
}

pkg_postinst() {
	gnome2_schemas_update
	eselect gnome-shell-extensions update
}

pkg_postrm() {
	gnome2_schemas_update
	eselect gnome-shell-extensions update
}