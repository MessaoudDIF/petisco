inherited UsuarioListaRegistrosModelo: TUsuarioListaRegistrosModelo
  OldCreateOrder = True
  Left = 597
  Top = 313
  inherited ds: TSQLDataSet
    CommandText = 
      'SELECT USR_OID, USR_NAME'#13#10'  FROM USR'#13#10'  WHERE USR_OID IS NULL'#13#10' ' +
      ' ORDER BY USR_OID'
  end
end
