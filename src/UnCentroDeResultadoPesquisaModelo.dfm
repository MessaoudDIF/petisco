inherited CentroDeResultadoPesquisaModelo: TCentroDeResultadoPesquisaModelo
  OldCreateOrder = True
  Left = 760
  Top = 191
  inherited ds: TSQLDataSet
    CommandText = 
      'SELECT CRES_OID, CRES_COD, CRES_DES'#13#10'  FROM CRES'#13#10'  WHERE CRES_O' +
      'ID IS NULL'#13#10'  ORDER BY CRES_DES'
  end
end
