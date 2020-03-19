# jupyterhub-docker 
Password is set with Random script,
docker logs <instance>   to have the password of jupyterhub account 
jupyterhub will be launched without root privileges, to prevent any root access to the container from the notebook.
you can customise the root password by adding the SHA-256 hash to the build file.

## to generate a new root password  SHA512
openssl passwd -6 -salt XYZ password


to add any python library via pip command just add it to requirements2 for python 2 or requirements3 for python 3

## To Build the image

docker build . -t jemaiah/jupyterhub:0.1
