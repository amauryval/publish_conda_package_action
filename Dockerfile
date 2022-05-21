FROM continuumio/miniconda3:4.7.10

RUN conda install -y mamba
RUN mamba install boa -c conda-forge

COPY entrypoint.sh /entrypoint.sh

RUN ["chmod", "+x", "/entrypoint.sh"]

ENTRYPOINT ["/entrypoint.sh"]