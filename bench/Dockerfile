# syntax=docker/dockerfile:1.4.1

FROM ghcr.io/tksst/phoronix-bench-images/phoronix-bench-image-base:sha-e64b3d1-20230226T033032Z

ARG MYTESTS="pts/openssl-3.0.1 pts/stream-1.3.4 pts/go-benchmark-1.1.4 pts/node-express-loadtest-1.0.1 pts/node-web-tooling-1.0.1 pts/git-1.1.0"
ENV MYTESTS $MYTESTS

RUN --mount=type=tmpfs,target=/var/lib/apt/lists \
    --mount=type=tmpfs,target=/var/cache/apt \
    <<_EOFEOF_ bash

    set -e
    set -o pipefail
    set -u
    set -o posix

    export DEBIAN_FRONTEND=noninteractive

    apt-get update

    phoronix-test-suite install-dependencies $MYTESTS

_EOFEOF_

# for pts/node-web-tooling-1.0.1 
RUN --mount=type=tmpfs,target=/var/lib/apt/lists \
    --mount=type=tmpfs,target=/var/cache/apt \
    <<_EOFEOF_ bash

    set -e
    set -o pipefail
    set -u
    set -o posix

    export DEBIAN_FRONTEND=noninteractive

    apt-get update

    apt-get -y install webpack

_EOFEOF_

RUN phoronix-test-suite make-download-cache ${MYTESTS}

COPY --chmod=755 ./my-benchmark.expect ./build-suite.sh /tmp/

RUN --mount=type=tmpfs,target=/var/lib/apt/lists \
    --mount=type=tmpfs,target=/var/cache/apt \
    <<_EOFEOF_ bash

    set -e
    set -o pipefail
    set -u
    set -o posix

    apt-get update
    apt-get -y install expect

    /tmp/my-benchmark.expect

    apt-get -y remove expect
    apt-get -y autoremove

_EOFEOF_

RUN rm -f /etc/machine-id

COPY --chmod=755 ./bench.sh /

ENTRYPOINT ["/bench.sh"]
