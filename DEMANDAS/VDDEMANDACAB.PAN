# M�dulo   : VDDEMANDACAB.PAN
# Funci�n  : Mantenimiento de Cabeceras de Demanda alex 01 pruaba Push
#
# Creaci�n : 25-03-2008
# Autor    : FGS
###########################################
# Hist�rico de cambios:
MANTENIMIENTO DE CABECERAS DE DEMANDA

 C�digo __________ Tipo __________ _40________________________________________________
 
 Estado #L### _30____________________ Backorder _ Prioridad #L###  Comentario #L#######
 
 Fecha Necesidad: �D-MM-Y.YY  Datos externos: _50_____________________________________ 
 Inicio:   �D-MM-Y.YY  ________       Insercci�n: _32________ �D-MM-Y.YY  ________ 
 Finaliz:  �D-MM-Y.YY  ________       �lt. Modif: _32________ �D-MM-Y.YY  ________  
|


TABLA=VDDEMANDACAB
ORDERBY=CODDEMANDA DESC;

PREUPDATE=FEJECUTA("CSELMODIF","ERROR EN FECHA DE MODIFICACION")



CAMPO=CODDEMANDA,NOUPDATE,TOOLTIP("C�digo de la Cabacera de Demanda")
CAMPO=TIPODEMANDA,NOUPDATE,TOOLTIP("Tipo de Demanda")
CAMPO=DESTIPO,AUXILIAR,NOENTER,TOOLTIP("Descripci�n del Tipo de Cabecera de Demanda"),POSTCHANGE=FDESIGNACION("+CTIPODEM","")
CAMPO=STATUS,TOOLTIP("Estado de la Cabecera de Demanda"),POSTCHANGE=FDESIGNACION("+CSTATUS","")

CAMPO=DESSTATUS,AUXILIAR,NOENTER,TOOLTIP("Descripci�n del estado de la Cabecera de Demanda")
CAMPO=BACKORDER,NOENTER,TOOLTIP("Backorder de la Cabecera de Demanda")
CAMPO=PRIORI,TOOLTIP("Prioridad de la Cabecera de Demanda")
CAMPO=CODCOMEN,NOENTER,TOOLTIP("C�digo de Comentario asociado a la Cabecera de Demanda")
CAMPO=FECNEC,NOUPDATE,TOOLTIP("Fecha en la que se programa que se active la demanda, para demandas diferidas")
CAMPO=CLAVEEXT,NOENTER,TOOLTIP("Clave externa que permite relacionar con otros sistemas")
CAMPO=FECINI,NOUPDATE,TOOLTIP("Fecha en la que se reserva por primera vez una l�nea de esta cabecera de Demanda")
CAMPO=HORAINI,NOUPDATE,TOOLTIP("Hora en la que se reserva por primera vez una l�nea de esta cabecera de Demanda")
CAMPO=CODOPEINSERT,NOENTER,TOOLTIP("Operario que realiz� la insercci�n de la cabecera de demanda")
CAMPO=FECINSERT,TOOLTIP("Fecha en la que se insertaron los datos del registro")
CAMPO=HORAINSERT,NOENTER,TOOLTIP("Hora en la que se insertaron los datos del registro")
CAMPO=FECFIN,NOUPDATE,TOOLTIP("Fecha en la que se cierra la �ltima l�nea pendiente de esta cabecera de Demanda")
CAMPO=HORAFIN,NOUPDATE,TOOLTIP("Hora en la que se cierra la �ltima l�nea pendiente de esta cabecera de Demanda")
CAMPO=CODOPEMODIF,NOENTER,TOOLTIP("Operario que realiz� la �ltima modificaci�n")
CAMPO=FECMODIF,NOENTER,TOOLTIP("Fecha en que se modificaron los datos del registro")
CAMPO=HORAMODIF,NOENTER,TOOLTIP("Hora en que se modificaron a los datos del registro")

CURSOR=CTIPODEM SELECT DESTIPO FROM VDDEMANDATIPO WHERE TIPODEMANDA=:TIPODEMANDA;

CURSOR=CSTATUS SELECT DESSTATUS FROM VDSTATUS WHERE STATUS=:STATUS AND TIPOSTATUS='DEC';

CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF,VD.FECHASYS FECMODIF,VD.HORASYS HORAMODIF FROM DUAL;

CURSOR=CDUMMY SELECT :CODDEMANDA  FROM DUAL WHERE 1=1;


TECLA=SF8,FEJECUTA("!-CDUMMY","� ESTA SEGURO DE ANULAR TODA LA DEMANDA ?",
									 FANULADEMCSYNC("FINDEMLANULADAS",":CODDEMANDA",":TIPODEMANDA"),":V10ERROR",
                   FCOMMIT,"",
                   %FFAILURE,"ANULACI�N REALIZADA") 
                   
             

