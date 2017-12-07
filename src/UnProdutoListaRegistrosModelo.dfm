inherited ProdutoListaRegistrosModelo: TProdutoListaRegistrosModelo
  OldCreateOrder = True
  Height = 335
  inherited ds: TSQLDataSet
    CommandText = 
      'SELECT PRO_OID, PRO_COD, PRO_DES, PRO_VENDA'#13#10'  FROM PRO'#13#10'  WHERE' +
      ' PRO_OID IS NULL'#13#10'  ORDER BY  PRO_OID'
  end
end
