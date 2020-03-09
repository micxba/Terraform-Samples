FROM golang:1.13.4

ARG TERRAFORM_VERSION=unspecified

# Run commands run at the build time and initialize the image
RUN  apt-get update -y && \
     apt-get install apt-utils -y && \
     apt-get install curl -y && \
     apt-get install unzip -y && \
     apt-get install gnupg -y && \
     apt-get install libdigest-sha-perl -y && \
     curl -Os https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
     curl -Os https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_SHA256SUMS && \
     curl https://keybase.io/hashicorp/pgp_keys.asc | gpg --import && \
     curl -Os https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_SHA256SUMS.sig  && \
     gpg --verify terraform_${TERRAFORM_VERSION}_SHA256SUMS.sig terraform_${TERRAFORM_VERSION}_SHA256SUMS && \
     shasum -a 256 -c terraform_${TERRAFORM_VERSION}_SHA256SUMS 2>&1 | grep "${TERRAFORM_VERSION}_linux_amd64.zip:\sOK" && \
     unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /usr/local/bin && \
     curl https://raw.githubusercontent.com/golang/dep/master/install.sh | sh && \
     go get -u github.com/jstemmer/go-junit-report

# Volumes are being mount to allow users of the container to mount thier modules and backend.hcl file when running containers
VOLUME ["/go/src/Module"]
VOLUME ["/output"]

# It initializes the location of the working area
WORKDIR /go/src

# Copy sends the Context to the Image Build. In this case it copies the Validate.ps1 
COPY  . .

# CMD runs the executable when running a container. Here as soon as the container is run it initializes and validates the container, provided the backend.hcl is mounted to the container.
CMD ["/bin/bash","-f","test.sh"]


