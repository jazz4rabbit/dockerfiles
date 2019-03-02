FROM jupyter/minimal-notebook
LABEL maintainer="jazz4rabbit <jazz4rabbit@gmail.com>"

# program install with root
USER root
RUN apt-get update -qq -y && \
apt-get install -qq -y --no-install-recommends \
vim \
default-jdk \
software-properties-common

RUN apt-get update && \
apt-get upgrade -y && \
apt-get install -y  software-properties-common && \
add-apt-repository ppa:webupd8team/java -y && \
apt-get update && \
echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
apt-get install -y oracle-java8-installer

RUN echo 'JAVA_HOME="/usr/lib/jvm/java-8-oracle"' >> /etc/environment

# change user jovyan
USER ${NB_USER}

RUN conda init bash && \
conda create -yq -n weka36 python=3.6

RUN bash -c ". /opt/conda/etc/profile.d/conda.sh; \
conda activate weka36; \
conda install -yq gxx_linux-64 numpy pillow matplotlib pygraphviz; \
pip install -q javabridge python-weka-wrapper3 ipykernel; \
python -m ipykernel install --user --name weka36 --display-name 'Python 3.6 (Weka)'"

## logo change
COPY assets /home/jovyan/assets
RUN bash -c "cd ~; \
cp ~/assets/weka.ico ~/.local/share/jupyter/kernels/weka36/logo-32x32.png; \
cp ~/assets/weka.ico ~/.local/share/jupyter/kernels/weka36/logo-64x64.png"
