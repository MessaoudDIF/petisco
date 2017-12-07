object Modelo: TModelo
  OldCreateOrder = False
  Height = 357
  Width = 704
  object Sql: TSQLDataSet
    Tag = 5
    Params = <>
    Left = 576
    Top = 16
  end
  object ds: TSQLDataSet
    Tag = 5
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
    AfterPost = cdsAfterPost
    Left = 32
    Top = 152
  end
  object dsr: TDataSource
    DataSet = cds
    Left = 32
    Top = 208
  end
end
