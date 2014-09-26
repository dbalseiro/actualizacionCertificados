function getCertificate() {
	openssl s_client -connect $1:$2 << EOF 2>/dev/null | awk '
		/-----BEGIN CERTIFICATE-----/ { f = 1 }
		/-----END CERTIFICATE-----/   { print $0; f=0 }
		f '
QUIT
EOF
}
