##### Delete those .orig files (╯°□°）╯︵ ┻━┻
```sh
find . -name \*.orig -type f | xargs /bin/rm -f
```

##### Filter branch (when merging repos)

`subdir` is a subdirectory in the parent repo.

git filter-branch --prune-empty --tree-filter '
if [[ ! -e subdir ]]; then
    mkdir -p subdir
    git ls-tree --name-only $GIT_COMMIT | xargs -I files mv files subdir
fi'

After doing this with as many child repos we want to have, we just add the remotes and pull from the working branch (the most advanced branch on each repo, usually develop)
