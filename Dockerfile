FROM alpine:3.15
RUN apk add --no-cache bash vim curl unzip zip jq openjdk11
ENV JAVA_HOME /usr/bin/java

RUN mkdir -p /mnt/crx/author && mkdir -p /mnt/crx/author/crx-quickstart/install
WORKDIR /mnt/crx/author

COPY ./startauthor.sh ./
COPY ./admin.properties ./

# Provided by ADOBE 
COPY ./license.properties ./
COPY ./cq-quickstart-6.5.0.jar ./cq-quickstart.jar

# https://helpx.adobe.com/experience-manager/kb/HowToInstallPackagesUsingRepositoryInstall.html
# Requires Core Components 2.18.0+ and ACS 5.1.2+ for transforms
COPY ./core.wcm.components.all-2.18.0.zip /mnt/crx/author/crx-quickstart/install/core.wcm.components.all-2.18.0.zip
COPY ./acs-aem-commons-content-5.1.2.zip /mnt/crx/author/crx-quickstart/install/acs-aem-commons-content-5.1.2.zip

# service pack
COPY ./aem-service-pkg-6.5.11.zip /mnt/crx/author/crx-quickstart/install/aem-service-pkg-6.5.11.zip

EXPOSE 445 4502

RUN java -jar cq-quickstart.jar -unpack

ENTRYPOINT ["/mnt/crx/author/startauthor.sh"]
