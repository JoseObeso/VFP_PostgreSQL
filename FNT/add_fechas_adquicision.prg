** cadena de conexion PostgreSQL 12
CLOSE DATABASES all
clear
lcStringCnxLocal = "Driver={PostgreSQL ODBC Driver(UNICODE)};Server=127.0.0.1;Port=5432;Database=BDIRTP;Uid=postgres;Pwd=12345;"

Sqlsetprop(0,"DispLogin" , 3 ) 
SQLSETPROP(0,"IdleTimeout",0)
gconecta=SQLSTRINGCONNECT(lcStringCnxLocal)

**** 	 SELECT * FROM bienes_patrimoniales.afechaspatrimonio;
** select barras from bienes_patrimoniales.AFECHASPATRIMONIO WHERE BARRAS = 'A001071';

TEXT TO lqry_consultar NOSHOW 
  SELECT * FROM bienes_patrimoniales.afechaspatrimonio;
ENDTEXT
lejecutabusca = sqlexec(gconecta,lqry_consultar, "tresul")
SELECT TRESUL
GO top
SCAN
   lc_barra = ALLTRIM(tresul.barras)
   TEXT TO lqry_consultar_fecha NOSHOW 
	 SELECT TO_CHAR(FECHA_TRAN, 'DD/MM/YYYY') AS  VFECHA_TRAN FROM bienes_patrimoniales.transferenciabienes where iidbien in 
		(SELECT iidbien   FROM bienes_patrimoniales.bienespatrimonio where vcodbarra = ?lc_barra)  and tipo_docum > '00' order by fecha_tran limit 1
    ENDTEXT
   lejecutabusca1 = sqlexec(gconecta,lqry_consultar_fecha, "tresul2")
   SELECT tresul2
    lc_fecha = ALLTRIM(tresul2.VFECHA_TRAN)
   
    TEXT TO lqry_add_fecha NOSHOW 
        update bienes_patrimoniales.afechaspatrimonio set vfecha = ?lc_fecha where barras = ?lc_barra
    ENDTEXT
    lejecutabusca2 = sqlexec(gconecta,lqry_add_fecha)
    ?lejecutabusca2
    ?lc_barra   
    ?lc_fecha

ENDSCAN
CLOSE DATABASES ALL
?'TERMINO'
