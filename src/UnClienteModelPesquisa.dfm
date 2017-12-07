inherited ClienteModeloPesquisa: TClienteModeloPesquisa
  OldCreateOrder = True
  Left = 591
  Top = 182
  Height = 359
  inherited ds: TSQLDataSet
    CommandText = 'select cl_oid, cl_cod, cl_nome from cl where cl_oid is null'
    object dsCL_OID: TStringField
      FieldName = 'CL_OID'
      Required = True
      FixedChar = True
      Size = 14
    end
    object dsCL_COD: TStringField
      FieldName = 'CL_COD'
      Required = True
    end
    object dsCL_NOME: TStringField
      FieldName = 'CL_NOME'
      Required = True
      Size = 40
    end
  end
  inherited cds: TClientDataSet
    object cdsCL_OID: TStringField
      FieldName = 'CL_OID'
      Required = True
      Visible = False
      FixedChar = True
      Size = 14
    end
    object cdsCL_COD: TStringField
      DisplayLabel = 'Apelido'
      DisplayWidth = 15
      FieldName = 'CL_COD'
      Required = True
    end
    object cdsCL_NOME: TStringField
      DisplayLabel = 'Nome'
      FieldName = 'CL_NOME'
      Required = True
      Size = 40
    end
  end
end
