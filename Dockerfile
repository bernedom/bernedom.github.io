FROM alpine:latest

# open jekyll port to the outside
EXPOSE 4000

# install jekyll necessary dependencies for building github pags
RUN apk update
RUN apk add libatomic readline readline-dev libxml2 libxml2-dev \
        ncurses-terminfo-base ncurses-terminfo \
        libxslt libxslt-dev zlib-dev zlib \
        yaml yaml-dev \
        libffi-dev build-base git nodejs \
        ruby ruby-dev ruby-io-console ruby-irb ruby-json ruby-rake ruby-bundler ruby-rdoc 

# configure and install github pages 
RUN gem install jekyll bundler bigdecimal webrick
RUN gem update bundler
RUN gem install github-pages

# clean up all dependencies no longer used for running the container
RUN apk del zlib-dev yaml-dev libffi-dev libxml2-dev libxslt-dev readline-dev ruby-dev build-base ruby-rdoc git

WORKDIR /home/jekyll
CMD jekyll serve --watch -d /_site --force_polling -H 0.0.0.0 -P 4000

