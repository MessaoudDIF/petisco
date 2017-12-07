inherited FornecedorPesquisaModelo: TFornecedorPesquisaModelo
  OldCreateOrder = True
  inherited ds: TSQLDataSet
    CommandText = 
      'SELECT FORN_OID, FORN_NOME, FORN_CIDADE, FORN_UF,    FORN_FONE'#13#10 +
      '  FROM FORN'#13#10'  WHERE FORN_OID IS NULL'#13#10'  ORDER BY FORN_NOME'
  end
end
