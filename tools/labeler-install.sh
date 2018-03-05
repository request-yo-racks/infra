#!/bin/bash
set -euo pipefail

: ${BIN_DIR:=bin}
: ${LABELER_VERSION:=1.0.0}
LABELER_RELEASE=https://github.com/tonglil/labeler/releases/download
LABELER_BIN=labeler

mkdir -p ${BIN_DIR}
if [ ! -f ${BIN_DIR}/${LABELER_BIN} ]; then
  wget ${LABELER_RELEASE}/${LABELER_VERSION}/${LABELER_BIN}-darwin-amd64.zip -O ${BIN_DIR}/${LABELER_BIN}.zip
  unzip ${BIN_DIR}/${LABELER_BIN}.zip -d ${BIN_DIR}
  chmod +x ${BIN_DIR}/${LABELER_BIN}
fi
