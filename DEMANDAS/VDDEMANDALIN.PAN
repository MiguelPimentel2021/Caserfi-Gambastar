# M�dulo   : VDDEMANDALIN.PAN
# Funci�n  : Mantenimiento de L�neas de Demanda
#
# Creaci�n : 25-03-2008
# Autor    : FGS
###########################################
# Hist�rico de cambios:
MANTENIMIENTO DE L�NEAS DE DEMANDA
L�nea Articulo       Cantidad      Reservado     Falta                    Estado                  Origen                Destino   
#L### _20___________ #L15#####.### #L15#####.### #L15#####.### _10_______ #L#### _30_____________ _12_______ _10_______ _12_______ _10_______ 
|

TABLA=VDDEMANDALIN

PREUPDATE=FEJECUTA("CSELMODIF","ERROR EN FECHA DE MODIFICACION")



CAMPO=CODDEMANDA,VIRTUAL,OCULTO
CAMPO=TIPODEMANDA,VIRTUAL,OCULTO
CAMPO=LINDEMANDA,NOENTER,TOOLTIP("N�MERO DE L�NEA DE DEMANDA"),TITULO("L�nea")
CAMPO=CODART,NOUPDATE,TOOLTIP("Art�culo a trasladar"),TITULO("Art�culo"), POSTCHANGE=FEJECUTA ("+%-CVERIFICAPULPO", "EL ART�CULO :CODART DEBE SER PESADO PARA INFORMAR A A.A.")
CAMPO=CANTIDAD,POSTCHANGE=FDESIGNACION("+CMIUNIDAD","",
                                               "CRESERVADO","ERROR EN CRESERVADO",
                                               "CFALTA","ERROR EN CFALTA"),CONVIERTE=FEJECUTA(FIF("CUNIAGRUPAU",FCONVIERTEARTFROMDB(":CODART")));FEJECUTA(FIF("CUNIAGRUPAU",FCONVIERTEART2DB(":CODART"))),
                          TITULO("Cantidad")                     
                                               
                                             
CAMPO=RESERVADO,AUXILIAR,NOENTER,TOOLTIP("Cantidad Total de la l�nea demanda reservada hasta el momento"),CONVIERTE=FEJECUTA(FIF("CUNIAGRUPAU",FCONVIERTEARTFROMDB(":CODART")));FEJECUTA(FIF("CUNIAGRUPAU",FCONVIERTEART2DB(":CODART"))),TITULO("Reservado")
CAMPO=FALTA,AUXILIAR,NOENTER,TOOLTIP("Cantidad que falta por trasladar de la l�nea de demanda"),CONVIERTE=FEJECUTA(FIF("CUNIAGRUPAU",FCONVIERTEARTFROMDB(":CODART")));FEJECUTA(FIF("CUNIAGRUPAU",FCONVIERTEART2DB(":CODART"))),TITULO("Falta")
CAMPO=MIUNIDAD,AUXILIAR,NOENTER,TOOLTIP("Unidades en las que se pide la mercancia")
CAMPO=STATUS,TOOLTIP("Estado de la l�nea de demanda"),POSTCHANGE=FDESIGNACION("+CSTATUS",""),TITULO("Estado")
CAMPO=DESSTATUS,AUXILIAR,NOENTER,TOOLTIP("Descripci�n del estado de la l�nea de demanda")
CAMPO=CODUBIORI,TOOLTIP("Si se informa, Ubicaci�n de origen desde la que se traslada la mercanc�a"),TITULO("Origen")
CAMPO=CODAREAORI,TOOLTIP("Si se informa, �rea de origen desde la que se traslada la mercanc�a")
CAMPO=CODUBIDEST,TOOLTIP("Si se informa, Ubicaci�n de destino a la que se traslada la mercanc�a"),TITULO("Destino")
CAMPO=CODAREADEST,TOOLTIP("�rea de destino a la que se traslada la mercanc�a")
CAMPO=UNIAGRUPA,OCULTO,"_"
CAMPO=CODOPEMODIF,OCULTO,"_32__________"
CAMPO=FECMODIF,OCULTO,"�D-MM-Y.YY"
CAMPO=HORAMODIF,OCULTO,"________"
CAMPO=CODLOT, OCULTO, "_20_"


CURSOR=CUNIAGRUPAU SELECT :UNIAGRUPA FROM DUAL WHERE :UNIAGRUPA='U';

CURSOR=CMIUNIDAD SELECT DECODE(:UNIAGRUPA,'E','EMBALAJES','C','CONTENEDORES',UNIDADESHOST) MIUNIDAD FROM VDARTIC WHERE CODART=:CODART;

CURSOR=CSTATUS SELECT DESSTATUS FROM VDSTATUS WHERE STATUS=:STATUS AND TIPOSTATUS='DEL';

CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF,VD.FECHASYS FECMODIF,VD.HORASYS HORAMODIF FROM DUAL;

CURSOR=CRESERVADO SELECT VDDEM.RESERVADODEML(:CODDEMANDA,:TIPODEMANDA,:LINDEMANDA,:UNIAGRUPA) RESERVADO FROM DUAL;

CURSOR=CFALTA SELECT :CANTIDAD-:RESERVADO FALTA FROM DUAL;

CURSOR=CDUMMY SELECT :CODDEMANDA  FROM DUAL WHERE 1=1;

CURSOR = CVERIFICAPULPO SELECT :CODART FROM VDCONFI WHERE GRUPOPROP = 'CASERFRI' AND PROPIEDAD = 'ARTICULOSAPESAR_AA' AND VD.CONTIENE (VALOR, :CODART)>0;

TECLA=SF8,FEJECUTA("!-CDUMMY","� ESTA SEGURO DE ANULAR LA L�NEA DE DEMANDA ?",
									 FANULADEMLSYNC("FINDEMLANULADAS",":CODDEMANDA",":TIPODEMANDA",":LINDEMANDA"),":V10ERROR",
                   FCOMMIT,"",
                   %FFAILURE,"ANULACI�N REALIZADA") 
                   

