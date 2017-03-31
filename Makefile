run: roots.pem
	./ct-honeybee -

roots.pem: roots/*.pem
	cat roots/*.pem > roots.pem
