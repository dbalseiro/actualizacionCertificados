#!/bin/bash

function saveCertificate() {
	keytool -delete -alias $1 -keystore $3 -storepass $STOREPASS -noprompt
        keytool -import -alias $1 -file $2 -keystore $3 -storepass $STOREPASS -noprompt
}

function getCertificate() {
	openssl s_client -connect $1:$2 << EOF 2>/dev/null | awk '
		/-----BEGIN CERTIFICATE-----/ { f = 1 }
		/-----END CERTIFICATE-----/   { print $0; f=0 }
		f '
QUIT
EOF
}
