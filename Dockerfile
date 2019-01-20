# specify the node base image with your desired version node:<version>
FROM node:10
# replace this with your application's default port
#EXPOSE 3000

CMD echo "Hello from node.js container"
