# The instructions below is to create a docker image
# Docker multistage build
# each step use a new image or alias (FROM iamge AS alias)
# this way each step is specific for one thing.

# this step is to install global dependencies
FROM node:20.18 AS base

RUN npm i -g pnpm

# this step is to instal the project dependencies
FROM base AS dependencies

WORKDIR /usr/src/app

COPY package.json pnpm-lock.yaml ./

RUN pnpm install

# this step is to build the project
FROM base AS build

WORKDIR /usr/src/app

COPY . .
COPY --from=dependencies /usr/src/app/node_modules ./node_modules

RUN pnpm build
RUN pnpm prune --prod

# this step is get a lower node image.  Just with the necessary node dependencies
FROM node:20-alpine3.21 AS deploy

# Use the first user without root access
USER 1000 

WORKDIR /usr/src/app

COPY --from=build /usr/src/app/dist ./dist
COPY --from=build /usr/src/app/node_modules ./node_modules
COPY --from=build /usr/src/app/package.json ./package.json

ENV CLOUDFLARE_ACCESS_KEY_ID="#"
ENV CLOUDFLARE_SECRET_ACCESS_KEY="#"
ENV CLOUDFLARE_BUCKET="#"
ENV CLOUDFLARE_ACCOUNT_ID="#"
ENV CLOUDFLARE_PUBLIC_URL="http://localhost"

EXPOSE 3333

# each layer above is readonly


# to "hold" the server running we user the layer "CMD" or "ENTRYPOINT"
# with CMD we can infer something in command line 

# this layer is write and read 
CMD [ "node", "dist/server.mjs" ]

# this isn't common usage
# ENTRYPOINT [ "executable" ] ["node", "dist/server.mjs"]



# Multistage build

# this concept means that the workflow will cross some steps until the final result
# this way we can use some image with different size (with a lot, or few dependencies) in each step
# to do a specific thing 

# ex: use a large image size to build the application and a low image size to deploy this application


