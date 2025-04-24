#!/usr/bin/env bash
cd "$(realpath "$(dirname "$0")")"

./mod_tf_linux64 -console -window -h 1440 -w 2560 -novid +m_rawinput 0 "$@"
exit $?
