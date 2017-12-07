inherited ComandaModelo: TComandaModelo
  OldCreateOrder = True
  Height = 384
  Width = 831
  inherited Sql: TSQLDataSet
    Tag = 10
    MaxBlobSize = -1
    Left = 648
    Top = 48
  end
  inherited ds: TSQLDataSet
    Tag = 10
    CommandText = 
      'SELECT C.COMA_OID, C.CL_OID, C.COMA_COMANDA, C.COMA_DATA,'#13#10'  C.C' +
      'OMA_CONSUMO, C.COMA_SALDO, C.COMA_TOTAL, '#13#10'  C.COMA_STT, C.COMA_' +
      'CLIENTE,'#13#10'  C.COMA_TXSERV, C.COMA_MESA, L.CL_COD'#13#10'  FROM COMA C ' +
      'INNER JOIN CL L ON C.CL_OID = L.CL_OID'#13#10'  WHERE C.COMA_OID IS NU' +
      'LL'
    Top = 48
    object dsCOMA_OID: TStringField
      FieldName = 'COMA_OID'
      ProviderFlags = [pfInUpdate, pfInKey]
      Required = True
      Size = 14
    end
    object dsCL_OID: TStringField
      FieldName = 'CL_OID'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 14
    end
    object dsCOMA_COMANDA: TStringField
      FieldName = 'COMA_COMANDA'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 14
    end
    object dsCOMA_DATA: TSQLTimeStampField
      FieldName = 'COMA_DATA'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object dsCOMA_CONSUMO: TFMTBCDField
      FieldName = 'COMA_CONSUMO'
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
    object dsCOMA_STT: TIntegerField
      FieldName = 'COMA_STT'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object dsCOMA_MESA: TIntegerField
      FieldName = 'COMA_MESA'
      ProviderFlags = [pfInUpdate]
    end
    object dsCOMA_CLIENTE: TStringField
      FieldName = 'COMA_CLIENTE'
      ProviderFlags = [pfInUpdate]
      Size = 128
    end
    object dsCL_COD: TStringField
      FieldName = 'CL_COD'
      ProviderFlags = []
    end
  end
  inherited dsp: TDataSetProvider
    Options = [poCascadeDeletes, poCascadeUpdates, poAllowMultiRecordUpdates, poPropogateChanges, poAllowCommandText]
    Top = 104
  end
  inherited cds: TClientDataSet
    Tag = 10
    Top = 168
    object cdsCOMA_OID: TStringField
      FieldName = 'COMA_OID'
      ProviderFlags = [pfInUpdate, pfInKey]
      Required = True
      Size = 14
    end
    object cdsCL_OID: TStringField
      FieldName = 'CL_OID'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 14
    end
    object cdsCOMA_COMANDA: TStringField
      FieldName = 'COMA_COMANDA'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 14
    end
    object cdsCOMA_DATA: TSQLTimeStampField
      FieldName = 'COMA_DATA'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object cdsCOMA_CONSUMO: TFMTBCDField
      FieldName = 'COMA_CONSUMO'
      ProviderFlags = [pfInUpdate]
      Precision = 9
      Size = 2
    end
    object cdsCOMA_SALDO: TFMTBCDField
      FieldName = 'COMA_SALDO'
      ProviderFlags = [pfInUpdate]
      Precision = 9
      Size = 2
    end
    object cdsCOMA_TOTAL: TFMTBCDField
      FieldName = 'COMA_TOTAL'
      ProviderFlags = [pfInUpdate]
      Required = True
      Precision = 9
      Size = 2
    end
    object cdsCOMA_STT: TIntegerField
      FieldName = 'COMA_STT'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object cdsCOMA_TXSERV: TFMTBCDField
      FieldName = 'COMA_TXSERV'
      ProviderFlags = [pfInUpdate]
      Precision = 9
      Size = 2
    end
    object cdsCOMA_MESA: TIntegerField
      FieldName = 'COMA_MESA'
      ProviderFlags = [pfInUpdate]
    end
    object cdsCOMA_CLIENTE: TStringField
      FieldName = 'COMA_CLIENTE'
      ProviderFlags = [pfInUpdate]
      Size = 128
    end
    object cdsCL_COD: TStringField
      FieldName = 'CL_COD'
      ProviderFlags = []
    end
    object cdsds_comai: TDataSetField
      FieldName = 'ds_comai'
    end
    object cdsds_comap: TDataSetField
      FieldName = 'ds_comap'
    end
  end
  inherited dsr: TDataSource
    Top = 232
  end
  object ds_comai: TSQLDataSet
    Tag = 10
    CommandText = 
      'SELECT I.COMAI_OID, I.COMA_OID, I.PRO_OID, '#13#10'  I.COMAI_UNIT, I.C' +
      'OMAI_QTDE, I.COMAI_TOTAL, I.COMAI_EDT,'#13#10'  P.PRO_COD, P.PRO_DES, ' +
      'P.PRO_VENDA'#13#10'  FROM COMAI I INNER JOIN PRO P ON I.PRO_OID = P.PR' +
      'O_OID'#13#10'  WHERE COMA_OID = :COMA_OID'#13#10'  ORDER BY COMAI_OID'
    DataSource = dsr_coma_comai
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftString
        Name = 'COMA_OID'
        ParamType = ptInput
        Size = 15
      end>
    Left = 128
    Top = 48
    object ds_comaiCOMAI_OID: TStringField
      FieldName = 'COMAI_OID'
      ProviderFlags = [pfInUpdate, pfInKey]
      Required = True
      FixedChar = True
      Size = 14
    end
    object ds_comaiCOMA_OID: TStringField
      FieldName = 'COMA_OID'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 14
    end
    object ds_comaiPRO_OID: TStringField
      FieldName = 'PRO_OID'
      ProviderFlags = [pfInUpdate]
      Required = True
      FixedChar = True
      Size = 14
    end
    object ds_comaiPRO_COD: TStringField
      FieldName = 'PRO_COD'
      ProviderFlags = []
    end
    object ds_comaiPRO_DES: TStringField
      FieldName = 'PRO_DES'
      ProviderFlags = []
      Size = 40
    end
    object ds_comaiCOMAI_EDT: TIntegerField
      FieldName = 'COMAI_EDT'
      ProviderFlags = [pfInUpdate]
    end
    object ds_comaiCOMAI_UNIT: TFMTBCDField
      FieldName = 'COMAI_UNIT'
      ProviderFlags = [pfInUpdate]
      Required = True
      Precision = 9
      Size = 2
    end
    object ds_comaiCOMAI_QTDE: TFMTBCDField
      FieldName = 'COMAI_QTDE'
      ProviderFlags = [pfInUpdate]
      Precision = 9
      Size = 2
    end
    object ds_comaiCOMAI_TOTAL: TFMTBCDField
      FieldName = 'COMAI_TOTAL'
      ProviderFlags = [pfInUpdate]
      Required = True
      Precision = 9
      Size = 2
    end
    object ds_comaiPRO_VENDA: TFMTBCDField
      FieldName = 'PRO_VENDA'
      ProviderFlags = []
      Precision = 9
      Size = 2
    end
  end
  object cds_comai: TClientDataSet
    Aggregates = <>
    AggregatesActive = True
    DataSetField = cdsds_comai
    Params = <>
    Left = 128
    Top = 168
    object cds_comaiCOMAI_OID: TStringField
      FieldName = 'COMAI_OID'
      ProviderFlags = [pfInUpdate, pfInKey]
      Required = True
      Visible = False
      FixedChar = True
      Size = 14
    end
    object cds_comaiCOMA_OID: TStringField
      FieldName = 'COMA_OID'
      ProviderFlags = [pfInUpdate]
      Required = True
      Visible = False
      Size = 14
    end
    object cds_comaiCOMAI_UNIT: TFMTBCDField
      FieldName = 'COMAI_UNIT'
      ProviderFlags = [pfInUpdate]
      Required = True
      Precision = 9
      Size = 2
    end
    object cds_comaiCOMAI_QTDE: TFMTBCDField
      FieldName = 'COMAI_QTDE'
      ProviderFlags = [pfInUpdate]
      Precision = 9
      Size = 2
    end
    object cds_comaiCOMAI_TOTAL: TFMTBCDField
      FieldName = 'COMAI_TOTAL'
      ProviderFlags = [pfInUpdate]
      Required = True
      Precision = 9
      Size = 2
    end
    object cds_comaiPRO_OID: TStringField
      FieldName = 'PRO_OID'
      ProviderFlags = [pfInUpdate]
      Required = True
      Visible = False
      FixedChar = True
      Size = 14
    end
    object cds_comaiPRO_COD: TStringField
      FieldName = 'PRO_COD'
      ProviderFlags = []
      Visible = False
    end
    object cds_comaiPRO_VENDA: TFMTBCDField
      FieldName = 'PRO_VENDA'
      ProviderFlags = []
      Precision = 9
      Size = 2
    end
    object cds_comaiCOMAI_EDT: TIntegerField
      FieldName = 'COMAI_EDT'
      ProviderFlags = [pfInUpdate]
      Visible = False
    end
    object cds_comaiPRO_DES: TStringField
      DisplayLabel = 'Produto'
      DisplayWidth = 30
      FieldName = 'PRO_DES'
      ProviderFlags = []
      Size = 40
    end
    object cds_comaids_comaie: TDataSetField
      FieldName = 'ds_comaie'
    end
    object cds_comaiVALOR_TOTAL: TAggregateField
      Alignment = taRightJustify
      FieldName = 'VALOR_TOTAL'
      ProviderFlags = []
      Visible = True
      Active = True
      DisplayName = ''
      DisplayFormat = '0.00'
      Expression = 'SUM(COMAI_TOTAL)'
    end
    object cds_comaiQTDE_TOTAL: TAggregateField
      DefaultExpression = '0'
      FieldName = 'QTDE_TOTAL'
      ProviderFlags = []
      Visible = True
      Active = True
      currency = True
      DisplayName = ''
      Expression = 'SUM(COMAI_QTDE)'
    end
  end
  object dsr_comai: TDataSource
    DataSet = cds_comai
    Left = 128
    Top = 232
  end
  object dsr_coma_comai: TDataSource
    DataSet = ds
    Left = 128
    Top = 104
  end
  object ds_comap: TSQLDataSet
    Tag = 10
    CommandText = 
      'SELECT COMAP_OID, COMA_OID,  COMAP_DATA,'#13#10'  COMAP_DC, COMAP_HIST' +
      ', COMAP_VALOR'#13#10'  FROM COMAP P'#13#10'  WHERE COMA_OID = :COMA_OID'#13#10'  O' +
      'RDER BY COMAP_OID'
    DataSource = dsr_coma_comap
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftString
        Name = 'COMA_OID'
        ParamType = ptInput
        Size = 15
      end>
    Left = 424
    Top = 48
    object ds_comapCOMAP_OID: TStringField
      FieldName = 'COMAP_OID'
      ProviderFlags = [pfInUpdate, pfInKey]
      Required = True
      FixedChar = True
      Size = 14
    end
    object ds_comapCOMA_OID: TStringField
      FieldName = 'COMA_OID'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 14
    end
    object ds_comapCOMAP_DC: TIntegerField
      FieldName = 'COMAP_DC'
      ProviderFlags = [pfInUpdate]
    end
    object ds_comapCOMAP_HIST: TStringField
      FieldName = 'COMAP_HIST'
      ProviderFlags = [pfInUpdate]
      Size = 50
    end
    object ds_comapCOMAP_DATA: TSQLTimeStampField
      FieldName = 'COMAP_DATA'
      ProviderFlags = [pfInUpdate]
    end
    object ds_comapCOMAP_VALOR: TFMTBCDField
      FieldName = 'COMAP_VALOR'
      ProviderFlags = [pfInUpdate]
      Precision = 9
      Size = 2
    end
  end
  object cds_comap: TClientDataSet
    Aggregates = <>
    AggregatesActive = True
    DataSetField = cdsds_comap
    Params = <>
    Left = 424
    Top = 168
    object cds_comapCOMAP_OID: TStringField
      FieldName = 'COMAP_OID'
      ProviderFlags = [pfInUpdate, pfInKey]
      Required = True
      Visible = False
      FixedChar = True
      Size = 14
    end
    object cds_comapCOMA_OID: TStringField
      FieldName = 'COMA_OID'
      ProviderFlags = [pfInUpdate]
      Visible = False
      FixedChar = True
      Size = 14
    end
    object cds_comapCOMAP_DC: TIntegerField
      FieldName = 'COMAP_DC'
      ProviderFlags = [pfInUpdate]
      Visible = False
    end
    object cds_comapCOMAP_DATA: TSQLTimeStampField
      DisplayLabel = 'Data/Hora'
      DisplayWidth = 18
      FieldName = 'COMAP_DATA'
      ProviderFlags = [pfInUpdate]
      Visible = False
    end
    object cds_comapCOMAP_HIST: TStringField
      DisplayLabel = 'Pagamento'
      DisplayWidth = 43
      FieldName = 'COMAP_HIST'
      ProviderFlags = [pfInUpdate]
      Size = 50
    end
    object cds_comapCOMAP_VALOR: TFMTBCDField
      FieldName = 'COMAP_VALOR'
      ProviderFlags = [pfInUpdate]
      Precision = 9
      Size = 2
    end
    object cds_comapds_mcx: TDataSetField
      FieldName = 'ds_mcx'
      Visible = False
    end
    object cds_comapVALOR_TOTAL: TAggregateField
      FieldName = 'VALOR_TOTAL'
      ProviderFlags = []
      Active = True
      currency = True
      DisplayName = ''
      Expression = 'SUM(COMAP_VALOR)'
    end
  end
  object dsr_comap: TDataSource
    DataSet = cds_comap
    Left = 424
    Top = 232
  end
  object dsr_coma_comap: TDataSource
    DataSet = ds
    Left = 424
    Top = 104
  end
  object cds_mcx: TClientDataSet
    Aggregates = <>
    DataSetField = cds_comapds_mcx
    Params = <>
    Left = 544
    Top = 168
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
      ProviderFlags = [pfInUpdate]
      Visible = False
      Precision = 9
      Size = 2
    end
    object cds_mcxMCX_TROCO: TFMTBCDField
      FieldName = 'MCX_TROCO'
      ProviderFlags = [pfInUpdate]
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
      ProviderFlags = [pfInUpdate]
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
  end
  object dsr_mcx: TDataSource
    DataSet = cds_mcx
    Left = 544
    Top = 232
  end
  object dsr_comap_mcx: TDataSource
    DataSet = ds_comap
    Left = 544
    Top = 104
  end
  object ds_mcx: TSQLDataSet
    Tag = 10
    CommandText = 
      'SELECT MCX_OID, MCX_DATA, MCX_TPORIG, MCX_ORIG,'#13#10'  MCX_VALOR, MC' +
      'XOP_OID, MCX_DC, MCX_HISTORICO, MCX_MPAG,'#13#10'  CART_OID, MCX_DINHE' +
      'IRO, MCX_TROCO'#13#10'  FROM MCX'#13#10'  WHERE MCX_TPORIG = 0 AND MCX_ORIG ' +
      '= :COMAP_OID'#13#10'  ORDER BY MCX_OID'
    DataSource = dsr_comap_mcx
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftFixedChar
        Name = 'COMAP_OID'
        ParamType = ptInput
        Size = 15
      end>
    Left = 544
    Top = 48
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
  object cds_comaie: TClientDataSet
    Aggregates = <>
    AggregatesActive = True
    DataSetField = cds_comaids_comaie
    Params = <>
    BeforePost = cds_comaieBeforePost
    Left = 216
    Top = 168
    object cds_comaieCOMAIE_OID: TStringField
      FieldName = 'COMAIE_OID'
      ProviderFlags = [pfInUpdate, pfInKey]
      Required = True
      FixedChar = True
      Size = 14
    end
    object cds_comaieCOMAI_OID: TStringField
      FieldName = 'COMAI_OID'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 14
    end
    object cds_comaiePROCOM_OID: TStringField
      FieldName = 'PROCOM_OID'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 14
    end
    object cds_comaieCOMAIE_EXCL_INCL: TIntegerField
      FieldName = 'COMAIE_EXCL_INCL'
      ProviderFlags = [pfInUpdate]
    end
    object cds_comaieCOMAIE_DES: TStringField
      FieldName = 'COMAIE_DES'
      ProviderFlags = [pfInUpdate]
      Size = 40
    end
    object cds_comaieCOMAIE_VALOR: TFMTBCDField
      FieldName = 'COMAIE_VALOR'
      ProviderFlags = [pfInUpdate]
      Precision = 9
      Size = 2
    end
    object cds_comaieTOTAL: TAggregateField
      FieldName = 'TOTAL'
      Visible = True
      Active = True
      DisplayName = ''
      Expression = 'SUM(COMAIE_VALOR)'
    end
  end
  object dsr_comaie: TDataSource
    DataSet = cds_comaie
    Left = 216
    Top = 232
  end
  object dsr_comai_comaie: TDataSource
    DataSet = ds_comai
    Left = 216
    Top = 104
  end
  object ds_ingredientes: TSQLDataSet
    Tag = 10
    CommandText = 
      'SELECT 0 SITUACAO, PROCOM_OID, PROCOM_DES'#13#10'  FROM PROCOM'#13#10'  WHER' +
      'E PROCOM_OID IS NULL'#13#10'  ORDER BY PROCOM_OID'
    MaxBlobSize = -1
    Params = <>
    Left = 328
    Top = 48
    object ds_ingredientesPROCOM_OID: TStringField
      FieldName = 'PROCOM_OID'
      Required = True
      Visible = False
      FixedChar = True
      Size = 14
    end
    object ds_ingredientesSITUACAO: TIntegerField
      FieldName = 'SITUACAO'
      Required = True
    end
    object ds_ingredientesPROCOM_DES: TStringField
      FieldName = 'PROCOM_DES'
      Size = 40
    end
  end
  object dsp_ingredientes: TDataSetProvider
    DataSet = ds_ingredientes
    Options = [poCascadeDeletes, poCascadeUpdates, poAllowMultiRecordUpdates, poPropogateChanges, poAllowCommandText]
    UpdateMode = upWhereKeyOnly
    Left = 328
    Top = 104
  end
  object cds_ingredientes: TClientDataSet
    Tag = 10
    Aggregates = <>
    Params = <>
    ProviderName = 'dsp_ingredientes'
    Left = 328
    Top = 168
    object cds_ingredientesPROCOM_OID: TStringField
      FieldName = 'PROCOM_OID'
      Required = True
      Visible = False
      FixedChar = True
      Size = 14
    end
    object cds_ingredientesSITUACAO: TIntegerField
      DisplayWidth = 5
      FieldName = 'SITUACAO'
      Required = True
      Visible = False
    end
    object cds_ingredientesPROCOM_DES: TStringField
      DisplayLabel = 'Ingrediente'
      DisplayWidth = 60
      FieldName = 'PROCOM_DES'
      Size = 40
    end
  end
  object dsr_ingredientes: TDataSource
    DataSet = cds_ingredientes
    Left = 328
    Top = 232
  end
  object ds_comaie: TSQLDataSet
    Tag = 10
    CommandText = 
      'SELECT COMAIE_OID, COMAI_OID, PROCOM_OID, '#13#10'  COMAIE_EXCL_INCL, ' +
      'COMAIE_DES, COMAIE_VALOR'#13#10'  FROM COMAIE'#13#10'  WHERE COMAI_OID = :CO' +
      'MAI_OID'#13#10'  ORDER BY COMAIE_OID'
    DataSource = dsr_comai_comaie
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftFixedChar
        Name = 'COMAI_OID'
        ParamType = ptInput
        Size = 15
      end>
    Left = 216
    Top = 48
    object ds_comaieCOMAIE_OID: TStringField
      FieldName = 'COMAIE_OID'
      ProviderFlags = [pfInUpdate, pfInKey]
      Required = True
      FixedChar = True
      Size = 14
    end
    object ds_comaieCOMAI_OID: TStringField
      FieldName = 'COMAI_OID'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 14
    end
    object ds_comaiePROCOM_OID: TStringField
      FieldName = 'PROCOM_OID'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 14
    end
    object ds_comaieCOMAIE_EXCL_INCL: TIntegerField
      FieldName = 'COMAIE_EXCL_INCL'
      ProviderFlags = [pfInUpdate]
    end
    object ds_comaieCOMAIE_DES: TStringField
      FieldName = 'COMAIE_DES'
      ProviderFlags = [pfInUpdate]
      Size = 40
    end
    object ds_comaieCOMAIE_VALOR: TFMTBCDField
      FieldName = 'COMAIE_VALOR'
      ProviderFlags = [pfInUpdate]
      Precision = 9
      Size = 2
    end
  end
end
