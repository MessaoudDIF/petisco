inherited ContaCorrenteListaRegistrosModelo: TContaCorrenteListaRegistrosModelo
  OldCreateOrder = True
  Left = 400
  Top = 227
  inherited ds: TSQLDataSet
    CommandText = 
      'SELECT CCOR_OID, CCOR_COD, CCOR_DES'#13#10'  FROM CCOR'#13#10'  WHERE REC_ST' +
      'T = 0 ORDER BY CCOR_COD'
  end
end
