CTAGS_URL=https://github.com/universal-ctags/ctags/archive/refs/tags/p6.0.20230806.0.tar.gz
CTAGS_TAR=ctags-p6.0.20230806.0.tar.gz
CTAGS_NAME=${CTAGS_TAR/%.tar.*/}

JANSSON_URL=https://github.com/akheron/jansson/releases/download/v2.14/jansson-2.14.tar.bz2
JANSSON_TAR=jansson-2.14.tar.bz2
JANSSON_NAME=${JANSSON_TAR/%.tar.*/}

PCRE2_URL=https://github.com/PCRE2Project/pcre2/releases/download/pcre2-10.42/pcre2-10.42.tar.bz2
PCRE2_TAR=pcre2-10.42.tar.bz2
PCRE2_NAME=${PCRE2_TAR/%.tar.*/}

download() {
    mkdir -p tars

    if [[ ! -f tars/$CTAGS_TAR ]]; then
        curl -L -o tars/$CTAGS_TAR $CTAGS_URL
    fi

    if [[ ! -f tars/$JANSSON_TAR ]]; then
        curl -L -o tars/$JANSSON_TAR $JANSSON_URL
    fi

     if [[ ! -f tars/$PCRE2_TAR ]]; then
        curl -L -o tars/$PCRE2_TAR $PCRE2_URL
    fi
}
