# genesis-machine

A set of [Docker](http://docker.com) images, scripts and data to set up a full build container that will allow the complete build of Service Catalogue items in any context.

The intent is to have a pre-packaged means of automated releases from nothing. This will work in the following manner:

* Pre-configured machine:
  * OracleBox installed
  * PuTTy
  * Vagrant installed
    * ``Set-Location [location for vagrant config]``
    * ``vagrant box add geerlingguy/centos7``
    * ``vagrant init geerlingguy/centos7``
    * ``vagrant up``
  * Use PuTTY to connect to Centos7 box

* Take an existing, pre-configured Linux server (RHEL or centOS like above);
  * enable network (test: ping mirrorlist.centos.org  - nmtui)
  * includes ``git``


* logon to server:
  * ``$ git clone -c http.sslVerify=false https://github.com/ginger268/GenesisMachine.git``
  * ``$ cd [this repository]``
  * ``$ git checkout [branch required]``
  * ``$ ./set-up.sh``
* This will run a set of ``Docker`` containers that will include everything required to build a chosen environment.
* Logon to the Jenkins web packages
* Choose the job to run and play.
