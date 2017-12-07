object ComandaModelo: TComandaModelo
  OldCreateOrder = True
  Height = 347
  Width = 933
  object ds_coma: TSQLDataSet
    CommandText = 
      'select c.coma_oid, c.cl_oid, c.coma_comanda, c.coma_data, '#13#10'  c.' +
      'coma_consumo, c.coma_saldo, c.coma_total, c.coma_stt,'#13#10'  c.coma_' +
      'txserv, c.coma_mesa, l.cl_cod'#13#10'  from coma c inner join cl l on ' +
      'c.cl_oid = l.cl_oid'#13#10'  where c.coma_oid is null'
    MaxBlobSize = -1
    Params = <>
    SQLConnection = cnn
    Left = 24
    Top = 72
    object ds_comaCOMA_OID: TStringField
      FieldName = 'COMA_OID'
      ProviderFlags = [pfInUpdate, pfInKey]
      Required = True
      Size = 14
    end
    object ds_comaCL_OID: TStringField
      FieldName = 'CL_OID'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 14
    end
    object ds_comaCOMA_COMANDA: TStringField
      FieldName = 'COMA_COMANDA'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 14
    end
    object ds_comaCOMA_DATA: TSQLTimeStampField
      FieldName = 'COMA_DATA'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object ds_comaCOMA_TOTAL: TFMTBCDField
      FieldName = 'COMA_TOTAL'
      ProviderFlags = [pfInUpdate]
      Precision = 9
      Size = 2
    end
    object ds_comaCOMA_STT: TIntegerField
      FieldName = 'COMA_STT'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object ds_comaCOMA_CONSUMO: TFMTBCDField
      FieldName = 'COMA_CONSUMO'
      ProviderFlags = [pfInUpdate]
      Precision = 9
      Size = 2
    end
    object ds_comaCOMA_SALDO: TFMTBCDField
      FieldName = 'COMA_SALDO'
      ProviderFlags = [pfInUpdate]
      Precision = 9
      Size = 2
    end
    object ds_comaCOMA_TXSERV: TFMTBCDField
      FieldName = 'COMA_TXSERV'
      ProviderFlags = [pfInUpdate]
      Precision = 9
      Size = 2
    end
    object ds_comaCOMA_MESA: TIntegerField
      FieldName = 'COMA_MESA'
      ProviderFlags = [pfInUpdate]
    end
    object ds_comaCL_COD: TStringField
      FieldName = 'CL_COD'
    end
  end
  object dsp_coma: TDataSetProvider
    DataSet = ds_coma
    Options = [poCascadeDeletes, poCascadeUpdates, poAllowMultiRecordUpdates, poAllowCommandText]
    UpdateMode = upWhereKeyOnly
    Left = 24
    Top = 136
  end
  object cds_coma: TClientDataSet
    Tag = 5
    Aggregates = <>
    Params = <>
    ProviderName = 'dsp_coma'
    Left = 24
    Top = 200
    object cds_comaCOMA_OID: TStringField
      FieldName = 'COMA_OID'
      ProviderFlags = [pfInUpdate, pfInKey]
      Required = True
      Size = 14
    end
    object cds_comaCL_OID: TStringField
      FieldName = 'CL_OID'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 14
    end
    object cds_comaCOMA_COMANDA: TStringField
      FieldName = 'COMA_COMANDA'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 14
    end
    object cds_comaCOMA_DATA: TSQLTimeStampField
      FieldName = 'COMA_DATA'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object cds_comaCOMA_TOTAL: TFMTBCDField
      FieldName = 'COMA_TOTAL'
      ProviderFlags = [pfInUpdate]
      Precision = 9
      Size = 2
    end
    object cds_comaCOMA_STT: TIntegerField
      FieldName = 'COMA_STT'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object cds_comaCOMA_CONSUMO: TFMTBCDField
      FieldName = 'COMA_CONSUMO'
      ProviderFlags = [pfInUpdate]
      Precision = 9
      Size = 2
    end
    object cds_comaCOMA_SALDO: TFMTBCDField
      FieldName = 'COMA_SALDO'
      ProviderFlags = [pfInUpdate]
      Precision = 9
      Size = 2
    end
    object cds_comaCOMA_TXSERV: TFMTBCDField
      FieldName = 'COMA_TXSERV'
      ProviderFlags = [pfInUpdate]
      Precision = 9
      Size = 2
    end
    object cds_comaCOMA_MESA: TIntegerField
      FieldName = 'COMA_MESA'
      ProviderFlags = [pfInUpdate]
    end
    object cds_comaCL_COD: TStringField
      FieldName = 'CL_COD'
    end
    object cds_comads_comap: TDataSetField
      FieldName = 'ds_comap'
    end
    object cds_comads_comai: TDataSetField
      FieldName = 'ds_comai'
    end
  end
  object dsr_coma: TDataSource
    Left = 24
    Top = 264
  end
  object ds_comai: TSQLDataSet
    CommandText = 
      'select i.comai_oid, i.coma_oid, i.comai_qtde, i.pro_oid, '#13#10'  i.c' +
      'omai_unit, i.comai_total, '#13#10'  p.pro_cod, p.pro_des, p.pro_venda'#13 +
      #10'  from comai i'#13#10'    inner join pro p on i.pro_oid = p.pro_oid'#13#10 +
      '  where coma_oid = :coma_oid'#13#10'  order by comai_oid'
    DataSource = dsr_coma_comai
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftString
        Name = 'coma_oid'
        ParamType = ptInput
      end>
    SQLConnection = cnn
    Left = 96
    Top = 72
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
    object ds_comaiCOMAI_QTDE: TFMTBCDField
      FieldName = 'COMAI_QTDE'
      ProviderFlags = [pfInUpdate]
      Precision = 9
      Size = 2
    end
    object ds_comaiPRO_OID: TStringField
      FieldName = 'PRO_OID'
      ProviderFlags = [pfInUpdate]
      Required = True
      FixedChar = True
      Size = 14
    end
    object ds_comaiCOMAI_UNIT: TFMTBCDField
      FieldName = 'COMAI_UNIT'
      ProviderFlags = [pfInUpdate]
      Required = True
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
    object ds_comaiPRO_COD: TStringField
      FieldName = 'PRO_COD'
      ProviderFlags = []
    end
    object ds_comaiPRO_DES: TStringField
      FieldName = 'PRO_DES'
      ProviderFlags = []
      Size = 40
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
    DataSetField = cds_comads_comai
    Params = <>
    Left = 96
    Top = 200
    object cds_comaiCOMAI_OID: TStringField
      FieldName = 'COMAI_OID'
      ProviderFlags = [pfInUpdate, pfInKey]
      Required = True
      FixedChar = True
      Size = 14
    end
    object cds_comaiCOMA_OID: TStringField
      FieldName = 'COMA_OID'
      ProviderFlags = [pfInUpdate]
      Size = 14
    end
    object cds_comaiCOMAI_QTDE: TFMTBCDField
      FieldName = 'COMAI_QTDE'
      ProviderFlags = [pfInUpdate]
      Precision = 9
      Size = 2
    end
    object cds_comaiPRO_OID: TStringField
      FieldName = 'PRO_OID'
      ProviderFlags = [pfInUpdate]
      Required = True
      FixedChar = True
      Size = 14
    end
    object cds_comaiCOMAI_UNIT: TFMTBCDField
      FieldName = 'COMAI_UNIT'
      ProviderFlags = [pfInUpdate]
      Required = True
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
    object cds_comaiPRO_COD: TStringField
      FieldName = 'PRO_COD'
      ProviderFlags = []
    end
    object cds_comaiPRO_DES: TStringField
      FieldName = 'PRO_DES'
      ProviderFlags = []
      Size = 40
    end
    object cds_comaiPRO_VENDA: TFMTBCDField
      FieldName = 'PRO_VENDA'
      ProviderFlags = []
      Precision = 9
      Size = 2
    end
  end
  object dsr_comai: TDataSource
    Left = 96
    Top = 264
  end
  object dsr_coma_comai: TDataSource
    DataSet = ds_coma
    Left = 96
    Top = 136
  end
  object ds_pro_lkp: TSQLDataSet
    CommandText = 
      'SELECT PRO_OID, PRO_DES, PRO_VENDA'#13#10'  FROM PRO'#13#10'  WHERE PRO_OID ' +
      'IS NULL'
    MaxBlobSize = -1
    Params = <>
    SQLConnection = cnn
    Left = 560
    Top = 72
    object ds_pro_lkpPRO_OID: TStringField
      FieldName = 'PRO_OID'
      Required = True
      FixedChar = True
      Size = 14
    end
    object ds_pro_lkpPRO_DES: TStringField
      FieldName = 'PRO_DES'
      Required = True
      Size = 40
    end
    object ds_pro_lkpPRO_VENDA: TFMTBCDField
      FieldName = 'PRO_VENDA'
      Required = True
      Precision = 9
      Size = 2
    end
  end
  object dsp_pro_lkp: TDataSetProvider
    DataSet = ds_pro_lkp
    Left = 560
    Top = 136
  end
  object cds_pro_lkp: TClientDataSet
    Tag = 5
    Aggregates = <>
    Params = <>
    ProviderName = 'dsp_pro_lkp'
    Left = 560
    Top = 192
    object cds_pro_lkpPRO_OID: TStringField
      FieldName = 'PRO_OID'
      Required = True
      Visible = False
      FixedChar = True
      Size = 14
    end
    object cds_pro_lkpPRO_DES: TStringField
      FieldName = 'PRO_DES'
      Required = True
      Size = 35
    end
    object cds_pro_lkpPRO_VENDA: TFMTBCDField
      FieldName = 'PRO_VENDA'
      Required = True
      DisplayFormat = '0.00'
      Precision = 9
      Size = 2
    end
  end
  object dsr_pro_lkp: TDataSource
    DataSet = cds_pro_lkp
    Left = 560
    Top = 256
  end
  object ds_comap: TSQLDataSet
    CommandText = 
      'select comap_oid, coma_oid, '#13#10'  comap_dc, comap_hist, comap_valo' +
      'r'#13#10'  from comap'#13#10'  where coma_oid = :coma_oid'#13#10'  order by comap_' +
      'oid'
    DataSource = dsr_coma_comap
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftString
        Name = 'coma_oid'
        ParamType = ptInput
      end>
    SQLConnection = cnn
    Left = 168
    Top = 72
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
    DataSetField = cds_comads_comap
    Params = <>
    Left = 168
    Top = 200
    object cds_comapCOMAP_OID: TStringField
      FieldName = 'COMAP_OID'
      ProviderFlags = [pfInUpdate, pfInKey]
      Required = True
      FixedChar = True
      Size = 14
    end
    object cds_comapCOMA_OID: TStringField
      FieldName = 'COMA_OID'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 14
    end
    object cds_comapCOMAP_DC: TIntegerField
      FieldName = 'COMAP_DC'
      ProviderFlags = [pfInUpdate]
    end
    object cds_comapCOMAP_HIST: TStringField
      FieldName = 'COMAP_HIST'
      ProviderFlags = [pfInUpdate]
    end
    object cds_comapCOMAP_VALOR: TFMTBCDField
      FieldName = 'COMAP_VALOR'
      ProviderFlags = [pfInUpdate]
      Precision = 9
      Size = 2
    end
  end
  object dsr_comap: TDataSource
    Left = 168
    Top = 264
  end
  object dsr_coma_comap: TDataSource
    DataSet = ds_coma
    Left = 168
    Top = 136
  end
  object ds_cl_lkp: TSQLDataSet
    CommandText = 
      'select cl_oid, cl_cod, cl_nome, cl_cpf, cl_rg, cl_fone'#13#10'  from c' +
      'l'#13#10'  where cl_oid is null'#13#10'  order by cl_nome'
    MaxBlobSize = -1
    Params = <>
    SQLConnection = cnn
    Left = 640
    Top = 72
    object ds_cl_lkpCL_OID: TStringField
      FieldName = 'CL_OID'
      Required = True
      FixedChar = True
      Size = 14
    end
    object ds_cl_lkpCL_COD: TStringField
      FieldName = 'CL_COD'
      Required = True
    end
    object ds_cl_lkpCL_NOME: TStringField
      FieldName = 'CL_NOME'
      Required = True
      Size = 40
    end
    object ds_cl_lkpCL_CPF: TStringField
      FieldName = 'CL_CPF'
      Size = 11
    end
    object ds_cl_lkpCL_RG: TStringField
      FieldName = 'CL_RG'
    end
    object ds_cl_lkpCL_FONE: TStringField
      FieldName = 'CL_FONE'
      Required = True
    end
  end
  object dsp_cl_lkp: TDataSetProvider
    DataSet = ds_cl_lkp
    Left = 640
    Top = 136
  end
  object cds_cl_lkp: TClientDataSet
    Tag = 5
    Aggregates = <>
    Params = <>
    ProviderName = 'dsp_cl_lkp'
    Left = 640
    Top = 192
    object cds_cl_lkpCL_OID: TStringField
      FieldName = 'CL_OID'
      Required = True
      FixedChar = True
      Size = 14
    end
    object cds_cl_lkpCL_COD: TStringField
      FieldName = 'CL_COD'
      Required = True
    end
    object cds_cl_lkpCL_NOME: TStringField
      FieldName = 'CL_NOME'
      Required = True
      Size = 40
    end
    object cds_cl_lkpCL_CPF: TStringField
      FieldName = 'CL_CPF'
      Size = 11
    end
    object cds_cl_lkpCL_RG: TStringField
      FieldName = 'CL_RG'
    end
    object cds_cl_lkpCL_FONE: TStringField
      FieldName = 'CL_FONE'
      Required = True
    end
  end
  object dsr_cl_lkp: TDataSource
    DataSet = cds_cl_lkp
    Left = 640
    Top = 256
  end
  object ds_cart_debito_lkp: TSQLDataSet
    CommandText = 
      'select cart_oid, cart_cod, cart_des'#13#10'  from cart'#13#10'  where cart_d' +
      'c = 1'#13#10'  order by cart_des'
    MaxBlobSize = -1
    Params = <>
    SQLConnection = cnn
    Left = 735
    Top = 72
    object ds_cart_debito_lkpCART_OID: TStringField
      FieldName = 'CART_OID'
      Required = True
      FixedChar = True
      Size = 14
    end
    object ds_cart_debito_lkpCART_COD: TStringField
      FieldName = 'CART_COD'
    end
    object ds_cart_debito_lkpCART_DES: TStringField
      FieldName = 'CART_DES'
    end
  end
  object dsp_cart_debito_lkp: TDataSetProvider
    DataSet = ds_cart_debito_lkp
    Left = 735
    Top = 136
  end
  object cds_cart_debito_lkp: TClientDataSet
    Tag = 5
    Aggregates = <>
    Params = <>
    ProviderName = 'dsp_cart_debito_lkp'
    Left = 735
    Top = 192
    object cds_cart_debito_lkpCART_OID: TStringField
      FieldName = 'CART_OID'
      Required = True
      FixedChar = True
      Size = 14
    end
    object cds_cart_debito_lkpCART_COD: TStringField
      FieldName = 'CART_COD'
    end
    object cds_cart_debito_lkpCART_DES: TStringField
      FieldName = 'CART_DES'
    end
  end
  object dsr_cart_debito_lkp: TDataSource
    DataSet = cds_cart_debito_lkp
    Left = 735
    Top = 256
  end
  object ds_cart_credito_lkp: TSQLDataSet
    CommandText = 
      'select cart_oid, cart_cod, cart_des'#13#10'  from cart'#13#10'  where cart_d' +
      'c = 1'#13#10'  order by cart_des'
    MaxBlobSize = -1
    Params = <>
    SQLConnection = cnn
    Left = 847
    Top = 72
    object StringField1: TStringField
      FieldName = 'CART_OID'
      Required = True
      FixedChar = True
      Size = 14
    end
    object StringField2: TStringField
      FieldName = 'CART_COD'
    end
    object StringField3: TStringField
      FieldName = 'CART_DES'
    end
  end
  object dsp_cart_credito_lkp: TDataSetProvider
    DataSet = ds_cart_credito_lkp
    Left = 847
    Top = 136
  end
  object cds_cart_credito_lkp: TClientDataSet
    Tag = 5
    Aggregates = <>
    Params = <>
    ProviderName = 'dsp_cart_credito_lkp'
    Left = 847
    Top = 192
    object StringField4: TStringField
      FieldName = 'CART_OID'
      Required = True
      FixedChar = True
      Size = 14
    end
    object StringField5: TStringField
      FieldName = 'CART_COD'
    end
    object StringField6: TStringField
      FieldName = 'CART_DES'
    end
  end
  object dsr_cart_credito_lkp: TDataSource
    DataSet = cds_cart_credito_lkp
    Left = 847
    Top = 256
  end
  object Sql: TSQLDataSet
    Params = <>
    Left = 560
    Top = 16
  end
  object cnn: TSQLConnection
    DriverName = 'Firebird'
    LoginPrompt = False
    Params.Strings = (
      'DriverName=Firebird'
      'Database=C:\wrk\db\food\food.fdb'
      'RoleName=RoleName'
      'User_Name=sysdba'
      'Password=masterkey'
      'ServerCharSet=win1252'
      'SQLDialect=3'
      'ErrorResourceFile='
      'LocaleCode=0000'
      'BlobSize=-1'
      'CommitRetain=False'
      'WaitOnLocks=True'
      'IsolationLevel=ReadCommitted'
      'Trim Char=False')
    Left = 24
    Top = 16
  end
end
