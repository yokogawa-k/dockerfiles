# Run dripcap app in a container
#
# docker run --rm -it \
#       -v /etc/localtime:/etc/localtime:ro \
#       -v "${HOME}/.dripcap:/root/.dripcap" \
#       --name dripcap-package-build \
#       yokogawa/dripcap-package-build
#

FROM node

RUN npm install -g dripcap

CMD ["bash"]
