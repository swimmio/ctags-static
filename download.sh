strip_tar_ext() {
    echo ${1/%.tar.*}
}


CTAGS_URL=https://github.com/universal-ctags/ctags/archive/refs/tags/p6.0.20230806.0.tar.gz
CTAGS_TAR=ctags-p6.0.20230806.0.tar.gz
CTAGS_NAME=$(strip_tar_ext $CTAGS_TAR)

JANSSON_URL=https://github.com/akheron/jansson/releases/download/v2.14/jansson-2.14.tar.bz2
JANSSON_TAR=jansson-2.14.tar.bz2
JANSSON_NAME=$(strip_tar_ext $JANSSON_TAR)

PCRE2_URL=https://github.com/PCRE2Project/pcre2/releases/download/pcre2-10.42/pcre2-10.42.tar.bz2
PCRE2_TAR=pcre2-10.42.tar.bz2
PCRE2_NAME=$(strip_tar_ext $PCRE2_TAR)

ICU4C_URL=https://github.com/unicode-org/icu/releases/download/release-73-2/icu4c-73_2-src.tgz
ICU4C_TAR=icu4c-73_2-src.tgz
ICU4C_NAME=icu

LIBXML2_URL=https://download.gnome.org/sources/libxml2/2.11/libxml2-2.11.5.tar.xz
LIBXML2_TAR=libxml2-2.11.5.tar.xz
LIBXML2_NAME=$(strip_tar_ext $LIBXML2_TAR)

LIBYAML_URL=http://pyyaml.org/download/libyaml/yaml-0.2.5.tar.gz
LIBYAML_TAR=yaml-0.2.5.tar.gz
LIBYAML_NAME=$(strip_tar_ext $LIBYAML_TAR)

download_tar() {
    if [[ ! -f tars/$1 ]]; then
        curl -L -o tars/$1 $2
    fi
}

download() {
    mkdir -p tars

    download_tar $CTAGS_TAR $CTAGS_URL
    download_tar $JANSSON_TAR $JANSSON_URL
    download_tar $PCRE2_TAR $PCRE2_URL
    download_tar $ICU4C_TAR $ICU4C_URL
    download_tar $LIBXML2_TAR $LIBXML2_URL
    download_tar $LIBYAML_TAR $LIBYAML_URL
}
