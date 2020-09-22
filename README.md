# dock_work
This contains Dockerfile and requirements to 
* build a dcoker image with Ubuntu: lates
* install jupyterlab
* install necesarry Python modules listed in the requirements file

run_jup_lab.sh mounts runs docker image by 
* opening port 8888
* mounting notebooks directory so that any changes sre save and acessible outside docker as well.
