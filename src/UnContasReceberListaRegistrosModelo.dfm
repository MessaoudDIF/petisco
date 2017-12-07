inherited ContasReceberListaRegistrosModelo: TContasReceberListaRegistrosModelo
  OldCreateOrder = True
  Left = 694
  Top = 293
  inherited ds: TSQLDataSet
    CommandText = 
      'SELECT T.TITR_OID, T.TITR_VENC, T.TITR_VALOR, T.TITR_LIQ, '#13#10'  T.' +
      'TITR_PAGO, C.CL_NOME'#13#10'  FROM TITR T INNER JOIN CL C ON T.CL_OID ' +
      '= C.CL_OID'#13#10'  WHERE T.TITR_OID IS NULL'#13#10'  ORDER BY T.TITR_OID'
  end
end
