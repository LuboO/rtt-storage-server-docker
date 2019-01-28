FROM debian:stretch-slim

LABEL maintainer.name="Lubo Obratil"
LABEL maintainer.email="lubomir.obratil@gmail.com"
LABEL image.source="https://github.com/LuboO/rtt-storage-server"
LABEL project="https://github.com/crocs-muni/randomness-testing-toolkit"

RUN apt update && \
	apt -y install openssh-server && \
	mkdir -p /run/sshd && \
	adduser --shell /usr/sbin/nologin --disabled-password --no-create-home --gecos "" rtt_storage_user 
	
COPY sshd_config /etc/ssh/
COPY rtt-storage-server-entrypoint.sh /usr/local/bin/
ENV RTT_STORAGE_SERVER_DATA_DIR=/rtt_storage_server_data
VOLUME ["$RTT_STORAGE_SERVER_DATA_DIR"]
EXPOSE 22

ENTRYPOINT ["rtt-storage-server-entrypoint.sh", "$RTT_STORAGE_SERVER_DATA_DIR"]
