# syntax=docker/dockerfile:1.4.1

FROM debian:bullseye-20221205-slim

RUN --mount=type=tmpfs,target=/var/lib/apt/lists \
    --mount=type=tmpfs,target=/var/cache/apt \
    --mount=type=tmpfs,target=/tmp/packages \
    <<_EOFEOF_

    set -e

    export DEBIAN_FRONTEND=noninteractive

    apt-get update
    apt-get -y install wget unzip

    cd /tmp/packages

    wget -O tmp.deb "https://phoronix-test-suite.com/releases/repo/pts.debian/files/phoronix-test-suite_10.8.4_all.deb"
    apt-get -y install ./tmp.deb

    phoronix-test-suite user-config-set RemoveDownloadFiles=TRUE
    phoronix-test-suite install pts/openssl pts/stream pts/go-benchmark pts/node-express-loadtest pts/node-web-tooling pts/git

    apt-get -y remove wget 

_EOFEOF_

RUN <<_EOFEOF_

    phoronix-test-suite user-config-set SaveResults=TRUE
    phoronix-test-suite user-config-set OpenBrowser=FALSE
    phoronix-test-suite user-config-set UploadResults=FALSE
    phoronix-test-suite user-config-set PromptForTestIdentifier=FALSE
    phoronix-test-suite user-config-set PromptForTestDescription=FALSE
    phoronix-test-suite user-config-set PromptSaveName=FALSE
    phoronix-test-suite user-config-set RunAllTestCombinations=TRUE
    phoronix-test-suite user-config-set Configured=TRUE

_EOFEOF_
