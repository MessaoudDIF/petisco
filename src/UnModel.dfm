object Model: TModel
  OldCreateOrder = False
  Height = 286
  Width = 641
  object Sql: TSQLDataSet
    Params = <>
    Left = 576
    Top = 16
  end
  object ds: TSQLDataSet
    Tag = 5
    CommandText = 
      'select c.coma_oid, c.cl_oid, c.coma_comanda, c.coma_data, '#13#10'  c.' +
      'coma_consumo, c.coma_saldo, c.coma_total, c.coma_stt,'#13#10'  c.coma_' +
      'txserv, c.coma_mesa, l.cl_cod'#13#10'  from coma c inner join cl l on ' +
      'c.cl_oid = l.cl_oid'#13#10'  where c.coma_oid is null'
    MaxBlobSize = -1
    Params = <>
    Left = 32
    Top = 16
  end
  object dsp: TDataSetProvider
    DataSet = ds
    Options = [poCascadeDeletes, poCascadeUpdates, poAllowMultiRecordUpdates, poAllowCommandText]
    UpdateMode = upWhereKeyOnly
    Left = 32
    Top = 80
  end
  object cds: TClientDataSet
    Tag = 5
    Aggregates = <>
    Params = <>
    ProviderName = 'dsp'
    Left = 32
    Top = 144
  end
  object dsr: TDataSource
    DataSet = cds
    Left = 32
    Top = 208
  end
end
