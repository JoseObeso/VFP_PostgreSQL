** cadena de conexion PostgreSQL 12
CLOSE DATABASES all
clear
** lcStringCnxLocal = "Driver={PostgreSQL ODBC Driver(UNICODE)};Server=127.0.0.1;Port=5432;Database=BDIRTP;Uid=postgres;Pwd=12345;"

lcStringCnxLocal = "Driver={PostgreSQL ODBC Driver(UNICODE)};Server=VirtualMeryEdel;Port=5432;Database=BDIRTP;Uid=postgres;Pwd=12345;"




Sqlsetprop(0,"DispLogin" , 3 ) 
SQLSETPROP(0,"IdleTimeout",0)
gconecta=SQLSTRINGCONNECT(lcStringCnxLocal)

?gconecta
TEXT TO lqry_consultar NOSHOW 
	 select * from bienes_patrimoniales.catalogobienes
ENDTEXT
**lejecutabusca = sqlexec(gconecta,lqry_consultar, "tresul")
**SELECT TRESUL
**BROWSE
**CLOSE DATABASES ALL

