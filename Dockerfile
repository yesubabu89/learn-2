FROM node:19-alpine as frontend
WORKDIR /app
COPY self-profile-client/package*.json .
RUN npm install
COPY self-profile-client/. .
RUN npm run build

FROM node:19-alpine
WORKDIR /app
COPY self-profile-server/package*.json .
RUN npm install
COPY self-profile-server/ .
COPY --from=frontend /app/build/. build/.
EXPOSE 3001
CMD [ "npm", "start" ]