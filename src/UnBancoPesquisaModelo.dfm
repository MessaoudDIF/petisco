inherited BancoPesquisaModelo: TBancoPesquisaModelo
  OldCreateOrder = True
  inherited ds: TSQLDataSet
    CommandText = 
      'SELECT BAN_OID, BAN_COD, BAN_NOME'#13#10'  FROM BAN'#13#10'  ORDER BY BAN_NO' +
      'ME'#13#10
  end
end
