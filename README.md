# watch-md

A live updating markdown viewer that:
- Doesn't refresh the browser.
- Written in ~50 lines of Imba.
- Uses Github's attractive markdown css.

## Installation
I don't want to upload this to any package managers.
Instead, I:

- Add `~/bin` to my `PATH`.
- Clone this repository to `~/repo/`, where I store all repos.
- Create a file called `md` in `~/bin` which just runs `imba.main`.

Sounds complicated but it's actually very simple.

```
cd ~/repo/ && \
git clone git@github.com:familyfriendlymikey/watch-md.git && \
cd watch-md && \
npm i && \
echo 'screen -md imba run ~/repo/watch-md/main.imba "$1"' > ~/bin/md && \
chmod +x ~/bin/md
```

## Usage

Whenever I want to edit a markdown file, I just run

```
md README.md
```

You may have noticed that we are using `screen -md` before we run imba.
This prevents the terminal from hanging
by running our command in the background,
or rather in a `screen`.
This way we don't have to open a new
terminal window to edit the file in vim.

```
vim README.md
```

When we are done editing our file,
we should terminate the screen session with:

```
screen -r
# Press Ctrl-c
```
