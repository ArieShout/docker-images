#!/bin/bash 
#===============================================================================
#          FILE:  entrypoint.sh
# 
#   DESCRIPTION: Entry point to start the ssr server. 
# 
#        AUTHOR: ArieShout
#       CREATED: 07/09/2017 17:16:57 CST
#===============================================================================

cd "$SS_WORKDIR"
exec python server.py -s "$SS_SERVER" -p "$SS_PORT" -m "$SS_METHOD" -k "$SS_PASSWORD" -O "$SSR_PROTOCOL" -o "$SSR_CRYPTO" "$@"

