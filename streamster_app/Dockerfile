FROM ubuntu:18.04 AS builder

ARG PROJECT_DIR=/srv/api
ENV PATH=/opt/flutter/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin


RUN apt-get update && \
    apt-get install -y \
        xz-utils \
        git \
        openssh-client \
        unzip \
        curl && \
    apt-get upgrade -y && \
    rm -rf /var/cache/apt

RUN curl -L https://storage.googleapis.com/flutter_infra/releases/stable/linux/flutter_linux_1.20.4-stable.tar.xz | tar -C /opt -xJ

RUN apt-get install -y lib32stdc++6

RUN export PATH="$PATH":"/opt/flutter/.pub-cache/bin"
RUN flutter doctor
RUN flutter channel beta
RUN flutter config --enable-web
RUN flutter upgrade

WORKDIR ${PROJECT_DIR}
COPY ./ ./


RUN flutter packages pub global activate webdev
RUN flutter packages upgrade
RUN flutter build web -t lib/main_prod.dart

FROM nginx:alpine
COPY --from=builder /srv/api/build/web /usr/share/nginx/html
EXPOSE 80