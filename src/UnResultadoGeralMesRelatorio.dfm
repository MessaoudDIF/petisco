inherited ResultadoGeralMesRelatorio: TResultadoGeralMesRelatorio
  Left = 357
  Top = 97
  PixelsPerInch = 96
  TextHeight = 13
  inherited RelatorioTemplate: TRLReport
    Margins.LeftMargin = 5.000000000000000000
    Margins.TopMargin = 5.000000000000000000
    Margins.RightMargin = 5.000000000000000000
    Margins.BottomMargin = 5.000000000000000000
    inherited RLBand1: TRLBand
      Height = 118
      inherited lblTitulo: TRLLabel
        Caption = 'DEMONSTRA'#199#195'O DO RESULTADO'
      end
      object RLLabel4: TRLLabel
        Left = 140
        Top = 96
        Width = 353
        Height = 16
        AutoSize = False
        Caption = 'Categoria'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel6: TRLLabel
        Left = 510
        Top = 93
        Width = 100
        Height = 16
        Alignment = taCenter
        AutoSize = False
        Caption = 'Valor Total'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
    inherited RLBand2: TRLBand
      Top = 137
      Height = 40
      GreenBarPrint = True
      object txtCategoria: TRLDBText
        Tag = 10
        Left = 140
        Top = 12
        Width = 361
        Height = 16
        AutoSize = False
        DataField = 'CATEGORIA'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object txtValor: TRLDBText
        Tag = 10
        Left = 510
        Top = 12
        Width = 100
        Height = 16
        Alignment = taRightJustify
        AutoSize = False
        DataField = 'JAN_'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        BeforePrint = txtValorBeforePrint
      end
    end
    inherited RLBand3: TRLBand
      Top = 177
    end
  end
end
