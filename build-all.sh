#!/bin/bash
set -e
set -o pipefail

SCRIPT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/$(basename "${BASH_SOURCE[0]}")"
REPO_URL="${REPO_URL:-yokogawa}"
JOBS=${JOBS:-2}

ERRORS="$(pwd)/.errors"
IGNORE="$(pwd)/ignore"

build(){
  base=$1
  suite=$2
  build_dir=$3

  echo "Building ${REPO_URL}/${base}:${suite} for context ${build_dir}"
  docker build --rm --force-rm -t ${REPO_URL}/${base}:${suite} ${build_dir} || return 1

}

dofile() {
  f=$1
  image=${f%Dockerfile}
  base=${image%%\/*}
  build_dir=$(dirname ${f})
  suite=${build_dir##*\/}

  skip=0
  if [[ -f ${IGNORE} ]]; then
    if echo ${base} | grep -f ${IGNORE} >/dev/null; then
      skip=1
    fi
  fi

  if [[ -z "${suite}" ]] || [[ "${suite}" == "${base}" ]]; then
    image_name=${base}
  else
    image_name=${base}-${suite}
  fi

  if [[ ${skip} -eq 0 ]]; then
    {
      $SCRIPT build "${image_name}" latest "${build_dir}"
    } || {
      echo "${image_name}:latest" >> ${ERRORS}
    }
    echo
    echo
  else
    echo "${base} is skipped (${IGNORE})"
  fi
}

main(){
  # get the dockerfiles
  readarray -t files < <(find . -iname '*Dockerfile' | sed 's|./||' | sort)

  # build all dockerfiles
  echo "Running in parallel with ${JOBS} jobs."
  parallel --tag --verbose --ungroup -j"${JOBS}" ${SCRIPT} dofile "{1}" ::: "${files[@]}"

  if [[ ! -f ${ERRORS} ]]; then
    echo "No errors, hooray!"
  else
    echo "[ERROR] Some images did not build correctly, see below." >&2
    echo "These images failed: $(cat ${ERRORS})" >&2
    exit 1
  fi
}

run(){
  args=$@
  f=$1

  if [[ "$f" == "" ]]; then
    main $args
  else
    $args
  fi
}

run $@
