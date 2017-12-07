inherited ClienteListaRegistrosModelo: TClienteListaRegistrosModelo
  OldCreateOrder = True
  inherited ds: TSQLDataSet
    CommandText = 
      'SELECT CL_OID, CL_COD, CL_NOME, CL_FONE, CL_ENDER'#13#10'  FROM CL'#13#10'  ' +
      'WHERE CL_OID IS NULL'#13#10'  ORDER BY CL_OID'
  end
  inherited cds: TClientDataSet
    IndexDefs = <
      item
        Name = 'cl_nome'
        Fields = 'cl_nome'
      end
      item
        Name = 'cl_cod'
        Fields = 'cl_cod'
      end>
    StoreDefs = True
  end
end
