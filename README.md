# Overview

Head over to (softwarecraft.ch/)[softwarecraft.ch/] to read the blog. 
The site is built using [jekyll-now](https://github.com/barryclark/jekyll-now)

## Developing

I'm using an alpine based [docker](https://www.docker.com/) container to run the site locally to preview changes.
Build and run it with:
```bash
docker build . --rm -t ghpages
docker run -ti -p 4000:4000 -v $(pwd):/home/jekyll --rm ghpages
```

If the commands require sudo rights consider adding the current user to the docker group: 

```bash
sudo groupadd docker
sudo usermod -aG docker $(whoami)
newgrp docker 
```
