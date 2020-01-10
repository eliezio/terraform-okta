FROM hashicorp/terraform:0.12.19
LABEL authors="eliezio@pm.me"

ARG user=terraform
ARG uid=1000
ARG gid=1000
ARG okta_version=3.0.38
ARG okta_archive=terraform-provider-okta-linux-amd64.zip

ENV HOME=/home/$user

RUN adduser -u $uid -g $gid --disabled-password $user

RUN mkdir /workdir && chown $uid:$gid /workdir

USER $user
RUN cd && mkdir -p .terraform.d/plugins/linux_amd64 \
    && cd .terraform.d/plugins/linux_amd64 \
    && wget -q https://github.com/articulate/terraform-provider-okta/releases/download/v$okta_version/$okta_archive \
    && unzip -j $okta_archive \
    && rm -f $okta_archive

WORKDIR /workdir
VOLUME /workdir

ENTRYPOINT []

CMD terraform

