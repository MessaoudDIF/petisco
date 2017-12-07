inherited ProdutoPesquisaModelo: TProdutoPesquisaModelo
  OldCreateOrder = True
  Height = 330
  inherited ds: TSQLDataSet
    CommandText = 
      'select pro_oid,  pro_cod, pro_des, pro_venda from pro where pro_' +
      'oid is null'
    object dsPRO_OID: TStringField
      FieldName = 'PRO_OID'
      Required = True
      FixedChar = True
      Size = 14
    end
    object dsPRO_COD: TStringField
      FieldName = 'PRO_COD'
      Required = True
    end
    object dsPRO_DES: TStringField
      FieldName = 'PRO_DES'
      Required = True
      Size = 40
    end
    object dsPRO_VENDA: TBCDField
      FieldName = 'PRO_VENDA'
      Required = True
      Precision = 9
      Size = 2
    end
  end
  inherited cds: TClientDataSet
    object cdsPRO_OID: TStringField
      FieldName = 'PRO_OID'
      Required = True
      Visible = False
      FixedChar = True
      Size = 14
    end
    object cdsPRO_DES: TStringField
      DisplayLabel = 'Produto'
      DisplayWidth = 30
      FieldName = 'PRO_DES'
      Required = True
      Size = 40
    end
    object cdsPRO_VENDA: TBCDField
      FieldName = 'PRO_VENDA'
      Required = True
      DisplayFormat = '0.00'
      Precision = 9
      Size = 2
    end
    object cdsPRO_COD: TStringField
      DisplayLabel = 'C'#243'digo'
      DisplayWidth = 15
      FieldName = 'PRO_COD'
      Required = True
    end
  end
end
