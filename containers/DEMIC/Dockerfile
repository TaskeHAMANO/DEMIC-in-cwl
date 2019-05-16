FROM ubuntu:18.04

LABEL maintainer="Shinya Suzuki<sshinya@bio.titech.ac.jp>"
LABEL description="Container to reproduce difficulty in DEMIC"

ENV TOOLDIR /opt
# To disable time zone checking when installing R packages
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Tokyo

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update && \
    apt-get install -y --no-install-recommends build-essential \
                                               r-base \
                                               wget \
                                               zlib1g-dev \
                                               file \
                                               make \
                                               gfortran \
                                               libblas-dev \
                                               liblapack-dev \
                                               curl \
                                               libcurl4-openssl-dev \
                                               perl && \
    rm -rf /var/lib/apt/lists/*

# Install R libraries
# reshape2 is not documented in DEMIC README, but it required
RUN Rscript -e "install.packages('lme4')" && \
    Rscript -e "install.packages('FactoMineR')" && \
    Rscript -e "install.packages('reshape2')"

# Install DEMIC
WORKDIR ${TOOLDIR}
RUN wget https://excellmedia.dl.sourceforge.net/project/demic/DEMIC_v1.0.2.zip && \
    unzip DEMIC_v1.0.2.zip && \
    rm DEMIC_v1.0.2.zip

WORKDIR ${TOOLDIR}/DEMIC_v1.0.2
ENTRYPOINT ["perl", "/opt/DEMIC_v1.0.2/DEMIC.pl"]
CMD ["--help"]
