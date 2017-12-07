inherited ProdutoPesquisaModelo: TProdutoPesquisaModelo
  OldCreateOrder = True
  Height = 330
  inherited ds: TSQLDataSet
    CommandText = 
      'select pro_oid,  pro_cod, pro_des, pro_venda from pro where pro_' +
      'oid is null'
  end
end
