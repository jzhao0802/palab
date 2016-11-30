# How to get Mango's code drops to work

Since it's a package that's still in development and is cannot be installed through the install.package() command there are a couple of things we need to install to get them working.

* Go to [Rtools website](https://cran.r-project.org/bin/windows/Rtools/) and install the .exe that corresponds to your R version. For me this was Rtools33.exe. Your R version should be displayed as the first message from R studio, when you fire up a new session. The installation takes a good 10 minutes.
* Install devtools with: install.package("devtools")
* Install packrat with: install.package("packrat")
* Change the working directory to the folder where the compressed tar.gz (drop from Mango) is.
* Load packrat with library(packrat)
* Unbundle the project and set up the packrat environment with packrat::unbundle("name_of_drop.tar.gz", ".")
  * This will install all dependencies that were used in and required by the package. The good thing is that this is done in a separated and sealed environment, meaning two projects cannot use the same package and therefore cannot require different versions of the same package. 
  * This step can take again a good 10 minutes. By the end of it, a folder named palab will be created that holds all the source code, documentation, tests and dependencies of the package.
  * Open the palab.Rproj file with R studio.
  * Then change to the Build tab (by default this is next to the History tab)
  * Hit "Build & Reload"
  * The palab package then will be built, installed and loaded in memory.
  * Now you can call any function from it, just as you do with any other package: palab::__
  

