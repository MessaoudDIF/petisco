inherited ContasPagarListaRegistrosModelo: TContasPagarListaRegistrosModelo
  OldCreateOrder = True
  Left = 930
  Top = 319
  inherited ds: TSQLDataSet
    CommandText = 
      'SELECT T.TIT_OID, T.TIT_VENC, T.TIT_VALOR, T.TIT_LIQ, '#13#10'  T.TIT_' +
      'PAGO, F.FORN_NOME'#13#10'  FROM TIT T INNER JOIN FORN F ON T.FORN_OID ' +
      '= F.FORN_OID'#13#10'  WHERE T.TIT_OID IS NULL'#13#10'  ORDER BY T.TIT_VENC'
  end
end
