FROM ghcr.io/hotio/base@sha256:05ed569c200448e11b1fb72bbd9609abef36f9d64f3174a61d908a89fe44c75c

EXPOSE 8080 8443 2019

ENV CUSTOM_BUILD=""

RUN apk add --no-cache nss-tools fail2ban

ARG VERSION
RUN curl -fsSL "https://github.com/caddyserver/caddy/releases/download/v${VERSION}/caddy_${VERSION}_linux_arm64.tar.gz" | tar xzf - -C "${APP_DIR}" && \
    chmod -R u=rwX,go=rX "${APP_DIR}" && \
    ln -s "${APP_DIR}/caddy" "/usr/local/bin/caddy" && \
    cp -R /etc/fail2ban "${APP_DIR}/" && \
    rm -rf /etc/fail2ban && \
    ln -s "${CONFIG_DIR}/fail2ban" "/etc/fail2ban"

COPY root/ /