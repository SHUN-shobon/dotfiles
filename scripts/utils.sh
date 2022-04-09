#!/usr/bin/env sh

function has() {
  which "$1" > /dev/null 2>&1
  return $?
}

function die() {
  echo $@ >&2
  exit 1
}
