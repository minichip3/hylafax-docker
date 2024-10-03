# Ubuntu 18.04 기반 이미지 사용
FROM ubuntu:bionic

# 비대화형 모드 설정
ENV DEBIAN_FRONTEND=noninteractive

# APT 소스 업데이트
RUN apt-get update && apt-get install -y && \
    apt-get update

RUN apt-get install -y \
    hylafax-server \
    supervisor

# t38modem 설치
COPY ./pkgs /tmp
RUN if [ "$(uname -m)" = "x86_64" ]; then \
      dpkg -i /tmp/t38modem_2.0.0-4build3_amd64.deb || apt-get install -f -y; \
    elif [ "$(uname -m)" = "aarch64" ]; then \
      dpkg -i /tmp/t38modem_2.0.0-4build3_arm64.deb || apt-get install -f -y; \
    else \
      echo "Unsupported architecture"; exit 1; \
    fi

# Supervisor 설정 복사
COPY ./supervisord.conf /etc/supervisor/supervisord.conf
COPY ./init-hylafax.sh /usr/sbin/hylafax-init.sh

ENV SIPADDR=sip.example.com
ENV SIPUSER=user
ENV SIPPASS=password

# Supervisor 실행 설정
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]