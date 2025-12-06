# The instructions below is to create a docker image

FROM node:20-alpine3.21

RUN npm i -g pnpm

# Diretorio de trabalho, todos os comandos executados vao
# ser dentro desse diretorio

WORKDIR /usr/src/app

# COPY package.json pnpm-lock.yaml ./
COPY . .

RUN pnpm install
RUN pnpm build
RUN pnpm prune --prod

ENV CLOUDFLARE_ACCESS_KEY_ID="#"
ENV CLOUDFLARE_SECRET_ACCESS_KEY="#"
ENV CLOUDFLARE_BUCKET="#"
ENV CLOUDFLARE_ACCOUNT_ID="#"
ENV CLOUDFLARE_PUBLIC_URL="http://localhost"

EXPOSE 3333

CMD [ "pnpm", "start" ]



# Multistage build

# this concept means that the workflow will cross some steps until the final result
# this way we can use some image with different size (with a lot, or few dependencies) in each step
# to do a specific thing 

# ex: use a large image size to build the application and a low image size to deploy this application


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


