object PetiscoModel: TPetiscoModel
  OldCreateOrder = True
  Height = 376
  Width = 537
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
    CommandText = 'select * from coma order by coma_oid'
    MaxBlobSize = -1
    Params = <>
    SQLConnection = cnn
    Left = 48
    Top = 104
    object dsCOMA_OID: TStringField
      FieldName = 'COMA_OID'
      Required = True
      Size = 14
    end
    object dsCL_OID: TStringField
      FieldName = 'CL_OID'
      FixedChar = True
      Size = 14
    end
    object dsCOMA_COMANDA: TStringField
      FieldName = 'COMA_COMANDA'
      Required = True
      Size = 14
    end
    object dsCOMA_DATA: TSQLTimeStampField
      FieldName = 'COMA_DATA'
      Required = True
    end
    object dsCOMA_CONSUMO: TBCDField
      FieldName = 'COMA_CONSUMO'
      Precision = 9
      Size = 2
    end
    object dsCOMA_TXSERV: TBCDField
      FieldName = 'COMA_TXSERV'
      Precision = 9
      Size = 2
    end
    object dsCOMA_TOTAL: TBCDField
      FieldName = 'COMA_TOTAL'
      Required = True
      Precision = 9
      Size = 2
    end
    object dsCOMA_SALDO: TBCDField
      FieldName = 'COMA_SALDO'
      Precision = 9
      Size = 2
    end
    object dsCOMA_STT: TIntegerField
      FieldName = 'COMA_STT'
      Required = True
    end
    object dsCOMA_MESA: TIntegerField
      FieldName = 'COMA_MESA'
    end
  end
  object dsp: TDataSetProvider
    DataSet = ds
    Left = 48
    Top = 160
  end
  object cds: TClientDataSet
    Aggregates = <>
    AggregatesActive = True
    Params = <>
    ProviderName = 'dsp'
    Left = 48
    Top = 224
    object cdsCOMA_OID: TStringField
      FieldName = 'COMA_OID'
      Required = True
      Size = 14
    end
    object cdsCL_OID: TStringField
      FieldName = 'CL_OID'
      FixedChar = True
      Size = 14
    end
    object cdsCOMA_COMANDA: TStringField
      FieldName = 'COMA_COMANDA'
      Required = True
      Size = 14
    end
    object cdsCOMA_DATA: TSQLTimeStampField
      FieldName = 'COMA_DATA'
      Required = True
    end
    object cdsCOMA_CONSUMO: TBCDField
      FieldName = 'COMA_CONSUMO'
      Precision = 9
      Size = 2
    end
    object cdsCOMA_TXSERV: TBCDField
      FieldName = 'COMA_TXSERV'
      Precision = 9
      Size = 2
    end
    object cdsCOMA_TOTAL: TBCDField
      FieldName = 'COMA_TOTAL'
      Required = True
      Precision = 9
      Size = 2
    end
    object cdsCOMA_SALDO: TBCDField
      FieldName = 'COMA_SALDO'
      Precision = 9
      Size = 2
    end
    object cdsCOMA_STT: TIntegerField
      FieldName = 'COMA_STT'
      Required = True
    end
    object cdsCOMA_MESA: TIntegerField
      FieldName = 'COMA_MESA'
    end
    object cdstotal: TAggregateField
      FieldName = 'total'
      Visible = True
      Active = True
      DisplayName = ''
    end
  end
end
