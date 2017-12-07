inherited OperacaoDeMovimentoDeCaixaPesquisaModelo: TOperacaoDeMovimentoDeCaixaPesquisaModelo
  OldCreateOrder = True
  inherited ds: TSQLDataSet
    CommandText = 
      'SELECT CXMVO_OID, CXMVO_COD, CXMVO_DES'#13#10'  FROM CXMVO'#13#10'  ORDER BY' +
      ' CXMVO_COD'
  end
end
