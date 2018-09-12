# gitDocuments

#show configs
#1 local config
git config --list
#2 global config
git config --global --list

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

