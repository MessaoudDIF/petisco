inherited CategoriaRegistroModelo: TCategoriaRegistroModelo
  OldCreateOrder = True
  inherited ds: TSQLDataSet
    CommandText = 
      'SELECT CATS_OID, CAT_OID, CATS_COD, CATS_DES, '#13#10'  REC_STT, REC_I' +
      'NS, REC_UPD, REC_DEL'#13#10'  FROM CATS'#13#10'  WHERE CATS_OID IS NULL'#13#10'  O' +
      'RDER BY CATS_DES'
  end
  inherited cds: TClientDataSet
    BeforePost = cdsBeforePost
  end
end
