inherited FechamentoDeContaModelo: TFechamentoDeContaModelo
  OldCreateOrder = True
  Height = 278
  Width = 697
  inherited ds: TSQLDataSet
    CommandText = 
      'SELECT C.COMA_OID, C.COMA_DATA, C.COMA_COMANDA, '#13#10'  C.COMA_CONSU' +
      'MO, C.COMA_TXSERV, C.COMA_TOTAL,'#13#10'  C.COMA_SALDO, C.COMA_STT, L.' +
      'CL_COD'#13#10'  FROM COMA C INNER JOIN CL L ON C.CL_OID = L.CL_OID'#13#10'  ' +
      'WHERE C.COMA_OID IS NULL'#13#10'  ORDER BY C.COMA_DATA'
    object dsCOMA_OID: TStringField
      FieldName = 'COMA_OID'
      ProviderFlags = [pfInUpdate, pfInKey]
      Required = True
      Size = 14
    end
    object dsCOMA_DATA: TSQLTimeStampField
      FieldName = 'COMA_DATA'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object dsCOMA_COMANDA: TStringField
      FieldName = 'COMA_COMANDA'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 14
    end
    object dsCOMA_CONSUMO: TFMTBCDField
      FieldName = 'COMA_CONSUMO'
      ProviderFlags = [pfInUpdate]
      Precision = 9
      Size = 2
    end
    object dsCOMA_TOTAL: TFMTBCDField
      FieldName = 'COMA_TOTAL'
      ProviderFlags = [pfInUpdate]
      Required = True
      Precision = 9
      Size = 2
    end
    object dsCOMA_TXSERV: TFMTBCDField
      FieldName = 'COMA_TXSERV'
      ProviderFlags = [pfInUpdate]
      Precision = 9
      Size = 2
    end
    object dsCOMA_SALDO: TFMTBCDField
      FieldName = 'COMA_SALDO'
      ProviderFlags = [pfInUpdate]
      Precision = 9
      Size = 2
    end
    object dsCOMA_STT: TIntegerField
      FieldName = 'COMA_STT'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object dsCL_COD: TStringField
      FieldName = 'CL_COD'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
  end
  inherited cds: TClientDataSet
    Tag = 10
    AggregatesActive = True
    Left = 36
    object cdsCOMA_OID: TStringField
      FieldName = 'COMA_OID'
      ProviderFlags = [pfInUpdate, pfInKey]
      Required = True
      Visible = False
      Size = 14
    end
    object cdsCL_COD: TStringField
      FieldName = 'CL_COD'
      ProviderFlags = [pfInUpdate]
      Required = True
      Visible = False
    end
    object cdsCOMA_DATA: TSQLTimeStampField
      DisplayLabel = 'Data'
      DisplayWidth = 10
      FieldName = 'COMA_DATA'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object cdsCOMA_COMANDA: TStringField
      DisplayLabel = 'Comanda'
      DisplayWidth = 10
      FieldName = 'COMA_COMANDA'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 14
    end
    object cdsCOMA_CONSUMO: TFMTBCDField
      DisplayLabel = 'Consumo'
      FieldName = 'COMA_CONSUMO'
      DisplayFormat = '0.00'
      Precision = 9
      Size = 2
    end
    object cdsCOMA_TXSERV: TFMTBCDField
      DisplayLabel = 'Tx.Servi'#231'o'
      FieldName = 'COMA_TXSERV'
      DisplayFormat = '0.00'
      Precision = 9
      Size = 2
    end
    object cdsCOMA_TOTAL: TFMTBCDField
      DisplayLabel = 'Valor Total'
      FieldName = 'COMA_TOTAL'
      Required = True
      DisplayFormat = '0.00'
      Precision = 9
      Size = 2
    end
    object cdsCOMA_SALDO: TFMTBCDField
      DisplayLabel = 'Saldo'
      FieldName = 'COMA_SALDO'
      DisplayFormat = '0.00'
      Precision = 9
      Size = 2
    end
    object cdsCOMA_STT: TIntegerField
      FieldName = 'COMA_STT'
      Required = True
    end
    object cdsSALDO_TOTAL: TAggregateField
      FieldName = 'SALDO_TOTAL'
      Visible = True
      Active = True
      DisplayName = ''
      Expression = 'SUM(COMA_SALDO)'
    end
  end
  object cds_mcx: TClientDataSet
    Tag = 10
    Aggregates = <>
    AggregatesActive = True
    Params = <>
    ProviderName = 'dsp_mcx'
    Left = 112
    Top = 144
    object cds_mcxMCX_OID: TStringField
      FieldName = 'MCX_OID'
      ProviderFlags = [pfInUpdate, pfInKey]
      Required = True
      Visible = False
      FixedChar = True
      Size = 14
    end
    object cds_mcxMCX_TPORIG: TIntegerField
      FieldName = 'MCX_TPORIG'
      ProviderFlags = [pfInUpdate]
      Visible = False
    end
    object cds_mcxMCX_ORIG: TStringField
      FieldName = 'MCX_ORIG'
      ProviderFlags = [pfInUpdate]
      Visible = False
      FixedChar = True
      Size = 14
    end
    object cds_mcxMCXOP_OID: TStringField
      FieldName = 'MCXOP_OID'
      ProviderFlags = [pfInUpdate]
      Visible = False
      FixedChar = True
      Size = 14
    end
    object cds_mcxMCX_DC: TIntegerField
      FieldName = 'MCX_DC'
      ProviderFlags = [pfInUpdate]
      Required = True
      Visible = False
    end
    object cds_mcxMCX_MPAG: TIntegerField
      FieldName = 'MCX_MPAG'
      ProviderFlags = [pfInUpdate]
      Visible = False
    end
    object cds_mcxCART_OID: TStringField
      FieldName = 'CART_OID'
      ProviderFlags = [pfInUpdate]
      Visible = False
      FixedChar = True
      Size = 14
    end
    object cds_mcxMCX_DINHEIRO: TFMTBCDField
      FieldName = 'MCX_DINHEIRO'
      Visible = False
      Precision = 9
      Size = 2
    end
    object cds_mcxMCX_TROCO: TFMTBCDField
      FieldName = 'MCX_TROCO'
      Visible = False
      Precision = 9
      Size = 2
    end
    object cds_mcxMCX_DATA: TSQLTimeStampField
      DisplayLabel = 'Data'
      DisplayWidth = 10
      FieldName = 'MCX_DATA'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object cds_mcxMCX_VALOR: TFMTBCDField
      DisplayLabel = 'Valor'
      FieldName = 'MCX_VALOR'
      Required = True
      DisplayFormat = '0.00'
      Precision = 9
      Size = 2
    end
    object cds_mcxMCX_HISTORICO: TStringField
      DisplayLabel = 'Hist'#243'rico'
      FieldName = 'MCX_HISTORICO'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 40
    end
    object cds_mcxTOTAL: TAggregateField
      FieldName = 'TOTAL'
      Visible = True
      Active = True
      currency = True
      DisplayName = ''
      DisplayFormat = '0.00'
      Expression = 'SUM(MCX_VALOR)'
    end
  end
  object dsr_mcx: TDataSource
    DataSet = cds_mcx
    Left = 112
    Top = 208
  end
  object ds_mcx: TSQLDataSet
    Tag = 10
    CommandText = 
      'SELECT MCX_OID, MCX_DATA, MCX_TPORIG, MCX_ORIG,'#13#10'  MCX_VALOR, MC' +
      'XOP_OID, MCX_DC, MCX_HISTORICO, MCX_MPAG,'#13#10'  CART_OID, MCX_DINHE' +
      'IRO, MCX_TROCO'#13#10'  FROM MCX'#13#10'  WHERE MCX_TPORIG = 0 AND MCX_ORIG ' +
      '= :COMAP_OID'#13#10'  ORDER BY MCX_OID'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftFixedChar
        Name = 'COMAP_OID'
        ParamType = ptInput
        Size = 15
      end>
    Left = 112
    Top = 16
    object ds_mcxMCX_OID: TStringField
      FieldName = 'MCX_OID'
      ProviderFlags = [pfInUpdate, pfInKey]
      Required = True
      FixedChar = True
      Size = 14
    end
    object ds_mcxMCX_DATA: TSQLTimeStampField
      FieldName = 'MCX_DATA'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object ds_mcxMCX_TPORIG: TIntegerField
      FieldName = 'MCX_TPORIG'
      ProviderFlags = [pfInUpdate]
    end
    object ds_mcxMCX_ORIG: TStringField
      FieldName = 'MCX_ORIG'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 14
    end
    object ds_mcxMCXOP_OID: TStringField
      FieldName = 'MCXOP_OID'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 14
    end
    object ds_mcxMCX_DC: TIntegerField
      FieldName = 'MCX_DC'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object ds_mcxMCX_HISTORICO: TStringField
      FieldName = 'MCX_HISTORICO'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 40
    end
    object ds_mcxMCX_MPAG: TIntegerField
      FieldName = 'MCX_MPAG'
      ProviderFlags = [pfInUpdate]
    end
    object ds_mcxCART_OID: TStringField
      FieldName = 'CART_OID'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 14
    end
    object ds_mcxMCX_VALOR: TFMTBCDField
      FieldName = 'MCX_VALOR'
      ProviderFlags = [pfInUpdate]
      Required = True
      Precision = 9
      Size = 2
    end
    object ds_mcxMCX_DINHEIRO: TFMTBCDField
      FieldName = 'MCX_DINHEIRO'
      ProviderFlags = [pfInUpdate]
      Precision = 9
      Size = 2
    end
    object ds_mcxMCX_TROCO: TFMTBCDField
      FieldName = 'MCX_TROCO'
      ProviderFlags = [pfInUpdate]
      Precision = 9
      Size = 2
    end
  end
  object dsp_mcx: TDataSetProvider
    DataSet = ds_mcx
    Options = [poCascadeDeletes, poCascadeUpdates, poAllowMultiRecordUpdates, poAllowCommandText]
    UpdateMode = upWhereKeyOnly
    Left = 112
    Top = 80
  end
  object cds_detalhe: TClientDataSet
    Tag = 10
    Aggregates = <>
    AggregatesActive = True
    Params = <>
    ProviderName = 'dsp_detalhe'
    Left = 200
    Top = 144
    object cds_detalheCOMAI_QTDE: TFMTBCDField
      DisplayLabel = 'Qtde.'
      FieldName = 'COMAI_QTDE'
      Precision = 9
      Size = 2
    end
    object cds_detalhePRO_DES: TStringField
      DisplayLabel = 'Produto'
      DisplayWidth = 30
      FieldName = 'PRO_DES'
      Required = True
      Size = 40
    end
    object cds_detalheCOMAI_UNIT: TFMTBCDField
      DisplayLabel = 'Valor Unit'#225'rio'
      FieldName = 'COMAI_UNIT'
      Required = True
      DisplayFormat = '0.00'
      Precision = 9
      Size = 2
    end
    object cds_detalheCOMAI_TOTAL: TFMTBCDField
      DisplayLabel = 'Valor Total'
      FieldName = 'COMAI_TOTAL'
      Required = True
      DisplayFormat = '0.00'
      Precision = 9
      Size = 2
    end
    object cds_detalhetotal: TAggregateField
      FieldName = 'total'
      Active = True
      DisplayName = ''
      Expression = 'sum(comai_total)'
    end
  end
  object dsr_detalhe: TDataSource
    DataSet = cds_detalhe
    Left = 200
    Top = 208
  end
  object ds_detalhe: TSQLDataSet
    Tag = 10
    CommandText = 
      'SELECT I.COMAI_QTDE, P.PRO_DES, I.COMAI_UNIT, I.COMAI_TOTAL'#13#10'  F' +
      'ROM COMAI I INNER JOIN PRO P ON I.PRO_OID = P.PRO_OID'#13#10'  WHERE C' +
      'OMA_OID IS NULL'#13#10'  ORDER BY COMAI_OID'
    MaxBlobSize = -1
    Params = <>
    Left = 200
    Top = 16
    object ds_detalheCOMAI_QTDE: TFMTBCDField
      FieldName = 'COMAI_QTDE'
      Precision = 9
      Size = 2
    end
    object ds_detalhePRO_DES: TStringField
      FieldName = 'PRO_DES'
      Required = True
      Size = 40
    end
    object ds_detalheCOMAI_UNIT: TFMTBCDField
      FieldName = 'COMAI_UNIT'
      Required = True
      Precision = 9
      Size = 2
    end
    object ds_detalheCOMAI_TOTAL: TFMTBCDField
      FieldName = 'COMAI_TOTAL'
      Required = True
      Precision = 9
      Size = 2
    end
  end
  object dsp_detalhe: TDataSetProvider
    DataSet = ds_detalhe
    Options = [poCascadeDeletes, poCascadeUpdates, poAllowMultiRecordUpdates, poAllowCommandText]
    UpdateMode = upWhereKeyOnly
    Left = 200
    Top = 80
  end
end
