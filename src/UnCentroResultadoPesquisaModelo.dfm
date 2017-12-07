inherited CentroDeResultadoPesquisaModelo: TCentroDeResultadoPesquisaModelo
  Left = 759
  Top = 190
  inherited ds: TSQLDataSet
    CommandText = 
      'SELECT CRES_OID, CRES_COD, CRES_DES'#13#10'  FROM CRES'#13#10'  WHERE CRES_O' +
      'ID IS NULL'#13#10'  ORDER BY CRES_DES'
    object dsCRES_OID: TStringField
      FieldName = 'CRES_OID'
      Required = True
      FixedChar = True
      Size = 14
    end
    object dsCRES_COD: TStringField
      FieldName = 'CRES_COD'
    end
    object dsCRES_DES: TStringField
      FieldName = 'CRES_DES'
      Size = 40
    end
  end
  inherited cds: TClientDataSet
    object cdsCRES_OID: TStringField
      FieldName = 'CRES_OID'
      Required = True
      Visible = False
      FixedChar = True
      Size = 14
    end
    object cdsCRES_COD: TStringField
      DisplayLabel = 'C'#243'digo'
      DisplayWidth = 5
      FieldName = 'CRES_COD'
    end
    object cdsCRES_DES: TStringField
      DisplayLabel = 'Centro de Resultado'
      FieldName = 'CRES_DES'
      Size = 40
    end
  end
end
