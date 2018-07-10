FROM ubuntu:16.04

#VOLUME /site

EXPOSE 4000

#WORKDIR /site

RUN apt update && \
    apt install -y jekyll gem ruby gcc make g++ ruby-dev sudo ruby-bundler libc-dev libxml2 zlibc

RUN gem install jekyll bundler
RUn gem install github-pages
# RUN bundle install --gemfile=/home/jekyll

#RUN useradd -ms /bin/bash jekyll 
#USER jekyll
#WORKDIR /home/jekyll



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


