<h1>Scripts to help run docker containers</h1>

<h2>Forwarding X commands</h2>
The docker-runx script augments the docker-run command, setting up the xauth files that are needed to forward commands and mounting the files in the correct location in the image. 

To enter a container allowing the xforwarding, do 
```
./docker-runx -t -i $imagename 
```

<h2>Installing nvidia driver</h2>

Installing the nvidia driver is not fully automated yet. It currently requires two steps:

* First run the install_nvidia_docker.sh script to download the nvidia driver used by your system

``` 
sh install_nvidia_docker.sh $imagename
```
* If the script fails without entering the container, manually enter the container

```
docker run -t -i -v $PWD:/mnt $imagename
```
* From inside the container run the second script

```
sudo sh /mnt/install_nvidia_internal.sh
```
* Make sure that the xorg major numbers are the same for the container and your host OS by comparing the results of the following command on each:

```
dpkg -l | grep xorg
```

If they are not the same, look into which xorg package is installed. Contact jonweisz@gmail.com for details. 

* For QT based programs, the "raster" QT_GRAPHICSSYSTEM fails, so add the following the your envivonment in your .bashrc or somewhere else

```
export QT_GRAPHICSSYSTEM=native
```

* Show existing containers
```
docker ps
```

* Save your new container
```
docker commit -m "Set up nvidia driver" -a "$authorname" $containername $imagename
```


