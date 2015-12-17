# miniJava-compiler

A compilation project for third-year students of Telecom Bretagne.

`ocamlbuild Main.byte` (or native) to build the compiler. The main file
is Main/Main.ml, it should not be modified. It opens the given file,
creates a lexing buffer, initializes the location and calls the compile
function of the module Main/compile.ml. It is this function that you
should modify to call your parser.

`ocamlbuild Main.byte -- <filename>` (or native) to build and then execute
the compiler on the file given. By default, the program searches for
files with the extension .java and appends it to the given filename if
it does not end with it.

If you want to reuse an existing ocaml library, start by installing it
with opam. For example, to use colored terminal output you use `opam 
install ANSITerminal`. Then you must inform ocamlbuild to use the 
ocamlfind tool : 
`ocamlbuild -use-ocamlfind Main.byte -- tests/UnFichierDeTest.java`
and you must add the library to the file `_tags`, for example : 
`true: package(ANSITerminal)`


## Workflow

There are two branches. 

* **master** - it's the main branch. Code here should always be stable.
* **develop** - branch where we push our development. Can be unstable.

When `develop` reaches a stable state, it should be merged into
master branch. For that, using the 
[pull request feature](https://help.github.com/articles/creating-a-pull-request/).
Thanks to that, we can review your code and accept or not to integrate into master. 

### Development

Even if you work on develop branch, it's better to create your own 
branch to integrate your work. 

0. Before you start to work, update your local repertory :

	`git checkout develop` - To be sure to be in develop branch.

	`git pull` - Incorporates changes from develop branch of the remote repository 
	into the current branch. Now, your develop branch is up to date. 

1. Create your own branch

	`git checkout -b branchname` - Create for the first time your own branch 
	and swith into it. branchname can be like that : your_name/type_of_work 

	`git branch` - See your current branch.

	`git checkout branchname` - Switch to the targeted branch
 
2. Work hard on the project :

	`git add filename` - To prepare next commit with all new contents
	in the file. 

	`git status` - Optional, but it's still better to check what you're 
	going to commit.

	`git commit` - [Write good commit message.](http://chris.beams.io/posts/git-commit/)
	By default, you will use Vim. Try to learn basic features of 
	[Vim](http://www.openvim.com/).

	`git commit -m "message"` - To type directly your commit message without opening
	text editor. 

	You're allowed to repeat this step many times. It's better to use several single 
	commits than a unique big commit. A commit should represent your steps.  

    `git commit --amend` enables you to modify your last commit. Usually used to correct a typo
    in the commit message. This command will open a text editor (usually Vim, but it depends on
    your git config): the first line is the commit message. Edit it, and save the file: your commit
    will be modified.

3. Push your branch into the remote repository :

	`git push -u origin branchname` - create and push your branch into the repo. 	

4. Create a pull request on Github from your branch to class (or expression) : 

	We will review your code and integrate it if it's good. 

### Integrate updates from your parent branch
 
Sometimes, during you work on a special feature on your own personnal branch, some 
updates will be pushed into develop branch. You will need to 
integrate these updates into your code. Even if you have already created a pull 
request, you need to update your code to integrate theses updates. It's something done
before you, it could be important, so you need to take into account. If you're lucky, 
these updates will not cause conflicts with your code, but if you're not, you will 
need to fix your code. 

1. Update your parent branch :

	`git checkout develop` - To be sure to be in develop branch.

	`git pull` - Your local branch is updated

2. Integrate these changes into your own branch : 

	`git checkout branchname` - To be sure to be in your own branch. 

	`git rebase develop` - Your local branch will be rebased. It means that 
	the history of its branch will be rewritten. 

	`git rebase -i develop` - You can use this command if you want an interactive 
	rebasing. 

	Git will guide you during the rebasing. Use `git status` to see what's happening. 
	If you have conflicts, fix them with your text editor. Git will modify your code
	and tells you what was on the parent_branch and what was on your branch. When the 
	rebasing is finished, you have to push your branch into the remote repo. 

3. Push your branch into the remote repository :

	`git push -u origin branchname` - if your branch was already tracked by the remote
	repo, you can remove the option `-u`. 

	If you have already push your branch before (if you're doing a pull request for 
	example), Github won't you allow to push this branch, because your local branch and
	the remote branch have different history. (Of course, you have rebased your branch). 
	As it's a private branch, only for your use, you're allowed to force the push, do 
	simply : 

	`git push --force origin branchname` - And stay calm ;)

### How to accept pull requests

You can simply use the Github button **Merge pull request**, but it will add in the 
history a merge commit. When it's unecessary, it's ugly to add a merge commit, so avoid
it. 

1. From your project repository, bring in the changes and test

		git fetch origin
		git checkout -b branchname origin/branchname
		git merge develop

2. Merge the changes and update on Github

		git checkout develop
		git merge branchname
		git push origin develop	
	
### Example

I will give an illustration of this process. It seems to be unnecesseraly complex, but 
conflitcs will happen more than you think, so we need to be ready. 

Assume that in develop branch, there is only commit `A`. I'm working to implement a new
feature. I will follow the first guidelines. I add commit `B` in my local branch. 
But before I create a pull request, `develop` is updated with commit `C`. 
This is the actual situation : 

develop : A-->C

myBranch : A-->B

I need to follow part 2 of guidelines. After `git rebase develop` we have : 

develop : A-->C

myBranch : A-->C-->B

myBranch has integrated the commit `C`. My work is after commit `C` so the merge will be
easier. (It will be a fast-forward merge).

Now, I'm creating a pull request. I'm typing `git push -u origin myBranch` to put my 
branch into the remote repository. During the review, someone else add commit `D` in the
`develop`. I'm asked to update my branch to validate the review. I'm following again 
part 2. After `git rebase develop`, we have : 

develop : A-->C-->D

myBranch : A-->C-->D-->B  

It's the same as before, my work is after the last commit of the parentBranch. What is
different is if you're doing a `git push origin myBranch` Github will not accept. Because
there is a history conflict between your local myBranch and the remote myBranch : 

local myBranch : A-->C-->D-->B

remote myBranch : A-->C-->B

Github can't accept that because the history has changed. As it's your own private branch
, you can use the option `--force`. So, type `git push --force origin myBranch`. The 
remote myBranch will be like your local myBranch. The other reviewers can watch your 
code, and decide to integrate it into `develop`. At the end, `develop` will be 
like that : 

`develop` : A-->C-->D-->B  

# Resources

## Useful reads

* OCaml in the real World: https://realworldocaml.org/v1/en/html/index.html

## Useful repositories

* manual-ocamlbuild: https://github.com/gasche/manual-ocamlbuild
* realworldocaml-examples: https://github.com/realworldocaml/examples

