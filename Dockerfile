FROM ubuntu:xenial

# Install MySQL client, curl
RUN apt-get update && \
    apt-get install -y mysql-client curl

# Install Summon
RUN cd /usr/local/bin && \
    curl -sSL https://github.com/conjurinc/summon/releases/download/v0.6.0/summon_v0.6.0_linux_amd64.tar.gz | tar xvz

# Install the Conjur provider for Summon
RUN mkdir -p /usr/local/lib/summon && \
    cd /usr/local/lib/summon && \
    curl -sSL https://github.com/conjurinc/summon-conjur/releases/download/v0.2.0/summon-conjur_v0.2.0_linux-amd64.tar.gz | tar xvz
