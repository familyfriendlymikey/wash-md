# wash-md

A hot reloading markdown viewer written in 30 lines of Imba that
uses Github's attractive markdown css. Renders the most recently
edited markdown file recursing subdirectories.

## Installation

```
npm i -g wash-md
```

This installs an `md` command.

## Usage

- Run `md` in any directory.
- Navigate to [localhost:3000](http://localhost:3000).
- Save a markdown file in the same directory or any subdirectory.

### Better Usage

You can run `md` in your home directory with `pm2`:

```
cd ~
PORT=4487 npx pm2 start md
# choose whatever port you want
```

and just leave it running.

Now whenever you save a markdown file anywhere on your computer,
it'll render to localhost at your chosen port, which is very
quick to get to if you use my app
[fuzzyhome](https://github.com/familyfriendlymikey/fuzzyhome) or
a bash alias.

Here are some potential bash/zsh aliases to get you started:

```
alias m="open 'http://localhost:4487'"
alias psmd="PORT=4487 npx pm2 start md --name wash-md"
alias pdmd="npx pm2 delete wash-md"
```

`open` is from MacOS but on another OS you can
probably find a package that does the same thing.
