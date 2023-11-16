# syntax=docker/dockerfile:1.4.1@sha256:91f386bc3ae6cd5585fbd02f811e295b4a7020c23c7691d686830bf6233e91ad

FROM debian:bullseye-20230208-slim@sha256:8eaee63a5ea83744e62d5bf88e7d472d7f19b5feda3bfc6a2304cc074f269269

RUN --mount=type=tmpfs,target=/var/lib/apt/lists \
    --mount=type=tmpfs,target=/var/cache/apt \
    <<_EOFEOF_ bash

    set -e
    set -o pipefail
    set -u
    set -o posix

    export DEBIAN_FRONTEND=noninteractive

    apt-get update

    # unzip is needed by many pts tests implicitly 
    # install apt-utils to avoid some wornings
    # ca-certificates should be needed by many pts tests
    apt-get -y install --no-install-recommends unzip apt-utils ca-certificates

    # install wget temporarily
    apt-get -y install --no-install-recommends wget

    cd /dev/shm

    wget -O tmp.deb "https://phoronix-test-suite.com/releases/repo/pts.debian/files/phoronix-test-suite_10.8.4_all.deb"
    apt-get -y remove wget
    apt-get -y autoremove

    apt-get -y install ./tmp.deb

_EOFEOF_

RUN <<_EOFEOF_ bash

    set -e
    set -o pipefail
    set -u
    set -o posix

    # for batch testing
    phoronix-test-suite user-config-set SaveResults=TRUE
    phoronix-test-suite user-config-set OpenBrowser=FALSE
    phoronix-test-suite user-config-set UploadResults=FALSE
    phoronix-test-suite user-config-set PromptForTestIdentifier=FALSE
    phoronix-test-suite user-config-set PromptForTestDescription=FALSE
    phoronix-test-suite user-config-set PromptSaveName=FALSE
    phoronix-test-suite user-config-set RunAllTestCombinations=TRUE
    phoronix-test-suite user-config-set Configured=TRUE

_EOFEOF_
