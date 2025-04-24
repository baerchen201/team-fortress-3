#!/usr/bin/env bash
cd "$(realpath "$(dirname "$0")")"

while true; do
  clear
  (
    cd src
    ./buildallprojects
    exit $?
  )
  if [ $? = 0 ]; then
    echo -e "\e[90mBuild succeeded, launching game\e[0m"
    (
      cd game
      ./launch.sh
      exit $?
    )
    _e=$?
    echo -en "\e[0m"
    if [ $_e = 0 ]; then
      echo -en "\e[90m"
    else
      echo -en "\e[1;91m"
    fi
    echo -e "Game process exited with code $_e\e[0m"
  else
    echo -e "\e[1;91mBuild process exited with code $?\e[0m"
  fi

  trap "echo;exit 0" SIGINT
  read -st 0.2 -N 1000
  if [ -n "$anykey" ]; then
    echo -en "\e[90mPress any key to restart...\e[0m"
    read -sn 1
  else
    echo -en "\e[90mPress enter to restart...\e[0m"
    read -s
  fi
  trap SIGINT
done
