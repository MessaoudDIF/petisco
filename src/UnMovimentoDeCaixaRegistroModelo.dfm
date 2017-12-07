inherited MovimentoDeCaixaRegistroModelo: TMovimentoDeCaixaRegistroModelo
  OldCreateOrder = True
  inherited ds: TSQLDataSet
    CommandText = 
      'SELECT M.CXMV_OID, M.CXMVO_OID, M.CAT_OID, M.CATS_OID, '#13#10'  M.CRE' +
      'S_OID, M.CXMV_ORDER, M.CXMV_COMPETENCIA, '#13#10'  M.CXMV_DATA, M.CXMV' +
      '_VALOR, M.CXMV_DOC, M.CXMV_HIST, '#13#10'  M.REC_STT, M.REC_INS, M.REC' +
      '_UPD, M.REC_DEL, '#13#10'  O.CXMVO_DES, S.CATS_DES, R.CRES_DES'#13#10'  FROM' +
      ' CXMV M '#13#10'    INNER JOIN CXMVO O ON M.CXMVO_OID = O.CXMVO_OID '#13#10 +
      '    LEFT JOIN CATS S ON M.CATS_OID = S.CATS_OID '#13#10'    LEFT JOIN ' +
      'CRES R ON M.CRES_OID = R.CRES_OID'#13#10'  WHERE M.CXMV_OID IS NULL'#13#10' ' +
      ' ORDER BY M.CXMV_OID'
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
