inherited ContasPagarRegistroModelo: TContasPagarRegistroModelo
  OldCreateOrder = True
  inherited ds: TSQLDataSet
    CommandText = 
      'SELECT T.TIT_OID, T.FORN_OID, T.CATS_OID, T.CRES_OID, '#13#10'  T.TIT_' +
      'DOC,  T.TIT_EMIS, T.TIT_VENC, T.TIT_VALOR, '#13#10'  T.TIT_HIST, T.TIT' +
      '_LIQ,  T.TIT_PAGO, F.FORN_NOME, '#13#10'  C.CATS_DES, R.CRES_DES,  T.C' +
      'AT_OID,'#13#10'  T.REC_STT, T.REC_INS, T.REC_UPD, T.REC_DEL'#13#10'  FROM TI' +
      'T T INNER JOIN FORN F ON T.FORN_OID = F.FORN_OID'#13#10'    INNER JOIN' +
      ' CATS C ON T.CATS_OID = C.CATS_OID'#13#10'    LEFT JOIN CRES R ON T.CR' +
      'ES_OID = R.CRES_OID'#13#10'  WHERE T.TIT_OID IS NULL'#13#10'  ORDER BY T.TIT' +
      '_OID'
  end
  inherited cds: TClientDataSet
    BeforePost = cdsBeforePost
  end
  object ds_cat: TSQLDataSet
    Tag = 5
    CommandText = 
      'SELECT CAT_OID, CAT_DES'#13#10'  FROM CAT'#13#10'  WHERE CAT_TIPO = 1 ORDER ' +
      'BY CAT_DES'
    MaxBlobSize = -1
    Params = <>
    Left = 128
    Top = 16
    object ds_catCAT_OID: TStringField
      FieldName = 'CAT_OID'
      Required = True
      FixedChar = True
      Size = 14
    end
    object ds_catCAT_DES: TStringField
      FieldName = 'CAT_DES'
      Size = 50
    end
  end
  object dsp_cat: TDataSetProvider
    DataSet = ds_cat
    Options = [poCascadeDeletes, poCascadeUpdates, poAllowMultiRecordUpdates, poAllowCommandText]
    UpdateMode = upWhereKeyOnly
    Left = 128
    Top = 80
  end
  object cds_cat: TClientDataSet
    Tag = 5
    Aggregates = <>
    Params = <>
    ProviderName = 'dsp_cat'
    BeforePost = cdsBeforePost
    Left = 128
    Top = 144
    object cds_catCAT_OID: TStringField
      FieldName = 'CAT_OID'
      Required = True
      Visible = False
      FixedChar = True
      Size = 14
    end
    object cds_catCAT_DES: TStringField
      DisplayLabel = 'Tipo de Despesa'
      FieldName = 'CAT_DES'
      Size = 50
    end
  end
  object dsr_cat: TDataSource
    DataSet = cds_cat
    Left = 128
    Top = 208
  end
end
