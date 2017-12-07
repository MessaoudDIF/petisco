inherited ProdutoRegistroModelo: TProdutoRegistroModelo
  OldCreateOrder = True
  Height = 339
  inherited ds: TSQLDataSet
    CommandText = 
      'SELECT PRO_OID, PRO_COD, PRO_DES, PRO_CUSTO, '#13#10'  PRO_VENDA, PRO_' +
      'SALDO,'#13#10'  REC_STT, REC_INS, REC_UPD, REC_DEL'#13#10'  FROM PRO'#13#10'  WHER' +
      'E PRO_OID IS NULL'#13#10'  ORDER BY PRO_OID'
  end
  inherited cds: TClientDataSet
    Tag = 10
  end
end
