inherited CentroDeResultadoListaRegistrosModelo: TCentroDeResultadoListaRegistrosModelo
  OldCreateOrder = True
  Left = 559
  Top = 172
  inherited ds: TSQLDataSet
    CommandText = 
      'SELECT CRES_OID, CRES_COD, CRES_DES'#13#10'  FROM CRES'#13#10'  ORDER BY CRE' +
      'S_DES'
  end
end
