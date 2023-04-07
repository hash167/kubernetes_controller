FROM --platform=arm64 ubuntu

RUN apt-get update
RUN apt-get install -y curl jq

WORKDIR /controller

# Install kubectl
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && chmod +x kubectl

# Install vegeta
RUN curl -LO "https://github.com/tsenart/vegeta/releases/download/v12.8.3/vegeta-12.8.3-linux-arm64.tar.gz"
RUN tar -zxvf vegeta-12.8.3-linux-arm64.tar.gz

ENV PATH="/controller:${PATH}"

COPY ./controller.sh .
CMD ["./controller.sh"]