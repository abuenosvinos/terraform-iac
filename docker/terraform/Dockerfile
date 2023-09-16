FROM alpine:latest

ARG TG_VERSION=0.38.6
ARG TF_VERSION=1.2.5
ARG TFSEC_VERSION=1.5.0

# TERRAFORM

RUN wget https://releases.hashicorp.com/terraform/${TF_VERSION}/terraform_${TF_VERSION}_linux_amd64.zip \
    && unzip terraform_${TF_VERSION}_linux_amd64.zip \
    && mv terraform /usr/bin/terraform

# TERRAGRUNT

RUN apk add --update --no-cache bash git openssh

# Determine the target architecture using uname -m
RUN case `uname -m` in \
        x86_64) ARCH=amd64; ;; \
        armv7l) ARCH=arm; ;; \
        aarch64) ARCH=arm64; ;; \
        ppc64le) ARCH=ppc64le; ;; \
        s390x) ARCH=s390x; ;; \
        *) echo "Unsupported architecture, exiting..."; exit 1; ;; \
    esac \
    && TERRAGRUNT_URL="https://github.com/gruntwork-io/terragrunt/releases/download/v${TG_VERSION}/terragrunt_linux_${ARCH}" \
    && wget -q "${TERRAGRUNT_URL}" -O /usr/local/bin/terragrunt \
    && chmod +x /usr/local/bin/terragrunt

# TFSEC

RUN wget -q -O tfsec https://github.com/aquasecurity/tfsec/releases/download/v$TFSEC_VERSION/tfsec-linux-amd64 \
    && chmod +x ./tfsec \
    && mv ./tfsec /usr/local/bin/tfsec

#COPY ./../../* /app

WORKDIR /app

#ENTRYPOINT ["/usr/local/bin/terraform"]
