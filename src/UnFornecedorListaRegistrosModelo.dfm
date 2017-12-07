inherited FornecedorListaRegistrosModelo: TFornecedorListaRegistrosModelo
  OldCreateOrder = True
  inherited ds: TSQLDataSet
    CommandText = 
      'SELECT FORN_OID, FORN_COD, FORN_NOME, FORN_FONE, '#13#10'  FORN_CIDADE' +
      ', FORN_UF'#13#10'  FROM FORN'#13#10'  WHERE FORN_OID IS NULL'#13#10'  ORDER BY FOR' +
      'N_OID'#13#10'  '
  end
end
