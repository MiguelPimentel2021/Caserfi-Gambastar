CREATE /*OR REPLACE*/ PACKAGE BODY XVDGAMBASTAR AS
  FUNCTION DAMEMATRICULA (MICNTSSCC VARCHAR2) RETURN VARCHAR2 IS
    
  MICODMAT VARCHAR2(60);

  BEGIN
    --BUSCA EL SSCC EN LAS MATRICULAS QUE PERTENECEN A UN SOLO PALET
    SELECT
      CODMAT INTO MICODMAT
    FROM VDCONTE
    WHERE CNTSSCC = MICNTSSCC
    AND ROWNUM = 1;

    --BUSCA LAS MATRICULAS MULTIPALET EN LA TABLA XDENTRAGAMBASTART
    IF MICODMAT IS NULL THEN
    SELECT
      VCT.CODMAT INTO MICODMAT
    FROM XDENTRAGAMBASTART GST
    JOIN
    (
      SELECT
        FECHACARGAJUL, FECHACARGAGRE, CODDIV1,NUMPEDIDO, NUMPALET
      FROM XDENTRAGAMBASTART
      WHERE MATRICULAPALET = MICNTSSCC
    )X ON X.FECHACARGAJUL = GST.FECHACARGAJUL AND X.FECHACARGAGRE = GST.FECHACARGAGRE
    JOIN VDCONTE VCT ON VCT.CNTSSCC = GST.MATRICULAPALET
    AND X.CODDIV1 = GST.CODDIV1 AND X.NUMPEDIDO = GST.NUMPEDIDO
    AND X.NUMPALET = GST.NUMPALET
    AND ROWNUM = 1;
    END IF;
    
    RETURN MICODMAT; 
  END;
END XVDGAMBASTAR;