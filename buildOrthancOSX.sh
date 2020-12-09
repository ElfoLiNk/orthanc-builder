#!/bin/bash

set -ex

# New version using the BuildBot CIS

if [ "$#" -ne 1 ]; then
    echo "Must provide a tag"
    exit -1
fi

URL='https://alain:koo4oCah@buildbot.orthanc-server.com/artifacts/Binaries/'
TARGET='/tmp/'
FOLDER=Orthanc-OSX-$1

# https://stackoverflow.com/a/4774063/881731
SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

mkdir ${TARGET}/${FOLDER}
cd ${TARGET}/${FOLDER}

# Resources
cp ${SCRIPTPATH}/orthancBuildResources/configOSX.json .
cp ${SCRIPTPATH}/orthancBuildResources/readmeOSX.txt readme.txt
cp ${SCRIPTPATH}/orthancBuildResources/startOrthanc.command .

# Orthanc core
wget "${URL}/Orthanc 1.8.1 - OS X Release/Orthanc"
wget "${URL}/Orthanc 1.8.1 - OS X Release/libModalityWorklists.dylib"
wget "${URL}/Orthanc 1.8.1 - OS X Release/libServeFolders.dylib"

chmod +x ./Orthanc

# Plugins
wget "${URL}/DicomWeb 1.3 - OS X Release/libOrthancDicomWeb.dylib"
wget "${URL}/MySQL 2.0 - OS X Release/libOrthancMySQLIndex.dylib"
wget "${URL}/MySQL 2.0 - OS X Release/libOrthancMySQLStorage.dylib"
wget "${URL}/OsimisWebViewer 1.4.1 - OS X Release/libOsimisWebViewer.dylib"
wget "${URL}/PostgreSQL 3.2 - OS X Release/libOrthancPostgreSQLIndex.dylib"
wget "${URL}/PostgreSQL 3.2 - OS X Release/libOrthancPostgreSQLStorage.dylib"
wget "${URL}/Transfers 1.0 - OS X Release/libOrthancTransfers.dylib"
wget "${URL}/WebViewer 2.6 - OS X Release/libOrthancWebViewer.dylib"
wget "${URL}/Stone 1.0 - OS X Release/libStoneWebViewer.dylib"
wget "${URL}/OsimisCloud 0.1 - OS X Release/libOrthancOsimisCloud.dylib"

# Create the archive
cd ${TARGET}
zip -r ${FOLDER}.zip ${FOLDER}
echo -e "\nThe archive can be found at: ${TARGET}/${FOLDER}.zip\n"
