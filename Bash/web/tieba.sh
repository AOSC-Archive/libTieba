#!/bin/bash
# web/Tieba.sh: Library for loading Tieba things, thru web.
# -*- vim:fenc=utf-8:shiftwidth=2:softtabstop=2
export LIBDIR=${LIBDIR:-/usr/lib/tieba}

. $LIBDIR/web/*.sh
. $LIBDIR/urlencode.sh

