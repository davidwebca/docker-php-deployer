# Pull from the official php image
# (using direct composer image is discouraged)
# 
# It is an Alpine-Linux image in the background,
# so we can install pretty much anything on it
# 
# libssh2 is needed for git-ftp, git overrides it
# so we need to install curl last apparently
FROM php:8.0.25-cli-alpine
MAINTAINER davidwebca info@davidweb.ca

# Updates and required libs
RUN apk update --no-cache \
    && apk upgrade --no-cache \
    && apk add --no-cache \
            bash \
            git \
            make \
            rsync \
            openssh-client-default \
            sshpass \
            openssh-keygen \
            ca-certificates \
            tzdata \
            libstdc++ \
            libgcc \
    && wget https://github.com/moparisthebest/static-curl/releases/latest/download/curl-amd64 \ 
    && chmod +x curl-amd64 \ 
    && mv curl-amd64 /usr/bin/curl \ 
    && update-ca-certificates \
    && rm -rf /var/cache/apk/*

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer --version=2.2.9

# Install Node and Yarn via n (since Alpine doesn't have all available versions through apk)
# Read: https://github.com/tj/n/issues/648
RUN curl -L https://raw.githubusercontent.com/tj/n/master/bin/n -o n \
    && chmod u+x n \
    && N_NODE_MIRROR=https://unofficial-builds.nodejs.org/download/release ./n 16 --arch x64-musl lts

# Install git-ftp
RUN git clone https://github.com/git-ftp/git-ftp.git /opt/git-ftp \
    && cd /opt/git-ftp \
    && tag="$(git tag | grep '^[0-9]*\.[0-9]*\.[0-9]*$' | tail -1)" \
    && git checkout "$tag" \
    && make install \
    && rm -rf /opt/git-ftp

CMD ["bash"]