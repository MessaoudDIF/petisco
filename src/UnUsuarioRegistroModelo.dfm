inherited UsuarioRegistroModelo: TUsuarioRegistroModelo
  OldCreateOrder = True
  Left = 737
  Top = 215
  inherited ds: TSQLDataSet
    CommandText = 
      'SELECT USR_OID, USR_NAME, USR_PW, USR_ADM,'#13#10'  REC_STT, REC_INS, ' +
      'REC_UPD, REC_DEL'#13#10'  FROM USR'#13#10'  WHERE USR_OID IS NULL'#13#10'  ORDER B' +
      'Y USR_OID'
  end
  inherited cds: TClientDataSet
    BeforePost = cdsBeforePost
  end
end
