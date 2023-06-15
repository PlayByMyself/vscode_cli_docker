FROM ubuntu:22.04

ARG CODE_CLI_VERSION

RUN apt-get update && \
    apt-get install -y git curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    curl -sL "https://update.code.visualstudio.com/${CODE_CLI_VERSION}/cli-alpine-x64/stable" \
        --output /tmp/vscode-cli.tar.gz && \
    tar -xf /tmp/vscode-cli.tar.gz -C /usr/bin && \
    rm /tmp/vscode-cli.tar.gz

CMD [ "code", "tunnel", "--accept-server-license-terms" ]
