FROM alpine:3.11

# Install common cli tools
RUN apk add --no-cache curl python3 jq

# Install AWS CLI v1
ENV AWS_CLI_VERSION=1.18.39
RUN pip3 install awscli==${AWS_CLI_VERSION} --upgrade

# Install aws-iam-authenticator for k8s
RUN curl -Lo /usr/bin/aws-iam-authenticator https://github.com/kubernetes-sigs/aws-iam-authenticator/releases/download/v0.5.0/aws-iam-authenticator_0.5.0_linux_amd64 && \
    chmod +x /usr/bin/aws-iam-authenticator

# Install kubectl
ENV KUBECTL_VERSION=1.16.7
RUN curl -Lo /usr/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl && \
    chmod +x /usr/bin/kubectl

# Install helm
ENV HELM_VERSION=2.16.5
RUN cd /tmp && \
    curl -o helm.tgz https://storage.googleapis.com/kubernetes-helm/helm-v${HELM_VERSION}-linux-amd64.tar.gz && \
    tar xvfz helm.tgz && \
    mv linux-amd64/helm /usr/bin/helm && \
    rm -rf /tmp/*
