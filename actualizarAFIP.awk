function logAdecco(m) 
{
	printf("[INFO] %s\n", m);
}

BEGIN {
	logAdecco("Comienzo de copia de certificados");
	imprimir = 0;
	lineas = 0;
}

/^CUIT/ {
	file = $2".crt";
	logAdecco(sprintf("Generando certificado %s", file));
}

/-----BEGIN CERTIFICATE-----/ {
	imprimir = 1;
	lineas = 0;
}

/-----END CERTIFICATE-----/ {
	print $0 >> file;
	imprimir = 0;
	lineas++;
	logAdecco(sprintf("Impresas %i lineas", lineas));
	logAdecco(sprintf("Fin del certificado %s", file));
}

imprimir { 
	print $0 >> file;
	lineas++;
}

END {
	logAdecco("Fin de copia de certificados");
}
