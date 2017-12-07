inherited ClientePesquisaModelo: TClientePesquisaModelo
  OldCreateOrder = True
  Height = 359
  inherited ds: TSQLDataSet
    CommandText = 'select cl_oid, cl_cod, cl_nome from cl where cl_oid is null'
  end
end
