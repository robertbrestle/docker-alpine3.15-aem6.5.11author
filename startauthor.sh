#!/bin/bash

set -e

java -Dadmin.password.file=admin.properties -XX:MaxPermSize=1024M -Xmx2048m -jar cq-quickstart.jar -Dsling.run.modes=RUN-MODE -r author -p 4502 -nointeractive