inherited VendaRapidaRegistroModelo: TVendaRapidaRegistroModelo
  OldCreateOrder = True
  inherited ds: TSQLDataSet
    CommandText = 
      'SELECT MCX_OID, MCX_DATA, MCX_TPORIG, MCX_VALOR,'#13#10'  MCX_DC, MCX_' +
      'HISTORICO, MCX_MPAG, MCX_ORIG,'#13#10'  MCX_DINHEIRO, MCX_TROCO, MCXOP' +
      '_OID'#13#10'  FROM MCX'#13#10'  WHERE MCX_OID IS NULL'#13#10'  ORDER BY MCX_OID'
    object dsMCX_OID: TStringField
      FieldName = 'MCX_OID'
      ProviderFlags = [pfInUpdate, pfInKey]
      Required = True
      FixedChar = True
      Size = 14
    end
    object dsMCX_DATA: TSQLTimeStampField
      FieldName = 'MCX_DATA'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object dsMCX_TPORIG: TIntegerField
      FieldName = 'MCX_TPORIG'
      ProviderFlags = [pfInUpdate]
    end
    object dsMCX_DC: TIntegerField
      FieldName = 'MCX_DC'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object dsMCX_HISTORICO: TStringField
      FieldName = 'MCX_HISTORICO'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 40
    end
    object dsMCX_MPAG: TIntegerField
      FieldName = 'MCX_MPAG'
      ProviderFlags = [pfInUpdate]
    end
    object dsMCXOP_OID: TStringField
      FieldName = 'MCXOP_OID'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 14
    end
    object dsMCX_VALOR: TFMTBCDField
      FieldName = 'MCX_VALOR'
      ProviderFlags = [pfInUpdate]
      Required = True
      Precision = 9
      Size = 2
    end
    object dsMCX_DINHEIRO: TFMTBCDField
      FieldName = 'MCX_DINHEIRO'
      ProviderFlags = [pfInUpdate]
      Precision = 9
      Size = 2
    end
    object dsMCX_TROCO: TFMTBCDField
      FieldName = 'MCX_TROCO'
      ProviderFlags = [pfInUpdate]
      Precision = 9
      Size = 2
    end
    object dsMCX_ORIG: TStringField
      FieldName = 'MCX_ORIG'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 14
    end
  end
  inherited cds: TClientDataSet
    BeforePost = cdsBeforePost
    object cdsMCX_OID: TStringField
      FieldName = 'MCX_OID'
      Required = True
      FixedChar = True
      Size = 14
    end
    object cdsMCX_DATA: TSQLTimeStampField
      FieldName = 'MCX_DATA'
      Required = True
    end
    object cdsMCX_TPORIG: TIntegerField
      FieldName = 'MCX_TPORIG'
    end
    object cdsMCX_DC: TIntegerField
      FieldName = 'MCX_DC'
      Required = True
    end
    object cdsMCX_HISTORICO: TStringField
      FieldName = 'MCX_HISTORICO'
      Required = True
      Size = 40
    end
    object cdsMCX_MPAG: TIntegerField
      FieldName = 'MCX_MPAG'
    end
    object cdsMCXOP_OID: TStringField
      FieldName = 'MCXOP_OID'
      FixedChar = True
      Size = 14
    end
    object cdsMCX_VALOR: TFMTBCDField
      FieldName = 'MCX_VALOR'
      Required = True
      DisplayFormat = '0.00'
      Precision = 9
      Size = 2
    end
    object cdsMCX_DINHEIRO: TFMTBCDField
      FieldName = 'MCX_DINHEIRO'
      DisplayFormat = '0.00'
      Precision = 9
      Size = 2
    end
    object cdsMCX_TROCO: TFMTBCDField
      FieldName = 'MCX_TROCO'
      DisplayFormat = '0.00'
      Precision = 9
      Size = 2
    end
    object cdsMCX_ORIG: TStringField
      FieldName = 'MCX_ORIG'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 14
    end
  end
  object ds_usr: TSQLDataSet
    Tag = 5
    CommandText = 'SELECT USR_NAME FROM USR ORDER BY USR_NAME'
    MaxBlobSize = -1
    Params = <>
    Left = 128
    Top = 16
    object ds_usrUSR_NAME: TStringField
      FieldName = 'USR_NAME'
      Size = 40
    end
  end
  object dsp_usr: TDataSetProvider
    DataSet = ds_usr
    Options = [poCascadeDeletes, poCascadeUpdates, poAllowMultiRecordUpdates, poAllowCommandText]
    UpdateMode = upWhereKeyOnly
    Left = 128
    Top = 80
  end
  object cds_usr: TClientDataSet
    Tag = 5
    Aggregates = <>
    Params = <>
    ProviderName = 'dsp_usr'
    BeforePost = cdsBeforePost
    Left = 128
    Top = 144
    object cds_usrUSR_NAME: TStringField
      FieldName = 'USR_NAME'
      Size = 40
    end
  end
  object dsr_usr: TDataSource
    DataSet = cds_usr
    Left = 128
    Top = 208
  end
end
