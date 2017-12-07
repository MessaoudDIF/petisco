inherited FornecedorRegistroModelo: TFornecedorRegistroModelo
  OldCreateOrder = True
  inherited ds: TSQLDataSet
    CommandText = 
      'SELECT FORN_OID, FORN_COD, FORN_NOME, FORN_FONE,'#13#10'  FORN_ENDER, ' +
      'FORN_BAIRRO, FORN_CIDADE, FORN_UF, '#13#10'  FORN_CEP, FORN_IERG, FORN' +
      '_CNPJCPF,'#13#10'  REC_STT, REC_INS, REC_UPD, REC_DEL'#13#10'  FROM FORN'#13#10'  ' +
      'WHERE FORN_OID IS NULL'#13#10'  ORDER BY FORN_OID'
  end
  inherited cds: TClientDataSet
    BeforePost = cdsBeforePost
  end
  object ds_fornp: TSQLDataSet
    Tag = 5
    CommandText = 
      'SELECT FORNP_OID, FORN_OID, PRO_OID, '#13#10'  FORNP_DES, FORNP_QTDE, ' +
      'FORNP_DATA, FORNP_UNIT,'#13#10'  FORNP_TOTAL'#13#10'  FROM FORNP'#13#10'  WHERE FO' +
      'RNP_OID IS NULL'#13#10'  ORDER BY FORNP_DES'
    MaxBlobSize = -1
    Params = <>
    Left = 128
    Top = 16
    object ds_fornpFORNP_OID: TStringField
      FieldName = 'FORNP_OID'
      ProviderFlags = [pfInUpdate, pfInKey]
      Required = True
      FixedChar = True
      Size = 14
    end
    object ds_fornpFORN_OID: TStringField
      FieldName = 'FORN_OID'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 14
    end
    object ds_fornpPRO_OID: TStringField
      FieldName = 'PRO_OID'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 14
    end
    object ds_fornpFORNP_DES: TStringField
      FieldName = 'FORNP_DES'
      ProviderFlags = [pfInUpdate]
      Size = 128
    end
    object ds_fornpFORNP_QTDE: TIntegerField
      FieldName = 'FORNP_QTDE'
      ProviderFlags = [pfInUpdate]
    end
    object ds_fornpFORNP_DATA: TDateField
      FieldName = 'FORNP_DATA'
      ProviderFlags = [pfInUpdate]
    end
    object ds_fornpFORNP_UNIT: TFMTBCDField
      FieldName = 'FORNP_UNIT'
      ProviderFlags = [pfInUpdate]
      Precision = 9
      Size = 2
    end
    object ds_fornpFORNP_TOTAL: TFMTBCDField
      FieldName = 'FORNP_TOTAL'
      ProviderFlags = [pfInUpdate]
      Precision = 9
      Size = 2
    end
  end
  object dsp_fornp: TDataSetProvider
    DataSet = ds_fornp
    Options = [poCascadeDeletes, poCascadeUpdates, poAllowMultiRecordUpdates, poAllowCommandText]
    UpdateMode = upWhereKeyOnly
    Left = 128
    Top = 80
  end
  object cds_fornp: TClientDataSet
    Tag = 5
    Aggregates = <>
    Params = <>
    ProviderName = 'dsp_fornp'
    BeforePost = cds_fornpBeforePost
    Left = 128
    Top = 144
    object cds_fornpFORNP_OID: TStringField
      FieldName = 'FORNP_OID'
      Required = True
      Visible = False
      FixedChar = True
      Size = 14
    end
    object cds_fornpFORN_OID: TStringField
      FieldName = 'FORN_OID'
      Visible = False
      FixedChar = True
      Size = 14
    end
    object cds_fornpPRO_OID: TStringField
      FieldName = 'PRO_OID'
      Visible = False
      FixedChar = True
      Size = 14
    end
    object cds_fornpFORNP_DATA: TDateField
      DisplayLabel = 'Data'
      DisplayWidth = 18
      FieldName = 'FORNP_DATA'
    end
    object cds_fornpFORNP_DES: TStringField
      DisplayLabel = 'Produto'
      DisplayWidth = 32
      FieldName = 'FORNP_DES'
      Size = 128
    end
    object cds_fornpFORNP_QTDE: TIntegerField
      DisplayLabel = 'Quantidade'
      DisplayWidth = 11
      FieldName = 'FORNP_QTDE'
    end
    object cds_fornpFORNP_UNIT: TFMTBCDField
      DisplayLabel = 'Val.Unit'#225'rio'
      DisplayWidth = 11
      FieldName = 'FORNP_UNIT'
      DisplayFormat = '0.00'
      Precision = 9
      Size = 2
    end
    object cds_fornpFORNP_TOTAL: TFMTBCDField
      DisplayLabel = 'Val.Total'
      DisplayWidth = 11
      FieldName = 'FORNP_TOTAL'
      DisplayFormat = '0.00'
      Precision = 9
      Size = 2
    end
  end
  object dsr_fornp: TDataSource
    DataSet = cds_fornp
    Left = 128
    Top = 208
  end
end
