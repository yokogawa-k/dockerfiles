#!/bin/bash
#
# This script allows you to launch several images
# from this repository once they're built.
#
# Make sure you add the `docker run` command
# in the header of the Dockerfile so the script
# can find it and execute it.
#
# Use pulseaudio/Dockerfile and skype/Dockerfile as examples.

set -e

if [ $# -eq 0 ]; then
  echo "Usage: $0 [--test] image1 image2 ..."
  exit 1
fi

if [ "$1" = "--test" ]; then
  TEST=1
  shift
fi

for name in "$@"; do
  if [[ ${name} =~ ^*:*$ ]]; then
    image_name=${name%:*}
    tag_name=${name#*:}
  else
    image_name=${name}
    tag_name=
  fi
  
  if [[ ! -z ${tag_name} && ${tag_name} != latest ]]; then
    dockerfile=$(find ./${image_name} -path "*${tag_name}*" -name Dockerfile -type f)
  else
    if [[ ${image_name} =~ ^.*-.*$ ]]; then
      dockerfile=$(find ./${image_name%%-*} -path "*${image_name##*-}*" -name Dockerfile -type f)
    else
      dockerfile=$(find ./${image_name} -name Dockerfile -type f)
    fi
  fi

  if [[ -z ${dockerfile} ]]; then
    echo "unable to find container configuration with name ${name}"
    exit 1
  elif [[ ${dockerfile} =~ .*Dockerfile.*Dockerfile ]]; then
    echo "find multipul container configuration with name ${name}"
    echo "${dockerfile}"
    exit 1
  fi

  prehook=`sed -n '/prehook:/,/^#$/p' ${dockerfile} | head -n -1 | sed -e 's/\#//' -e 's/\\\//' -e 's/prehook:'//`
  posthook=`sed -n '/posthook:/,/^#$/p' ${dockerfile} | head -n -1 | sed -e 's/\#//' -e 's/\\\//' -e 's/posthook:'//`
  script=`sed -n '/docker run/,/^#$/p' ${dockerfile} | head -n -1 | sed -e 's/\#//' -e 's/\\\//'`

  if [ ${TEST} ]; then
    echo prehook: ${prehook}
    echo script: ${script}
    echo posthook: ${posthook}
  else
    [ "${prehook}" != "" ]  && eval ${prehook}
    eval ${script}
    [ "${posthook}" != "" ] && eval ${posthook}
  fi

  shift
done
