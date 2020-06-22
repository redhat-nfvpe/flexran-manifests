FROM centos:centos7.7.1908
RUN yum update -y && yum install -y hugepages libhugetlbfs-utils lbhugetlbfs-devel ibhugetlbfs numactl-devel ethtool gcc make g++ module-init-tools kmod wget patch xz-utils iproute pciutils python vim cmake unzip nano mc iputils-ping libaio libaio-devel git net-tools libibverbs strace
WORKDIR /opt/
COPY flexran_env_vars.sh ./
COPY configure_cfg_files.sh ./
COPY run_l1.sh ./

COPY flexran ./flexran
COPY intel ./intel
COPY dpdk-19.11 ./dpdk-19.11
