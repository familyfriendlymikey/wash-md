# watch-md

A live updating markdown viewer that:
- Uses Github's attractive markdown css.
- Renders whatever markdown file, recursing subdirectories, that
	was most recently edited.
- Is written in ~40 lines of Imba.
- Doesn't refresh the browser.

## Installation
```
npm i -g watch-md
npm i -g pm2 # optional
```

### Usage
*In my home directory* I just do
```
pm2 start md
```
and leave it running.

Sure it uses like 80MB RAM.
Not sure if I care about that yet.
But now whenever you save a markdown file basically
anywhere on your computer,
it'll render to [localhost:8087](),
which is very quick to get to if you use my app
[fuzzyhome](https://github.com/familyfriendlymikey/fuzzyhome)
or use an alias.

Some useful bash/zsh aliases for MacOS:
```
alias m="open 'http://localhost:8087'"
alias psa="pm2 start all"
alias pso="pm2 stop all"
```
