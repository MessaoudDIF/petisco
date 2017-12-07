inherited MovimentoDeContaCorrenteRegistroModelo: TMovimentoDeContaCorrenteRegistroModelo
  OldCreateOrder = True
  Left = 681
  Top = 171
  inherited ds: TSQLDataSet
    CommandText = 
      'SELECT M.CCORMV_OID, M.CCOR_OID, M.CCORMVO_OID, '#13#10'  M.CAT_OID, M' +
      '.CATS_OID, M.CRES_OID, M.CCORMV_ORDER, '#13#10'  M.CCORMV_COMPETENCIA,' +
      ' M.CCORMV_DATA, M.CCORMV_VALOR,'#13#10'  M.CCORMV_DOC, M.CCORMV_HIST, ' +
      #13#10'  M.REC_STT, M.REC_INS, M.REC_UPD, M.REC_DEL,'#13#10'  C.CCOR_DES, O' +
      '.CCORMVO_DES, S.CATS_DES, R.CRES_DES'#13#10'  FROM CCORMV M'#13#10'    INNER' +
      ' JOIN CCOR C ON M.CCOR_OID = C.CCOR_OID'#13#10'    INNER JOIN CCORMVO ' +
      'O ON M.CCORMVO_OID = O.CCORMVO_OID'#13#10'    LEFT JOIN CATS S ON M.CA' +
      'TS_OID = S.CATS_OID'#13#10'    LEFT JOIN CRES R ON M.CRES_OID = R.CRES' +
      '_OID'#13#10'  WHERE M.CCORMV_OID IS NULL'#13#10'  ORDER BY CCORMV_OID'
  end
  inherited cds: TClientDataSet
    BeforePost = cdsBeforePost
  end
  object ds_cat: TSQLDataSet
    Tag = 5
    CommandText = 'SELECT CAT_OID, CAT_DES'#13#10'  FROM CAT'#13#10'  ORDER BY CAT_OID'
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
