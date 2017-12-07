object PetiscoDashBoardModelo: TPetiscoDashBoardModelo
  OldCreateOrder = False
  Height = 400
  Width = 597
  object cnn: TSQLConnection
    ConnectionName = 'PetiscoConnection'
    DriverName = 'Firebird'
    LoginPrompt = False
    Params.Strings = (
      'DriverUnit=Data.DBXFirebird'
      
        'DriverPackageLoader=TDBXDynalinkDriverLoader,DbxCommonDriver230.' +
        'bpl'
      
        'DriverAssemblyLoader=Borland.Data.TDBXDynalinkDriverLoader,Borla' +
        'nd.Data.DbxCommonDriver,Version=23.0.0.0,Culture=neutral,PublicK' +
        'eyToken=91d62ebb5b0d1b1b'
      
        'MetaDataPackageLoader=TDBXFirebirdMetaDataCommandFactory,DbxFire' +
        'birdDriver230.bpl'
      
        'MetaDataAssemblyLoader=Borland.Data.TDBXFirebirdMetaDataCommandF' +
        'actory,Borland.Data.DbxFirebirdDriver,Version=23.0.0.0,Culture=n' +
        'eutral,PublicKeyToken=91d62ebb5b0d1b1b'
      'GetDriverFunc=getSQLDriverINTERBASE'
      'LibraryName=dbxfb.dll'
      'LibraryNameOsx=libsqlfb.dylib'
      'VendorLib=fbclient.dll'
      'VendorLibWin64=fbclient.dll'
      'VendorLibOsx=/Library/Frameworks/Firebird.framework/Firebird'
      'Database=c:\wrk\db\food\food.fdb'
      'User_Name=sysdba'
      'Password=masterkey'
      'Role=RoleName'
      'MaxBlobSize=-1'
      'LocaleCode=0000'
      'IsolationLevel=ReadCommitted'
      'SQLDialect=3'
      'CommitRetain=False'
      'WaitOnLocks=True'
      'TrimChar=False'
      'BlobSize=-1'
      'ErrorResourceFile='
      'RoleName=RoleName'
      'ServerCharSet='
      'Trim Char=False')
    BeforeConnect = cnnBeforeConnect
    Left = 40
    Top = 16
  end
  object SqlProcessor: TSQLDataSet
    MaxBlobSize = -1
    Params = <>
    SQLConnection = cnn
    Left = 432
    Top = 24
  end
  object ds: TSQLDataSet
    CommandText = 
      'SELECT 0 SITUACAO, T.TIT_DOC, T.TIT_VENC, T.TIT_VALOR, T.TIT_HIS' +
      'T, '#13#10'  F.FORN_NOME'#13#10', T.TIT_OID  FROM TIT T INNER JOIN FORN F ON' +
      ' T.FORN_OID = F.FORN_OID '#13#10'  WHERE TIT_OID IS NULL'#13#10'  ORDER BY T' +
      '.TIT_VENC'
    MaxBlobSize = -1
    Params = <>
    SQLConnection = cnn
    Left = 40
    Top = 88
    object dsSITUACAO: TIntegerField
      FieldName = 'SITUACAO'
      Required = True
    end
    object dsTIT_DOC: TStringField
      FieldName = 'TIT_DOC'
      Size = 15
    end
    object dsTIT_VENC: TDateField
      FieldName = 'TIT_VENC'
    end
    object dsTIT_VALOR: TFMTBCDField
      FieldName = 'TIT_VALOR'
      Precision = 9
      Size = 2
    end
    object dsTIT_HIST: TStringField
      FieldName = 'TIT_HIST'
      Size = 50
    end
    object dsFORN_NOME: TStringField
      FieldName = 'FORN_NOME'
      Size = 40
    end
    object dsTIT_OID: TStringField
      FieldName = 'TIT_OID'
      FixedChar = True
      Size = 14
    end
  end
  object dsp: TDataSetProvider
    DataSet = ds
    Options = [poCascadeDeletes, poCascadeUpdates, poAllowMultiRecordUpdates, poPropogateChanges, poAllowCommandText]
    Left = 40
    Top = 152
  end
  object cds: TClientDataSet
    Aggregates = <>
    AggregatesActive = True
    Params = <>
    ProviderName = 'dsp'
    Left = 40
    Top = 224
    object cdsSITUACAO: TIntegerField
      DisplayLabel = 'Sit'
      DisplayWidth = 8
      FieldName = 'SITUACAO'
      Required = True
    end
    object cdsTIT_DOC: TStringField
      DisplayLabel = 'Documento'
      FieldName = 'TIT_DOC'
      Size = 15
    end
    object cdsTIT_VENC: TDateField
      DisplayLabel = 'Vencimento'
      FieldName = 'TIT_VENC'
    end
    object cdsTIT_VALOR: TFMTBCDField
      DisplayLabel = 'Valor'
      FieldName = 'TIT_VALOR'
      Precision = 9
      Size = 2
    end
    object cdsTIT_HIST: TStringField
      DisplayLabel = 'Hist'#243'rico'
      FieldName = 'TIT_HIST'
      Size = 50
    end
    object cdsFORN_NOME: TStringField
      DisplayLabel = 'Fornecedor'
      FieldName = 'FORN_NOME'
      Size = 40
    end
    object cdsTIT_OID: TStringField
      FieldName = 'TIT_OID'
      Visible = False
      FixedChar = True
      Size = 14
    end
    object cdsTOTAL: TAggregateField
      FieldName = 'TOTAL'
      Visible = True
      Active = True
      DisplayName = ''
      Expression = 'SUM(TIT_VALOR)'
    end
  end
  object dsr: TDataSource
    DataSet = cds
    Left = 40
    Top = 288
  end
  object ds_resultado: TSQLDataSet
    CommandText = 
      'SELECT ESCLR_MOEDA RECEITAS, ESCLR_MOEDA IMPOSTOS,'#13#10'  ESCLR_MOED' +
      'A DESPESAS_FIXAS, '#13#10'  ESCLR_MOEDA DESPESAS_VARIAVEIS'#13#10'  FROM ESC' +
      'LR'#13#10'  WHERE ESCLR IS NULL'
    MaxBlobSize = -1
    Params = <>
    SQLConnection = cnn
    Left = 144
    Top = 88
    object ds_resultadoRECEITAS: TFMTBCDField
      FieldName = 'RECEITAS'
      Precision = 9
      Size = 2
    end
    object ds_resultadoIMPOSTOS: TFMTBCDField
      FieldName = 'IMPOSTOS'
      Precision = 9
      Size = 2
    end
    object ds_resultadoDESPESAS_FIXAS: TFMTBCDField
      FieldName = 'DESPESAS_FIXAS'
      Precision = 9
      Size = 2
    end
    object ds_resultadoDESPESAS_VARIAVEIS: TFMTBCDField
      FieldName = 'DESPESAS_VARIAVEIS'
      Precision = 9
      Size = 2
    end
  end
  object dsp_resultado: TDataSetProvider
    DataSet = ds_resultado
    Options = [poCascadeDeletes, poCascadeUpdates, poAllowMultiRecordUpdates, poPropogateChanges, poAllowCommandText]
    Left = 144
    Top = 152
  end
  object cds_resultado: TClientDataSet
    Aggregates = <>
    AggregatesActive = True
    Params = <>
    ProviderName = 'dsp_resultado'
    Left = 144
    Top = 224
    object cds_resultadoRECEITAS: TFMTBCDField
      FieldName = 'RECEITAS'
      Precision = 9
      Size = 2
    end
    object cds_resultadoIMPOSTOS: TFMTBCDField
      FieldName = 'IMPOSTOS'
      Precision = 9
      Size = 2
    end
    object cds_resultadoDESPESAS_FIXAS: TFMTBCDField
      FieldName = 'DESPESAS_FIXAS'
      Precision = 9
      Size = 2
    end
    object cds_resultadoDESPESAS_VARIAVEIS: TFMTBCDField
      FieldName = 'DESPESAS_VARIAVEIS'
      Precision = 9
      Size = 2
    end
  end
  object dsr_resultado: TDataSource
    DataSet = cds_resultado
    Left = 144
    Top = 288
  end
end
