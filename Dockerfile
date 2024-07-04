FROM ubuntu:latest                                                                                                                                                                                            

ENV NODE_VERSION=20.15.0
RUN apt-get update && apt install -y curl git python3 build-essential pkg-config
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
ENV NVM_DIR=/root/.nvm
RUN . "$NVM_DIR/nvm.sh" && nvm install ${NODE_VERSION}
RUN . "$NVM_DIR/nvm.sh" && nvm use v${NODE_VERSION}
RUN . "$NVM_DIR/nvm.sh" && nvm alias default v${NODE_VERSION}
ENV PATH="/root/.nvm/versions/node/v${NODE_VERSION}/bin/:${PATH}"
RUN node --version
RUN npm --version
RUN npm i -g yarn
RUN git clone https://github.com/cypress-io/cypress-realworld-app.git cypress --single-branch
WORKDIR cypress
RUN yarn
ARG CACHEBUST=1 
RUN yarn build
