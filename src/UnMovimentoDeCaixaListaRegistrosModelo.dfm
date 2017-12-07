inherited MovimentoDeCaixaListaRegistrosModelo: TMovimentoDeCaixaListaRegistrosModelo
  OldCreateOrder = True
  Left = 693
  Top = 428
  inherited ds: TSQLDataSet
    CommandText = 
      'SELECT M.CXMV_OID, M.CXMV_DATA, M.CXMV_VALOR, '#13#10'  O.CXMVO_DES, M' +
      '.CXMV_HIST, M.CXMV_DOC, S.CATS_DES, '#13#10'  R.CRES_DES'#13#10'  FROM CXMV ' +
      'M '#13#10'        INNER JOIN CXMVO O ON M.CXMVO_OID = O.CXMVO_OID '#13#10'  ' +
      '      LEFT JOIN CATS S ON M.CATS_OID = S.CATS_OID '#13#10'        LEFT' +
      ' JOIN CRES R ON M.CRES_OID = R.CRES_OID'#13#10'  WHERE CXMV_OID IS NUL' +
      'L'#13#10'  ORDER BY CXMV_OID'#13#10
  end
end
