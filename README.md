# Helpful scripts for creating R packages

## Working directory structure

- Software package

<!-- AUTO-GENERATED-CONTENT:START (DIRTREE:dir=./&depth=1) -->
```
. (Working directory)
├── [Your package]/
│           ├── R/
│           ├── inst/
│           │     ├── extdata/
│           │     ├── images/
│           │     └── script/
│           ├── man/
│           ├── vignettes/
│           ├── DESCRIPTION
│           ├── NAMESPACE
│           ├── NEWS
│           └── README.md
├── build_test.R (any R file, a script to build your package)
├── R.Rproj (any R project)
├── github.command (a script to puch your package to GitHub)
├── hoge_dir1/
└── hoge_dir2/
```
<!-- AUTO-GENERATED-CONTENT:END -->


## build_test.R for Software package

- install a local R package on R (with deleting variables in your environment)

```r
#install.packages("roxygen2")

if(TRUE){
rm(list=ls())
system("rm -rf ./[Your package]/NAMESPACE; rm -rf ./[Your package]/man/*")
roxygen2::roxygenise("./[Your package]")
system("cat ./[Your package]/NAMESPACE")
remove.packages("[Your package]", lib=.libPaths())
.rs.restartR()
}

if(TRUE){
system("R CMD INSTALL [Your package]")
library([Your package])
}
```

- reinstall a local R package on R (without deleting any variables in your environment)

```r
#install.packages("roxygen2")

if(TRUE){
system("rm -rf ./[Your package]/NAMESPACE")
roxygen2::roxygenise("./[Your package]")
system("cat ./[Your package]/NAMESPACE")
remove.packages("[Your package]", lib=.libPaths())
.rs.restartR()
}

if(TRUE){
system("R CMD INSTALL [Your package]")
library([Your package])
}
```

An alternative way without shell,

```r
#install.packages("readr")

file.remove("./[Your package]/NAMESPACE")
file.remove(dir("./[Your package]/man", pattern=".Rd", full.names = T))
readr::read_lines("./[Your package]/NAMESPACE")
```

- AnnotationHub / ExperimentHub (Bioconductor)

<!-- AUTO-GENERATED-CONTENT:START (DIRTREE:dir=./&depth=1) -->
```
. (Working directory)
├── [Your package]/
│           ├── inst/
│           │     ├── extdata/
│           │     ├── hoge_dir3/
│           │     └── script/
│           ├── man/
│           ├── vignettes/
│           ├── DESCRIPTION
│           └── README.md
├── build_test.R (any R file, a script to build your package)
├── R.Rproj (any R project)
├── github.command (a script to puch your package to GitHub)
├── hoge_dir1/
└── hoge_dir2/
```
<!-- AUTO-GENERATED-CONTENT:END -->

## Batch file (.command) to uploads files to GitHub.

- [github.command](https://github.com/kumeS/Helpful-scripts-for-creating-R-packages/blob/main/github.command)

```sh
#!/bin/bash

# If your need any proxy setting
# export https_proxy="http://..."
# export ftp_proxy="http://..."

MY_DIRNAME=$(dirname $0)
cd $MY_DIRNAME

cd ./[Your GitHub Directory]

# If you use MacOSX, it would need.
#du -a | grep .DS_Store | xargs rm -rf

git add -A

git commit -m "Your submit comment"
 
git push origin main

git config pull.rebase false

git pull

open "[Your GitHub URL]"

exit
```

- .gitignore file

```
.Rproj.user
.Rhistory
.RData
.Ruserdata
.DS_Store

```

## Run the R-devel of Docker / Bioconductor on R

```r
#run docker
system("docker run \\
        -d \\
        --name bioc \\
        -v $(pwd)/[Your package]://home/rstudio/[Your package] \\
        -e PASSWORD=bioc \\
        -p 8787:8787 \\
        bioconductor/bioconductor_docker:devel")

#check CONTAINER
system("docker ps")

#Open the RStudio-server
system("open http://localhost:8787")
#ID: rstudio, PW: bioc

#Stop the container
system("docker stop [CONTAINER ID]")
```

## Run within Bioc Docker (ex. AHBioImageDbs_0.99.1)

- install the packages in Docker/Bioconductor

```r
BiocManager::install("AnnotationHub")
BiocManager::install("ExperimentHub")
BiocManager::install("BiocStyle")
BiocManager::install("BiocCheck")

#check their loads
library(AnnotationHub)
library(ExperimentHub)
```

- (If you need) install tex/pdfLatex on Terminal window by Root User

```sh
sudo apt-get update
sudo apt-get install texlive-latex-base texlive-latex-extra texinfo
sudo apt-get install texlive-fonts-recommended texlive-fonts-extra
```

- install test for BioImageDbs package

```r
system("R CMD INSTALL AHBioImageDbs")
system("R CMD build --keep-empty-dirs --no-resave-data AHBioImageDbs")
system("R CMD check --no-vignettes --timings --no-multiarch AHBioImageDbs_0.99.1.tar.gz")
BiocCheck::BiocCheck("./AHBioImageDbs_0.99.1.tar.gz")
```

## For Submit  (ex. AHBioImageDbs_0.99.1)

```r
setwd("./BioImageDbs")

system("git remote -v")
#system("git remote remove upstream")
system("git remote add upstream git@git.bioconductor.org:packages/BioImageDbs.git")

system("git remote -v")
#origin	git@git.bioconductor.org:packages/BioImageDbs (fetch)
#origin	git@git.bioconductor.org:packages/BioImageDbs (push)
#upstream	git@git.bioconductor.org:packages/BioImageDbs.git (fetch)
#upstream	git@git.bioconductor.org:packages/BioImageDbs.git (push)

system("git fetch --all")
system("git merge upstream/master")
system("git merge origin/master")

system("git add -A")
system('git commit -m "v-0.99.1"')
system("git push upstream master")
system("git push origin master")
```

## Memo for Git command

```
$ git remote show
origin

$ git branch -a
* main
  remotes/origin/HEAD -> origin/main
  remotes/origin/main

$ git branch 
* main

#Create the devel branch
$ git checkout -b devel main
M       README.md
Switched to a new branch 'devel'

#An alternative way,
$ git checkout devel main
$ git checkout -b devel

$ git branch
* devel
  main

$ git checkout main
M       README.md
Switched to branch 'main'
Your branch is up to date with 'origin/main'.

$ git branch 
  devel
* main

$ git branch main
fatal: A branch named 'main' already exists.

$ git remote -v
origin  https://github.com/kumeS/Helpful-scripts-for-creating-R-packages.git (fetch)
origin  https://github.com/kumeS/Helpful-scripts-for-creating-R-packages.git (push)
```

## GitHub - personal access token (ex. kumeS/rMiW.git)

```
git clone https://github.com/kumeS/rMiW.git

cd ./rMiW

vim .git/config 

```

Rewrite `.git/config` as follows.

```
[remote "origin"]
	url = https://kumeS:[Your Access Token]@github.com/kumeS/rMiW.git
```


