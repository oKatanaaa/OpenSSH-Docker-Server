docker run -it -d \
	--name pytorch-openssh-server \
	--gpus all \
	-p your_port:22 \
	-v /your_working_folder:/workspace \
	pytorch-openssh-server
