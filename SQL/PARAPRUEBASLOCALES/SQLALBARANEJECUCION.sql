SPOOL C:\V10\REDUR\V10DATOS\LOG\CASERFRIALBARAN.LOG APPEND
SET serveroutput ON
SET LINESIZE 200
DECLARE
   verror_code NUMBER := 0;
   verror_message NVARCHAR2 := 0;
   
BEGIN
   VDCASERFRY_ALBARAN_DEMANDA.V10_CARGA_DATOS_DEMANDA(verror_code, verror_message);
   COMMIT;
	     
END;
/
SET serveroutput OFF
SPOOL OFF
/
EXIT;
/