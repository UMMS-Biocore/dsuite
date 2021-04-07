Dsuite docker version
========
DolphinNext, Dportal, Dmeta and Dsso can be run as a standalone application using a docker container.
First docker image need to be build unless you want to use prebuild from dockerhub. So, any change in the Dockerfile requires to build the image. But if you want to use prebuild version just skip building it and start the container.

Build docker image
---------

1. To build docker image first clone one of the latest dolphinnext-docker

```
git clone https://github.com/UMMS-Biocore/dsuite.git
```

2. Build the image
```
cd dsuite
docker build -t dsuite .
```

Start the container
---------

1. We move database outside of the container to be able to keep the changes in the database everytime you start the container.
Please choose a directory in your machine to mount and replace `/path/to/mount` with your path. 
* Note: Please don't change the target directory(`/export`) in the docker image. 

```
mkdir -p /path/to/mount
```

2. While running the container;
```
docker run -m 10G -p 8080:80 -p 3000:3000 -p 4000:4000 -p 5000:5000 -p 27017:27017 -v /path/to/mount:/export  -ti dsuite /bin/bash
```
*if you want to run a pre-build
```
docker run -m 10G -p 8080:80 -p 3000:3000 -p 4000:4000 -p 5000:5000 -p 27017:27017 -v /path/to/mount:/export  -ti ummsbiocore/dsuite /bin/bash
```

3. After you start the container, you need to start the mysql and apache server usign the command below;
```
startup
```
4. Verify that `dolphinnext` and `mysql` folders located inside of the `export` folder:
```
ls /export
```
5. Now, you can open your browser to access dolphinnext, dsso, dmeta, dportal using the urls below.

http://localhost:8080/dolphinnext
https://localhost:3000
https://localhost:4000
https://localhost:5000

Running on the Amazon or Google Cloud
------
We define `localhost:8080` in /path/to/mount/dolphinnext/config/.sec file and use that to log in or other operations. You need to change `localhost` to that IP address or amazon/google domain you use. So static IP address would solve the issue that you will not need to change it every time you create an instance. Please update `BASE_PATH` and `PUBWEB_URL` as follows:

```
BASE_PATH = http://localhost:8080/dolphinnext
PUBWEB_URL = http://localhost:8080/dolphinnext/tmp/pub
```

to
```
BASE_PATH = http://your_temporary_domain_name:8080/dolphinnext
PUBWEB_URL = http://your_temporary_domain_name:8080/dolphinnext/tmp/pub
```
* Please don’t change other lines because others are used inside of docker.



 


