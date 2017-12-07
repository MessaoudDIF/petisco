inherited CategoriaPesquisaModelo: TCategoriaPesquisaModelo
  OldCreateOrder = True
  Left = 385
  Top = 221
  inherited ds: TSQLDataSet
    CommandText = 
      'SELECT S.CATS_OID, S.CATS_COD, S.CATS_DES'#13#10'  FROM CATS S INNER J' +
      'OIN CAT C ON S.CAT_OID = C.CAT_OID'#13#10'  WHERE C.CAT_TIPO = 1'#13#10'  OR' +
      'DER BY S.CATS_DES'
  end
end
