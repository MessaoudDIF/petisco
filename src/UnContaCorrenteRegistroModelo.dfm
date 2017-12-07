inherited ContaCorrenteRegistroModelo: TContaCorrenteRegistroModelo
  OldCreateOrder = True
  Left = 322
  Top = 169
  inherited ds: TSQLDataSet
    CommandText = 
      'SELECT C.CCOR_OID, C.CCOR_TIPO, B.BAN_OID, C.CCOR_COD, '#13#10'  C.CCO' +
      'R_DES, C.CCOR_AGN, C.CCOR_AGNDG, C.CCOR_CONTA,'#13#10'  C.CCOR_CONTADG' +
      ', C.CCOR_LIM, C.CCOR_SALDO, '#13#10'  C.REC_STT, C.REC_INS, C.REC_UPD,' +
      ' C.REC_DEL, B.BAN_NOME  FROM CCOR C LEFT JOIN BAN B ON C.BAN_OID' +
      ' = B.BAN_OID'#13#10'  WHERE C.CCOR_OID IS NULL'#13#10'  ORDER BY C.CCOR_OID'
  end
  inherited cds: TClientDataSet
    BeforePost = cdsBeforePost
  end
end
