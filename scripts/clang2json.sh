#!/bin/sh
set -eux
FBCLANGDIR="$HOME/github/infer/facebook-clang-plugins"
PLUGIN=$FBCLANGDIR/libtooling/build/FacebookClangPlugin.dylib
CLANG=$FBCLANGDIR/clang/install/bin/clang

$CLANG\
        -fsyntax-only\
        -Xpreprocessor -detailed-preprocessing-record\
        -Xclang -load\
        -Xclang $PLUGIN\
        -Xclang -plugin\
        -Xclang YojsonASTExporter\
        -Xclang -plugin-arg-YojsonASTExporter\
        -Xclang $1.yojson\
        -c $1
