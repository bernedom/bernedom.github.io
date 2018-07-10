FROM ubuntu:16.04

EXPOSE 4000

RUN apt update && apt upgrade -y
RUN apt install -y build-essential patch jekyll gem ruby ruby-dev sudo ruby-bundler libc-dev libxml2-dev zlib1g-dev libxslt-dev liblzma-dev
RUN apt install -y ruby-dev


RUN gem install jekyll bundler
RUN gem update bundler
RUN gem install github-pages

RUN useradd -ms /bin/bash jekyll 
USER jekyll
WORKDIR /home/jekyll
#RUN jekyll serve

# TODO remove ubuntu packages no longer needed to save space 

#     apk --update add \
#     gcc \
#     g++ \
#     make \
#     curl \
#     bison \
#     ca-certificates \
#     tzdata \
#     ruby \
#     ruby-rdoc \
#     ruby-irb \
#     ruby-bundler \
#     ruby-dev \
#     glib-dev \
#     libc-dev && \
#     echo 'gem: --no-document' > /etc/gemrc && \
#     gem install --no-ri --no-rdoc github-pages --version 187 && \
#     gem install --no-ri --no-rdoc jekyll-watch && \
#     gem install --no-ri --no-rdoc jekyll-admin && \
#     apk del gcc g++ binutils bison perl nodejs make curl && \
#     rm -rf /var/cache/apk/*


