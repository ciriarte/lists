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

#### Git hook to patch AssemblyInfo.cs

```sh
#!/bin/bash
#Git Post Merge Hook
#---------------------
#Gets the latest tag info from the git repo and updates the AssemblyInfo.cs file with it.
#This file needs to be place in the .git/hooks/ folder and only works when a git pull is
#made which contains changes in the remote repo.

#get the latest tag info. The 'always' flag will give you a shortened SHA1 if no tag exists.
# The 'tags' flag allows regular tags
tag=$(git describe --tags --always)
#echo $tag

find . -type f -name AssemblyInfo.cs -print0 | xargs -0 sed -in
's/AssemblyInformationalVersion\(.*\)/AssemblyInformationalVersion\(\"'$tag'\"\)/g'
```
