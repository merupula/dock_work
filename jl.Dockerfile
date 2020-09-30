FROM ubuntu:latest
RUN apt-get update && apt-get upgrade && apt-get -y update
RUN apt-get install -y build-essential python3.6 python3-pip python3-dev
RUN pip3 -q install --upgrade setuptools pip
WORKDIR /srv
ADD ./requirements.txt /srv/requirements.txt
RUN pip3 install -r requirements.txt
RUN pip3 install jupyter
RUN pip3 install jupyterlab
ADD . /srv

# Add Tini. Tini operates as a process subreaper for jupyter. This prevents kernel crashes. 
ENV TINI_VERSION v0.6.0 
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /usr/bin/tini 
RUN chmod +x /usr/bin/tini 
ENTRYPOINT ["/usr/bin/tini", "--"]

WORKDIR /srv/notebooks
RUN jupyter notebook --generate-config
RUN echo "c.NotebookApp.password='argon2:$argon2id$v=19$m=10240,t=10,p=8$oktcJnxcaXcnv2tkctqNOQ$MKDvy+VK7quNRwSzP8nFDw'" >> /root/.jupyter/jupyter_notebook_config.py
CMD ["jupyter", "lab", "--port=8888", "--no-browser", "--ip=0.0.0.0", "--allow-root", "--config=/root.jupyter/jupyter_notebook_config.py"]
