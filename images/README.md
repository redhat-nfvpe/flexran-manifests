In order to build the image, you need to be on /opt directory,
and you need to have intel, flexran and dpdk-19.11 directories
with the content already compiled.

Then, you can run the image with:

docker run --name flexran -d --cap-add SYS_ADMIN --cap-add IPC_LOCK --cap-add SYS_NICE --mount 'type=bind,src=/sys,dst=/sys' --mount 'type=bind,src=/dev/hugepages,destination=/dev/hugepages' flexran:latest sleep infinity


