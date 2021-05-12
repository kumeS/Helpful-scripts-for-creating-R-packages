# Helpful scripts for creating R packages

## Working directory structure

<!-- AUTO-GENERATED-CONTENT:START (DIRTREE:dir=./&depth=1) -->
```
. (Working directory)
├── [Your package]/
│           ├── fuga
│           └── fuga
├── build_test.R (any R file, a script to build your package)
├── R.Rproj (any R project)
├── hoge_dir1/
└── hoge_dir2/
```
<!-- AUTO-GENERATED-CONTENT:END -->

## install a local R package on R (with deleting variables in your environment)

```r
#XXX
```

## reinstall a local R package on R (without deleting any variables in your environment)

```r
#XXX
```

## batch file (.command) to uploads files to GitHub.
    - [github.command](https://github.com/kumeS/Helpful-scripts-for-creating-R-packages/blob/main/github.command)

```sh
#XXX
```

## run the R-devel of Docker / Bioconductor on R

```r
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

### install the packages in Docker/Bioconductor

```r
BiocManager::install("AnnotationHub")
BiocManager::install("ExperimentHub")
BiocManager::install("BiocStyle")
BiocManager::install("BiocCheck")

#check their loads
library(AnnotationHub)
library(ExperimentHub)
```

### (If you need) install tex/pdfLatex on Terminal window by Root User

```sh
sudo apt-get update
sudo apt-get install texlive-latex-base texlive-latex-extra texinfo
sudo apt-get install texlive-fonts-recommended texlive-fonts-extra
```

### install test for BioImageDbs package

```r
system("R CMD INSTALL AHBioImageDbs")
system("R CMD build --keep-empty-dirs --no-resave-data AHBioImageDbs")
system("R CMD check --no-vignettes --timings --no-multiarch AHBioImageDbs_0.99.1.tar.gz")
BiocCheck("./AHBioImageDbs_0.99.1.tar.gz")
```
