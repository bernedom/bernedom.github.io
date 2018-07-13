FROM ubuntu:16.04

EXPOSE 4000

RUN apt update && apt upgrade -y
RUN apt install -y build-essential jekyll gem ruby ruby-dev ruby-bundler libc-dev libxml2-dev zlib1g-dev libxslt-dev liblzma-dev

RUN gem install jekyll bundler
RUN gem update bundler
RUN gem install github-pages

RUN apt remove -y libc-dev libxml2-dev ruby-dev build-essential zlib1g-dev libxslt-dev liblzma-dev gem ruby-bundler
RUN apt autoremove -y

WORKDIR /home/jekyll
CMD jekyll serve --watch -d /_site --force_polling -H 0.0.0.0 -P 4000

