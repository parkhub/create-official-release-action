FROM mhart/alpine-node
LABEL maintainer Logan Fisher "logan.fisher@parkhub.com"

COPY . ./

RUN npm install --global release-it

CMD ["sh", "/run.sh", "$RELEASE_TYPE"]