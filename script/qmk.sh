#!/usr/bin/env bash

pushd qmk/zsa_qmk_firmware > /dev/null || exit 1

make git-submodule

popd > /dev/null || return
