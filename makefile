run:
	# wandb server start -p 18080
	export LOCAL_RESTORE=true && \
	sudo docker run --rm -d \
	  -v wandb:/vol \
	  -p 18080:8080 \
	  --name wandb-local wandb/local
login:
	wandb login --host=http://localhost:18080
	
attach:
	sudo docker exec -it wandb-local bash
	# add new user manually
	# /usr/local/bin/local password your@email.com

	# Unable to create account, contact your administrator.
	# https://github.com/wandb/local/issues/44
	# vi /vol/env/users.htpasswd # Remove the line with local@wandb.com in it

clean:
	sudo docker rm -f wandb-local 
update:
	# for getting the latest wandb image
	sudo docker pull wandb/local
remove-image:
	# if you don't want to use wandb-local anymore
	sudo docker image rm wandb/local