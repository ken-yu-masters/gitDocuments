# gitDocuments

#show GUI
gitk &

#show configs
git config --list --system  #for all users on current compupter
git config --list --global  #for all sandboxes(projects) of current user.
git config --list --local   #for current sandboxes(projects)

#edit configs: pop up an editor
git config --system --edit  #for all users on current compupter
git config --global --edit  #for all sandboxes(projects) of current user.
git config --local --edit   #for current sandboxes(projects)

#command line alias editing:
#1:add a alias
git config alias.aliasName1 'content of the alias'
#example :
  git config --global alias.goodLog 'log --pretty=format:"%h %Cblue%ad%Creset %an %Cgreen%s%Creset" --date=format:"%Y-%m-%d %H:%M:%S"'

#2:get content of an alias
git config --get-all alias.aliasName1
#example
  git config --global --get-all alias.goodLog

#3: replace an alias
git config --replace-all alias.aliasName1 ' new content of the alias'
#example
  git config --global --replace-all alias.goodLog 'log --pretty=format:"%h %Cblue%ad%Creset %an %Cgreen%s%Creset" --date=format:"%Y-%m-%d-%H:%M:%S"'

#4: delete an alias
git config --unset alias.aliasName1

#5: it is equal to following section in gitconfig file. 
[alias]
	goodLog = log --pretty=format:\"%h %Cblue%ad%Creset %an %Cgreen%s%Creset\" --date=format:\"%Y-%m-%d %H:%M:%S\"


#show current working directory files status
git status

#list all local modified files
git ls-files -m

#list all untracked files.
git ls-files --others --exclude-standard
#list all untracked files and delete them. (the file names may constain white space, so we need tell xargs only use '\n' as delimiter)
git ls-files --others --exclude-standard | xargs -d '\n' rm


#list all merge conflict files
git diff --name-only --diff-filter=U
Or
git ls-files -u

#show commits from a author
git log --author="author Name" --oneline

# show SHA, date, authorName, description from a commit_number
# show date with blue color
# show description with green color
git log --oneline --pretty=format:"%h %Cblue%ad%Creset %an %Cgreen%s%Creset" --date=format:"%Y-%m-%d %H:%M:%S" commit_number...HEAD

#show a commit
git show commit_number
#example:
git show d470695c4a7

#show all commits directly committed to current branch.
#exclude those which have been rebased or merged from other branch
#Basicly, idea is : rebased or merged commits have different auther email (%ae) and commit email (%ce)
git log --pretty=format:"%h %Cblue%ad %cd%Creset %Cred %ae %Creset %ce %Cgreen%s%Creset" --date=format:"%Y-%m-%d_%H:%M:%S" since_this_commit_number..  > history.txt
cat history.txt | awk '{if ($4 == $5) {print $0}}' > realHistory.txt
 
#list all remote depos
git remote show
#list all remote depos with detail information
git remote -v
#show a depo info
git remote show remoteDepoName
#for exmample
git remote show origin

#clone a remote depo(Repository) to local
git clone remote_depo_url
#for exmaple
git clone https://github.com/ken-yu-masters/gitDocuments
#add another depo to local
git add remoteDepoName2 remote_depo_url
#remote a remote depo
git rm remoteDepoName


#temporary store all changed files
git stash
Or
git stash save new_stash_change_name
#list all stored changes. it will show a list of stashed changes and its indices.
git stash list
#retrive a stored change:
git stash apply stash@{stash_change_number}
Or
git stash apply stash^{/stash_change_name}
#delete one stored change
git stash drop stash@{stash_change_number}

#check in code
#1:adds all tracked files to the staging area
git add -A
#2: commit any files that have already been added to the staging area
git commit -m "new message"
#3:
git push
#-----------OR:
#1:adds all tracked files to the staging area and commits them in one step.
git commit -a -m "new message"
#2:
git push

# Revert changes to modified files.
git reset --hard
# Remove all untracked files and directories. (`-f` is `force`, `-d` is `remove directories` -x will also remove all ignored files)
git clean -fdx
#you can replace "git reset --hard" with 2 commands below:
git reset
git checkout .

#revert a changed file
git checkout -- relative/path/to/the/file/fileName

# Revert a local commit.
git revert commit_number

#revert/delete/(give up) all local commits(not pushed)
git reset --hard UpperRemoteDepoName/upper_remote_branch_name
#example:
git branch -vv | grep '*'           #find the remote depo/branch name which currnet branch is tracking
git reset --hard origin/master      #delete all un-pushed commits if current branch is "master"

#merge 
git merge remote_branch_name
#example 
git merge origin/master

#resolve conflicts
#need set kdiff3 as default merge tool first:
# git config --list | grep merge
#    merge.tool=kdiff3
#    mergetool.kdiff3.path=C:/Program Files/KDiff3/kdiff3.exe
git mergetool

#commit and push the merge. 

#delete un-tracked files because merge tool will generate "*.orig" file which is the un-merge version of the conflicts.
git ls-files --others --exclude-standard  | grep '.orig' | xargs -d '\n' rm

#abort a merge.
git merge --abort

#cherry-pick merge.
git checkout to_merge_from_local_branch_name_1
git log --oneline
#pick one or more commit_number
git checkout to_merge_to_local_branch_name_2
git cherry-pick commit_number_1
git cherry-pick commit_number_2
...
git push

#revert all cherry pick commits
git reset --hard HEAD~

#revert a commit : will add a revert commit to the git log 
git revert commit_number_1

#create patch apply patch
git checkout to_merge_from_local_branch_name_1
git log --oneline
#pick one or more commit_number
git format-patch $commit_number_1 -1 -o $outputDir
git format-patch $commit_number_2 -1 -o $outputDir
...
git checkout to_merge_to_local_branch_name_2
git am 1.patch
git am 2.patch
git am 3.patch
...
git push

#rebase
#
# Current branch is "topic":
#
#          A---B---C topic
#         /
#    D---E---A'---F master
#
# git rebase master topic
# OR : git rebase --onto master topic
# Change to:
#
#                   B'---C' topic
#                  /
#    D---E---A'---F master
#
git rebase parentBranchName childBranchName # if you are on the child branch, you can omit the childBranchName 
#Real process:
#Example1: rebase feature branch on top of master branch.
git fetch --all
git checkout master
git pull
git checkout InVision/Review/TP25235_Licensing
git pull
git rebase master
git mergetool
git rebase --continue
git mergetool
git rebase --continue
...
git status
git push -f

#Example2: rebase feature branch inside master branch.
#https://dzone.com/articles/the-multiple-usages-of-git-rebase-onto
#https://stackoverflow.com/questions/42861353/git-pull-after-git-rebase
#on feature branch(topic), do it daily.
git fetch --all
git rebase --onto origin/master topic
git status(will report local topic branch and remote topic branch are diverged.)
git pull --rebase
git push

#When you rebase multi-times to a branch, you need resolve same conflicts every time.
#But when you turn following config on, git will remember what you do, and repeat it automatically next time.
git config --global rerere.enabled true
#you can check it by:
git rerere status
git rerere diff
#you can clear it by:
git rerere clear

#show all branches
git branch -a
#list all remote branches
git branch -r
#list all local branches
git branch
#show all local branches and related remote tracking branches.
git branch -vv

#checkout a remote branch to local
git checkout -b local_branch_name remoteDepoName/remote_branch_name
#OR:
git checkout remote_branch_name
#For exmaple:
git checkout InVision/Review/TP25235_Licensing
git checkout -b TP25235_Licensing origin/InVision/Review/TP25235_Licensing

#create a new branch.
git checkout -b new_local_branch_name
#then yu can push it to remote.
git push remoteDepoName local_branch_name:remote_branch_name
#exmaple
git push origin ken_debug_crash:OfficalRelease/3.0/ken_debug_crash
#you will get a remote remote branch origin/OfficalRelease/3.0/ken_debug_crash

#set remote tracking branch for a local branch
git branch -u remote_branch_1 local_branch_name
#example
git branch -u origin/OfficalRelease/3.0/ken_debug_crash ken_debug_crash

#switch brach
git checkout local_branch_name

#when your local branch name is different with remote branch name.
#Let local branch automatically push to remote tracking  branch
git config push.default upstream
#OR you need use
git push remoteDepoName local_branch_name:remote_branch_name
#exmaple
git push origin branch1:remote_branch_1

#delete a remote branch.
git push remoteDepoName --delete remote/branch/name
#exmaple
git push origin --delete newFeatures/unstables/feature1

#delete a local branch.
git branch -d localBranchName
