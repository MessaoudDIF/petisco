inherited MovimentoDeContaCorrenteListaRegistrosmodelo: TMovimentoDeContaCorrenteListaRegistrosmodelo
  OldCreateOrder = True
  Left = 399
  Top = 230
  inherited ds: TSQLDataSet
    CommandText = 
      'SELECT M.CCORMV_OID, M.CCORMV_DATA, M.CCORMV_VALOR, '#13#10'  O.CCORMV' +
      'O_DES, M.CCORMV_HIST, M.CCORMV_DOC, '#13#10'  C.CCOR_DES, S.CATS_DES, ' +
      'R.CRES_DES'#13#10'  FROM CCORMV M '#13#10'    INNER JOIN CCORMVO O ON M.CCOR' +
      'MVO_OID = O.CCORMVO_OID'#13#10'    INNER JOIN CCOR C ON M.CCOR_OID = C' +
      '.CCOR_OID'#13#10'    LEFT JOIN CATS S ON M.CATS_OID = S.CATS_OID'#13#10'    ' +
      'LEFT JOIN CRES R ON M.CRES_OID = R.CRES_OID'#13#10'  WHERE M.CCORMV_OI' +
      'D IS NULL'#13#10'  ORDER BY M.CCORMV_OID'#13#10' '
  end
end
