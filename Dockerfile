
## see https://github.com/openanalytics/r-base/blob/master/Dockerfile
FROM r-base:3.5.1

# devtools needs this
RUN apt update -y && apt upgrade -y && apt-get install -y --fix-missing \
software-properties-common \
build-essential gcc \
build-essential 

# Install OpenJDK-12
RUN apt-get update && \
    apt-get install -y openjdk-12-jdk && \
    apt-get install -y ant && \
    apt-get clean;

# Fix certificate issues
RUN apt-get update && \
    apt-get install ca-certificates-java && \
    apt-get clean && \
    update-ca-certificates -f;

# Setup JAVA_HOME -- useful for docker commandline
ENV JAVA_HOME /usr/lib/jvm/java-12-openjdk-amd64/
RUN export JAVA_HOME

RUN apt-get -y install libssl-dev libcurl4-openssl-dev libhdf5-dev libxml2-dev
# important to have single quote around the pacakge names, double quotes will fail
RUN Rscript -e "install.packages('devtools')"
RUN Rscript -e 'install.packages("BiocManager")' \
-e 'BiocManager::install("ComplexHeatmap")' \
-e 'BiocManager::install("BiocParallel")' \
-e 'BiocManager::install("DESeq2")' \
-e 'BiocManager::install("MAST")' \
-e 'BiocManager::install("S4Vectors")' \
-e 'BiocManager::install("SingleCellExperiment")' \
-e 'BiocManager::install("SummarizedExperiment")' 
RUN Rscript -e "devtools::install_version('Seurat', version = '3.0.2',  repos = 'http://cran.us.r-project.org')"
RUN Rscript -e "install.packages('tidyverse')"


RUN Rscript -e "devtools::install_github('crazyhottommy/scclusteval', ref = 'seuratv3', upgrade = 'ask')"