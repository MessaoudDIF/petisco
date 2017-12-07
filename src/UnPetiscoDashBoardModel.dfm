object PetiscoDashBoardModel: TPetiscoDashBoardModel
  OldCreateOrder = False
  Left = 677
  Top = 201
  Height = 400
  Width = 597
  object cnn: TSQLConnection
    ConnectionName = 'IBConnection'
    DriverName = 'Interbase'
    GetDriverFunc = 'getSQLDriverINTERBASE'
    LibraryName = 'dbexpint.dll'
    LoginPrompt = False
    Params.Strings = (
      'DriverName=Interbase'
      'Database=c:\wrk\db\food\food.fdb'
      'RoleName=RoleName'
      'User_Name=sysdba'
      'Password=masterkey'
      'ServerCharSet='
      'SQLDialect=3'
      'ErrorResourceFile='
      'LocaleCode=0000'
      'BlobSize=-1'
      'CommitRetain=False'
      'WaitOnLocks=True'
      'Interbase TransIsolation=ReadCommited'
      'Trim Char=False')
    VendorLib = 'gds32.dll'
    BeforeConnect = cnnBeforeConnect
    Connected = True
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
      DisplayWidth = 4
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
    object dsTIT_VALOR: TBCDField
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
    Active = True
    Aggregates = <>
    AggregatesActive = True
    Params = <>
    ProviderName = 'dsp'
    Left = 40
    Top = 224
    object cdsSITUACAO: TIntegerField
      DisplayLabel = 'Sit.'
      DisplayWidth = 4
      FieldName = 'SITUACAO'
      Required = True
    end
    object cdsTIT_DOC: TStringField
      DisplayLabel = 'Documento'
      FieldName = 'TIT_DOC'
      Size = 15
    end
    object cdsTIT_VALOR: TBCDField
      DisplayLabel = '    Valor'
      FieldName = 'TIT_VALOR'
      DisplayFormat = '0.00'
      Precision = 9
      Size = 2
    end
    object cdsTIT_VENC: TDateField
      Alignment = taCenter
      DisplayLabel = '     Vencimento'
      DisplayWidth = 15
      FieldName = 'TIT_VENC'
    end
    object cdsTIT_HIST: TStringField
      DisplayLabel = 'Hist'#243'rico'
      DisplayWidth = 40
      FieldName = 'TIT_HIST'
      Size = 50
    end
    object cdsFORN_NOME: TStringField
      DisplayLabel = 'Fornecedor'
      DisplayWidth = 100
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
      Expression = 'SUM(TIT_VALOR)'
    end
  end
  object dsr: TDataSource
    DataSet = cds
    Left = 40
    Top = 288
  end
end
