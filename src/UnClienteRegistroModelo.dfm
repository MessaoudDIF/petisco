inherited ClienteRegistroModelo: TClienteRegistroModelo
  OldCreateOrder = True
  inherited ds: TSQLDataSet
    CommandText = 
      'SELECT CL_OID, CL_COD, CL_NOME, CL_FONE, CL_ENDER,'#13#10'  CL_BAIRRO,' +
      ' CL_CIDADE, CL_UF, CL_RG, CL_CPF, '#13#10'  CL_CARENCIA, CL_LIMITE, '#13#10 +
      '  REC_STT, REC_INS, REC_UPD, REC_DEL'#13#10'  FROM CL'#13#10'  WHERE CL_OID ' +
      'IS NULL'#13#10'  ORDER BY CL_OID'
  end
  inherited cds: TClientDataSet
    BeforePost = cdsBeforePost
  end
end
