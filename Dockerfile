FROM alpine:3.12

# Install common cli tools
RUN apk add --no-cache curl py3-pip jq make grep

# Install AWS CLI v1
ENV AWS_CLI_VERSION=1.18.39
RUN pip3 install awscli==${AWS_CLI_VERSION} --upgrade

# Install aws-iam-authenticator for k8s
ENV AWS_IAM_AUTH_VERSION=0.5.0
RUN curl -Lo /usr/bin/aws-iam-authenticator https://github.com/kubernetes-sigs/aws-iam-authenticator/releases/download/v${AWS_IAM_AUTH_VERSION}/aws-iam-authenticator_${AWS_IAM_AUTH_VERSION}_linux_amd64 && \
    chmod +x /usr/bin/aws-iam-authenticator

# Install kubectl
ENV KUBECTL_VERSION=1.18.10
RUN curl -Lo /usr/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl && \
    chmod +x /usr/bin/kubectl

# Install helm
ENV HELM_VERSION=3.4.1
RUN cd /tmp && \
    curl -Lo helm.tgz https://get.helm.sh/helm-v${HELM_VERSION}-linux-amd64.tar.gz && \
    tar xvfz helm.tgz && \
    mv linux-amd64/helm /usr/bin/helm && \
    rm -rf /tmp/*
