FROM alpine
LABEL maintainer Logan Fisher "logan.fisher@parkhub.com"

RUN apk update
RUN apk add bash build-base curl file git gzip libc6-compat ncurses ruby ruby-dbm ruby-etc ruby-irb ruby-json sudo
RUN adduser -D -s /bin/bash linuxbrew echo 'linuxbrew ALL=(ALL) NOPASSWD:ALL' >>/etc/sudoers 
RUN su -l linuxbrew
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"
RUN PATH=$HOME/.linuxbrew/bin:$HOME/.linuxbrew/sbin:$PATH
RUN brew update

RUN brew install hub

RUN apk add --update git hub

COPY run.sh .release-it.json ./

RUN npm install --global release-it

ENTRYPOINT ["sh", "/run.sh"]