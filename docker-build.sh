#!/usr/bin/env bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

init_var() {
  ECHO_TYPE="echo -e"

  version=2.7.0

  arch_arr="linux/386,linux/amd64,linux/arm/v6,linux/arm/v7,linux/arm64,linux/ppc64le,linux/s390x"
}

echo_content() {
  case $1 in
  "red")
    ${ECHO_TYPE} "\033[31m$2\033[0m"
    ;;
  "green")
    ${ECHO_TYPE} "\033[32m$2\033[0m"
    ;;
  "yellow")
    ${ECHO_TYPE} "\033[33m$2\033[0m"
    ;;
  "blue")
    ${ECHO_TYPE} "\033[34m$2\033[0m"
    ;;
  "purple")
    ${ECHO_TYPE} "\033[35m$2\033[0m"
    ;;
  "skyBlue")
    ${ECHO_TYPE} "\033[36m$2\033[0m"
    ;;
  "white")
    ${ECHO_TYPE} "\033[37m$2\033[0m"
    ;;
  esac
}

main() {
  echo_content skyBlue "start build caddy-forwardproxy CPU：${arch_arr}"

  if [[ ${version} != "latest" ]]; then
    docker buildx build -t jonssonyan/caddy-forwardproxy:${version} --platform ${arch_arr} --push .
    if [[ "$?" == "0" ]]; then
      echo_content green "caddy-forwardproxy-linux Version：${version} CPU：${arch_arr} build success"
    else
      echo_content red "caddy-forwardproxy-linux Version：${version} CPU：${arch_arr} build failed"
    fi
  fi

  docker buildx build -t jonssonyan/caddy-forwardproxy:latest --platform ${arch_arr} --push .
  if [[ "$?" == "0" ]]; then
    echo_content green "caddy-forwardproxy Version：latest CPU：${arch_arr} build success"
  else
    echo_content red "caddy-forwardproxy-linux Version：latest CPU：${arch_arr} build failed"
  fi

  echo_content skyBlue "caddy-forwardproxy CPU：${arch_arr} build finished"
}

init_var
main
