docker run -it -d \
	--name pytorch-openssh-server \
	--gpus all \
	-p your_port:22 \
	-v /mnt:/mnt \
	pytorch-openssh-server
