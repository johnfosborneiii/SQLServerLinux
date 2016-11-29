# SQL Server on Linux Dockerfiles
==================

This repository shows how to run SQL Server on a Linux Container with a Red Hat Enterprise Linux (RHEL) or CentOS base image

This repo contains a recipe for a making Docker container for SQL Server on either RHEL 7 or CentOS7.

Note: This is not yet supported by Red Hat. Once/if it is supported there will be an official docker image from Red Hat. This image is merely meant to serve as a proof of concept.

### Using pre-built images from Docker Hub: ###

You can use the images already built from docker hub

    # docker pull johnfosborneiii/rhel7sqlserver
    # docker pull johnfosborneiii/centos7sqlserver

Currently the images have the following default credentials which are set as environment variables in the docker file

    # Username: sa
    # Password: redhat1!

These containers use systemd inside the container to run SQL Server. Currently, CentOS requires the container to be in privileged mode to use systemd

    # docker run -d -p 1433:1433 --name rhel7sqlserver johnfosborneiii/rhel7sqlserver
    # docker run --privileged  -d -p 1433:1433 --name centos7sqlserver johnfosborneiii/centos7sqlserver 

### Building the containers ###

Setup
-----

Red Hat Enterprise Linux requires a subscription. The way to build RHEL containers is to run the docker build on a properly subscribed RHEL host. By doing so, the container utilizes the subscription of the host. If you do not have a RHEL host for the build you can download one for free through the OpenShift CDK available here:
http://developers.redhat.com/products/cdk/overview/

Alternatively you could use CentOS for development purposes.

Perform the build running either:

    # docker build --tag=rhel7sqlserver .
    # docker build --tag=centos7sqlserver -f Dockerfile.CentOS .

Launching SQL Server
-----------------

### Quick start (not recommended for production use): ###

    # docker run -d -p 1433:1433 --name rhel7sqlserver johnfosborneiii/rhel7sqlserver
    # docker run --privileged  -d -p 1433:1433 --name centos7sqlserver johnfosborneiii/centos7sqlserver 

Once this is supported technology and Red Hat provides an official image there will be other considerations from production use such as:

- Use the Red Hat Enterprise Linux base container and not the CentOS base container as it is properly maintained with security fixes, patches, regression testing, etc.
- Use a separate data volume for /var/opt/mssql (recommended, to allow image update without losing database contents). If you're running in OpenShift you will want to use a persistent volume.
- Backup/restore (snapshot) policies for data device storing data
- Proper database and OS tuning based upon workload

Using your SQL Server container
----------------------------

If you're using Linux for development, you can install DBeaver as an admin tool to connect to SQL Server


