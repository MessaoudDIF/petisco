inherited CentroDeResultadoRegistroModelo: TCentroDeResultadoRegistroModelo
  OldCreateOrder = True
  Left = 591
  Top = 117
  inherited ds: TSQLDataSet
    CommandText = 
      'SELECT CRES_OID, CRES_COD, CRES_DES,'#13#10'  REC_STT, REC_INS, REC_UP' +
      'D, REC_DEL'#13#10'  FROM CRES'#13#10'  WHERE CRES_OID IS NULL'#13#10'  ORDER BY CR' +
      'ES_OID'#13#10'  '
  end
  inherited cds: TClientDataSet
    BeforePost = cdsBeforePost
  end
end
