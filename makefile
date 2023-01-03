run:
	
	podman pod rm -f wandb-server # remove opened container
	podman pod create -n wandb-server -p 8080:8080

	export LOCAL_RESTORE=true && \
	podman run 	--rm -d \
				--pod wandb-server \
				--cap-add=SYS_PTRACE \
  				--security-opt seccomp=unconfined \
				-v wandb:/vol \
				--name wandb-local wandb/local
login:
	wandb login --host=http://10.8.4.114:8080
	
attach:
	podman exec -it wandb-local bash
	# add new user manually
	# /usr/local/bin/local password your@email.com

	# Unable to create account, contact your administrator.
	# https://github.com/wandb/local/issues/44
	# vi /vol/env/users.htpasswd # Remove the line with local@wandb.com in it

clean:
	podman pod rm wandb-server
	#sudo docker rm -f wandb-local 
update:
	# for getting the latest wandb image
	podman pull wandb/local
remove-image:
	# if you don't want to use wandb-local anymore
	sudo docker image rm wandb/local