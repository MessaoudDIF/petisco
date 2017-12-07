inherited ContasReceberRegistroModelo: TContasReceberRegistroModelo
  OldCreateOrder = True
  inherited ds: TSQLDataSet
    CommandText = 
      'SELECT T.TITR_OID, T.CL_OID, T.CATS_OID, T.CRES_OID, '#13#10'  T.TITR_' +
      'DOC, T.TITR_EMIS, T.TITR_VENC, T.TITR_VALOR, '#13#10'  T.TITR_HIST, T.' +
      'TITR_LIQ, T.TITR_PAGO, L.CL_NOME, '#13#10'  C.CATS_DES, R.CRES_DES, T.' +
      'CAT_OID, T.REC_STT, T.REC_INS, '#13#10'  T.REC_UPD, T.REC_DEL'#13#10'  FROM ' +
      'TITR T INNER JOIN CL L ON T.CL_OID = L.CL_OID '#13#10'    INNER JOIN C' +
      'ATS C ON T.CATS_OID = C.CATS_OID '#13#10'    LEFT JOIN CRES R ON T.CRE' +
      'S_OID = R.CRES_OID'#13#10'  WHERE T.TITR_OID IS NULL'#13#10'  ORDER BY T.TIT' +
      'R_OID'
  end
  inherited cds: TClientDataSet
    AfterInsert = cdsAfterInsert
    BeforePost = cdsBeforePost
  end
  object ds_cat: TSQLDataSet
    Tag = 5
    CommandText = 
      'SELECT CAT_OID, CAT_DES'#13#10'  FROM CAT'#13#10'  WHERE CAT_TIPO = 0 ORDER ' +
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
