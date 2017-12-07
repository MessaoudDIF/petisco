inherited CartaoCreditoModeloPesquisa: TCartaoCreditoModeloPesquisa
  OldCreateOrder = True
  Height = 361
  inherited ds: TSQLDataSet
    CommandText = 'SELECT CART_OID, CART_COD FROM CART WHERE CART_OID IS NULL'
    object dsCART_OID: TStringField
      FieldName = 'CART_OID'
      Required = True
      FixedChar = True
      Size = 14
    end
    object dsCART_COD: TStringField
      FieldName = 'CART_COD'
    end
  end
  inherited cds: TClientDataSet
    object cdsCART_OID: TStringField
      FieldName = 'CART_OID'
      Required = True
      Visible = False
      FixedChar = True
      Size = 14
    end
    object cdsCART_COD: TStringField
      DisplayLabel = 'Cart'#227'o'
      FieldName = 'CART_COD'
    end
  end
end
