FROM registry.access.redhat.com/ubi8:latest
RUN dnf install -y ethtool net-tools
COPY ./ethtool_time_info.sh /

WORKDIR /
ENTRYPOINT [ "/ethtool_time_info.sh" ]
