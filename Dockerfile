FROM node:alpine
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# multi-step build. next FROM statement terminates the previous block, except what is copied over
FROM nginx
# expose port to aws beanstalk
EXPOSE  80
COPY --from=0 /app/build /usr/share/nginx/html
# no CMD needed, nginx auto starts