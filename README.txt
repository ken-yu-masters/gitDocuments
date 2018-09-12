# gitDocuments

#show configs
#1 local config
git config --list
#2 global config
git config --global --list

#show current working directory files status
git status

#show commits from a author
git log --author="author Name" --oneline

#show a commit
git show commit_number
#example:
git show d470695c4a7

#cherry-pick merge.
git checkout to_merge_from_local_branch_name_1
git log --oneline
#pick one or more commit_number
git checkout to_merge_to_local_branch_name_2
git cherry-pick commit_number_1
git cherry-pick commit_number_2
...
git push

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

#create a new branch.
git checkout -b local_branch_name remoteDepoName/remoteBranchName

#show all branches
git branch

#show all branches and reltaed remote tracking branches.
git branch -vv

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

