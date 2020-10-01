FROM continuumio/miniconda3:4.7.10

RUN conda install -y anaconda-client conda-build

COPY entrypoint.sh /entrypoint.sh
RUNchmod -rw /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]