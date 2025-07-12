FROM ruby:3.4.4

RUN gem update bundler && \
    gem install bundler 


RUN apt-get update && \
    apt-get install -y sudo bash-completion

RUN groupadd -g 1000 builder && \
    useradd -m -u 1000 -g 1000 -s /bin/bash builder && \
    echo "builder ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/builder && \
    chmod 0440 /etc/sudoers.d/builder

ENV GEM_HOME /home/builder/.gem

#RUN bundler install