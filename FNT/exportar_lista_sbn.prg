** cadena de conexion PostgreSQL 12
CLOSE DATABASES all
CLEAR
** para Local
lcStringCnxLocal = "Driver={PostgreSQL ODBC Driver(UNICODE)};Server=127.0.0.1;Port=5432;Database=BDIRTP;Uid=postgres;Pwd=12345;"
Sqlsetprop(0,"DispLogin" , 3 ) 
SQLSETPROP(0,"IdleTimeout",0)
gconecta=SQLSTRINGCONNECT(lcStringCnxLocal)
 

** para server
lcStringCnxServer = "Driver={PostgreSQL ODBC Driver(UNICODE)};Server=192.168.0.13;Port=5432;Database=BDIRTP;Uid=postgres;Pwd=atila2010;"
Sqlsetprop(0,"DispLogin" , 3 ) 
SQLSETPROP(0,"IdleTimeout",0)
gconecta_server=SQLSTRINGCONNECT(lcStringCnxServer)

 

TEXT TO lqry_datalocal noshow
  SELECT   item, codigo, denominacion, unidad, grupo, clase, resolucion, 
       estado 
  FROM bienes_patrimoniales."ListaSBN";
ENDTEXT
lejecutabusca = sqlexec(gconecta, lqry_datalocal, "tsbn")
SELECT tsbn
gO top
SCAN
   lc_item = ALLTRIM(tsbn.item)
   lc_codigo = ALLTRIM(tsbn.codigo)
   lc_denominacion = ALLTRIM(tsbn.denominacion)
   lc_unidad = ALLTRIM(tsbn.unidad)
   lc_grupo = ALLTRIM(tsbn.grupo)
   lc_clase = ALLTRIM(tsbn.clase)
   lc_resolucion = ALLTRIM(tsbn.resolucion)
   lc_estado  = ALLTRIM(tsbn.estado)
   
   TEXT TO lqry_insert noshow
    INSERT INTO bienes_patrimoniales."ListaSBN"(item, codigo, denominacion, unidad, grupo, clase, resolucion, 
            estado)
    VALUES (?lc_item, ?lc_codigo, ?lc_denominacion, ?lc_unidad, ?lc_grupo, ?lc_clase,
         ?lc_resolucion, ?lc_estado);
   ENDTEXT
   lejecutabusca = sqlexec(gconecta_server, lqry_insert)
   ?lc_denominacion
   

ENDSCAN
  