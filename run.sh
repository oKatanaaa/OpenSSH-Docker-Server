docker run -it -d \
	--name pytorch-openssh-server \
	--gpus all \
	-p 51125:22 \
	-v /mnt:/mnt \
	pytorch-openssh-server
