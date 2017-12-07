object PetiscoModel: TPetiscoModel
  OldCreateOrder = False
  Left = 655
  Top = 254
  Height = 251
  Width = 537
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
    Left = 40
    Top = 16
  end
  object Sql: TSQLDataSet
    MaxBlobSize = -1
    Params = <>
    SQLConnection = cnn
    Left = 448
    Top = 24
  end
end
