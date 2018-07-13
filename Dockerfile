FROM ubuntu:16.04

EXPOSE 4000

RUN apt update && apt upgrade -y
RUN apt install -y build-essential patch jekyll gem ruby ruby-dev sudo ruby-bundler libc-dev libxml2-dev zlib1g-dev libxslt-dev liblzma-dev curl
RUN apt install -y ruby-dev


RUN gem install jekyll bundler
RUN gem update bundler
RUN gem install github-pages

WORKDIR /home/jekyll
CMD jekyll serve --watch -d /_site --force_polling -H 0.0.0.0 -P 4000

