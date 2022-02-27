# watch-md

A live updating markdown viewer that doesn't refresh the browser
written in ~50 lines of imba that uses github's markdown css.

## Usage
I don't want to upload this to any package managers.
The following works well for me:

```
cd ~/repo/ && \
git clone git@github.com:familyfriendlymikey/watch-md.git && \
cd watch-md && \
npm i && \
echo 'imba run ~/repo/watch-md/main.imba "$1"' > ~/bin/md && \
chmod +x ~/bin/md
```

Whenever I want to edit a markdown file, I just run

```
md README.md
```

This however hangs the terminal,
and I would rather use the same terminal window to edit the file in vim.
So instead of the above, I just background the process with `&`.

```
md README.md &
```

The terminal will output something like:

```
[1] 24059
```
I believe the `1` is the job number and the `24059` is the process ID.

Now we can edit our file with vim.

```
vim README.md
```

When we're done, we can either foreground the process and exit it

```
fg
# Press Ctrl-c
```

or we can kill the job number that we saw earlier

```
kill %1
```

or if you haven't started any new background processes since,
you can just kill the most recent job with

```
kill %%
```

Enjoy.
