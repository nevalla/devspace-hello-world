FROM node:16.8-alpine as build

# Create app directory
WORKDIR /usr/src/app

# Install app dependencies
COPY package*.json ./
RUN npm install

# Bundle app source
COPY . .

RUN npm run build

CMD ["npm", "run", "dev"]

FROM node:16.8-alpine as execute

WORKDIR /usr/src/app

COPY --from=build /usr/src/app/package*.json /usr/src/app/

RUN npm install --production

COPY --from=build /usr/src/app/dist /usr/src/app/dist

CMD [ "node", "dist/index.js" ]
