# **Poky**

Open Source Summit 2k18 (Paris)

### **Description**

> The Yocto Project (YP) is an open source collaboration project that helps developers create custom Linux-based systems regardless of the hardware architecture.
The project provides a flexible set of tools and a space where embedded developers worldwide can share technologies, software stacks, configurations, and best practices that can be used to create tailored Linux images for embedded and IOT devices, or anywhere a customized Linux OS is needed.

This is a [poky](https://www.yoctoproject.org/software-item/poky/) container to build your own **Linux** image for whatever kind of architecture.

### **Usage**

To run the docker container execute:

```shell
$  ./set.sh
```

This bash script (_to use at your own risk if you have sensitive data on your system_) will:

+ Build locally the Docker **image**
+ Cleanup your **system** :warning:
+ Create the **bridge** network
+ Run the image

### **Storage**

All the data created with **poky** are persistent and stored in the volume `poky`.

Inside your **host** machine you can easily find under the path: `/var/lib/docker/volumes/poky`.

### **Yocto**

Once you're inside the container, you can test your **yocto** environment in this way:

```shell
$ cd poky
$ source oe-init-build-env qemux86-build
$ bitbake core-image-minimal # requires a long time ...
$ runqemu qemux86
```

If the `bitbake` process ends up fine you should be able to boot your first **x86_64** Linux image built with yocto, using the [core-image-minimal](https://layers.openembedded.org/layerindex/recipe/579/) layer.

---

Happy hacking!

### **Credits**

+ [crops/yocto-dockerfiles](https://github.com/crops/yocto-dockerfiles)

### **Doc**

For more info check out the official doc:

+ [yocto](https://www.yoctoproject.org/)

or take a look at the cheat sheet:

+ [cheat sheet](https://github.com/gcamerli/poky/blob/master/doc/yocto_cheatsheet.pdf)

### **GPL License**

This work is licensed under the terms of **[GNU General Public License v3.0](https://www.gnu.org/licenses/gpl.html)**.
