#!/bin/bash

function readProperty() {
    cat $1 | 
    grep "^$2[[:space:]]*\=" | 
    head -1 | 
    cut -f2 -d= | 
    sed s/^[[:space:]]*//g | 
    sed s/[[:space:]]*$//g
}

JBOSS_HOME="/var/jboss-5.1.0.GA"
JBOSS_SERVER="esphoraSsl"

PROPERTYFILE="$JBOSS_HOME/server/$JBOSS_SERVER/conf/conector.properties"

AMBIENTE=`readProperty $PROPERTYFILE ambiente`
TSFILE=`readProperty $PROPERTYFILE servicio.jksfile`
KSFILE=`readProperty $PROPERTYFILE jksfile`

STOREPASS=`readProperty $PROPERTYFILE jkspwd`

TS="$JBOSS_HOME/server/$JBOSS_SERVER/conf/$TSFILE"
KS="$JBOSS_HOME/server/$JBOSS_SERVER/conf/$AMBIENTE/$KSFILE"
CERTPATH="$JBOSS_HOME/server/$JBOSS_SERVER/conf/$AMBIENTE/certs"

PATHPROPERTIES="$JBOSS_HOME/server/$JBOSS_SERVER/conf/$AMBIENTE"

SERVERS=`for i in $PATHPROPERTIES/*.properties
do
    readProperty $i wsdl | 
    cut -f3 -d/
done | uniq`

CUITSADECCO=`cat $CERTPATH/cuitsadecco`
