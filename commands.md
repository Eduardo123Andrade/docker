# inside the terminal

# command to create a new docker image
# docker build -t widget-server:v1  . 
# docker build -t image-name local where the Dockerfile stay   

# docker logs 13d0c35aa945   
# docker logs container-id


# docker stop 13d0c35aa945 
# docker stop docker-id

# docker start 13d0c35aa945  -> this command is when the image already exists
# docker start docker-id

# docker run -p local-port:docker-port image name
# docker run -p 3000:3333 widget-server:v1   

# here I'm using the alpine, and alpine not have bash, but have a sh terminal
# docker exec -it 1fa6e7 /bin/sh -> this command is to access the container 
# docker exec -(iterative) docker-id output (bash)


# create tag to image and prepare to push to remote repository
# docker tag widget-server:v1 lordestark/widget-server:v1
# docker tag tag-local repositorio remoto

# docker push lordestark/widget-server:v1 -> push the image to this repository

# docker pull lordestark/widget-server:v1 -> pull the image from this repository