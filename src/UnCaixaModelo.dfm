inherited CaixaModelo: TCaixaModelo
  OldCreateOrder = True
  inherited ds: TSQLDataSet
    CommandText = 
      'SELECT MCX_OID, MCX_DATA, MCX_TPORIG, MCX_VALOR,'#13#10'  MCXOP_OID, M' +
      'CX_DC, MCX_HISTORICO, MCX_MPAG'#13#10'  FROM MCX'#13#10'  WHERE MCX_OID IS N' +
      'ULL'#13#10'  ORDER BY MCX_OID'
  end
  inherited cds: TClientDataSet
    BeforePost = cdsBeforePost
  end
  object ds_extrato: TSQLDataSet
    Tag = 5
    CommandText = 
      'SELECT MCX_OID, MCX_DATA, MCX_TPORIG, MCX_VALOR,'#13#10'  MCXOP_OID, M' +
      'CX_DC, MCX_HISTORICO, MCX_MPAG'#13#10'  FROM MCX'#13#10'  WHERE MCX_OID IS N' +
      'ULL'#13#10'  ORDER BY MCX_OID'
    MaxBlobSize = -1
    Params = <>
    Left = 144
    Top = 16
  end
  object dsp_extrato: TDataSetProvider
    DataSet = ds_extrato
    Options = [poCascadeDeletes, poCascadeUpdates, poAllowMultiRecordUpdates, poAllowCommandText]
    UpdateMode = upWhereKeyOnly
    Left = 144
    Top = 80
  end
  object cds_extrato: TClientDataSet
    Aggregates = <>
    CommandText = 'SELECT MCX_OID, MCX_DATA, MCX_TPORIG, MCX_VALOR,'
    Params = <>
    ProviderName = 'dsp_extrato'
    BeforePost = cdsBeforePost
    Left = 144
    Top = 144
  end
  object dsr_extrato: TDataSource
    DataSet = cds_extrato
    Left = 144
    Top = 208
  end
end
