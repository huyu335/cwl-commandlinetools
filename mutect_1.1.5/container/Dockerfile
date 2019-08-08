################## BASE IMAGE ######################

FROM ubuntu:18.04

################## ARGUMENTS/Environments ##########

ARG BUILD_DATE
ARG BUILD_VERSION
ARG UBUNTU_VERSION=18.04
ARG LICENSE="Apache-2.0"
ARG MUTECT_VERSION=1.1.5

################## METADATA ########################
LABEL org.opencontainers.image.vendor="MSKCC"
LABEL org.opencontainers.image.authors="Ronak H Shah (shahr2@mskcc.org)" 

LABEL org.opencontainers.image.created=${BUILD_DATE} \ 
	org.opencontainers.image.version=${BUILD_VERSION} \
	org.opencontainers.image.licenses=${LICENSE} \
	org.opencontainers.image.version.mutect=${MUTECT_VERSION} \
	org.opencontainers.image.version.ubuntu=${UBUNTU_VERSION} \
	org.opencontainers.image.source.mutect="https://github.com/broadinstitute/mutect/releases/download/${MUTECT_VERSION}/muTect-${MUTECT_VERSION}-bin.zip" \

LABEL org.opencontainers.image.description="This container uses ubuntu ${UBUNTU_VERSION} as the base image to build \
	mutect version ${MUTECT_VERSION}"

################## INSTALL ##########################

#Ubuntu
RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get install -y build-essential \
    wget zip default-jre && \
	apt-get clean && \
    apt-get purge && \
    apt autoremove && \
    apt-get remove --yes --purge build-essential

#Install Java 8
RUN add-apt-repository ppa:openjdk-r/ppa && \
    apt-get update && \
    apt-get install -y openjdk-8-jdk && \
    apt-get install -y ant && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    rm -rf /var/cache/

# Define commonly used JAVA_HOME variable
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/jre/bin/

# Define default command
CMD ["bash"]

WORKDIR /usr/src

#Get Mutect
RUN wget https://github.com/broadinstitute/mutect/releases/download/${MUTECT_VERSION}/muTect-${MUTECT_VERSION}-bin.zip && \
	unzip xvzf muTect-${MUTECT_VERSION}-bin.zip && \
	rm muTect-${MUTECT_VERSION}-bin.zip && \
    chmod a+x muTect-1.1.5-bin/muTect-1.1.5.jar

ENV PATH=$PATH:/usr/src/muTect-1.1.5-bin/
