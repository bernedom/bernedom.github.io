FROM ruby:3.4.4

RUN gem update bundler && \
    gem install bundler 


RUN apt-get update && \
    apt-get install -y sudo bash-completion vim

RUN groupadd -g 1000 builder && \
    useradd -m -u 1000 -g 1000 -s /bin/bash builder && \
    echo "builder ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/builder && \
    chmod 0440 /etc/sudoers.d/builder

ENV GEM_HOME /home/builder/.gem

RUN curl -L https://raw.github.com/git/git/master/contrib/completion/git-prompt.sh > /home/builder/.bash_git && echo "source ~/.bash_git" >> /home/builder/.bashrc
RUN sed -Ei 's/(PS1=.*)(\\\[\\033\[00m\\\]\\\$.*)/\1\\[\\033[01;33m\\]$(__git_ps1)\2/p' /home/builder/.bashrc


#RUN bundler install