inherited ResultadoGeralAnoRelatorio: TResultadoGeralAnoRelatorio
  Left = 287
  Top = 139
  Width = 1162
  PixelsPerInch = 96
  TextHeight = 13
  inherited RelatorioTemplate: TRLReport
    Width = 1123
    Height = 794
    Margins.LeftMargin = 5.000000000000000000
    Margins.TopMargin = 5.000000000000000000
    Margins.RightMargin = 5.000000000000000000
    Margins.BottomMargin = 5.000000000000000000
    PageSetup.Orientation = poLandscape
    inherited RLBand1: TRLBand
      Width = 1085
      Height = 110
      inherited lblTitulo: TRLLabel
        Left = 317
        Caption = 'DEMONSTRA'#199#195'O DO RESULTADO'
      end
      inherited lblSubtitulo: TRLLabel
        Left = 317
      end
      inherited RLLabel3: TRLLabel
        Left = 968
      end
      inherited NumeroDaUltimaPagina: TRLSystemInfo
        Left = 1052
      end
      inherited RLLabel2: TRLLabel
        Left = 1043
      end
      inherited NumeroDaPagina: TRLSystemInfo
        Left = 1007
      end
      object RLLabel4: TRLLabel
        Left = 4
        Top = 90
        Width = 150
        Height = 16
        AutoSize = False
        Caption = 'Categoria'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel6: TRLLabel
        Left = 158
        Top = 90
        Width = 70
        Height = 16
        Alignment = taCenter
        AutoSize = False
        Caption = 'Jan'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel7: TRLLabel
        Left = 235
        Top = 90
        Width = 70
        Height = 16
        Alignment = taCenter
        AutoSize = False
        Caption = 'Fev'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel8: TRLLabel
        Left = 312
        Top = 90
        Width = 70
        Height = 16
        Alignment = taCenter
        AutoSize = False
        Caption = 'Mar'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel9: TRLLabel
        Left = 389
        Top = 90
        Width = 70
        Height = 16
        Alignment = taCenter
        AutoSize = False
        Caption = 'Abr'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel10: TRLLabel
        Left = 466
        Top = 90
        Width = 70
        Height = 16
        Alignment = taCenter
        AutoSize = False
        Caption = 'Mai'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel11: TRLLabel
        Left = 543
        Top = 90
        Width = 70
        Height = 16
        Alignment = taCenter
        AutoSize = False
        Caption = 'Jun'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel12: TRLLabel
        Left = 620
        Top = 90
        Width = 70
        Height = 16
        Alignment = taCenter
        AutoSize = False
        Caption = 'Jul'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel13: TRLLabel
        Left = 697
        Top = 90
        Width = 70
        Height = 16
        Alignment = taCenter
        AutoSize = False
        Caption = 'Ago'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel17: TRLLabel
        Left = 1006
        Top = 90
        Width = 70
        Height = 16
        Alignment = taCenter
        AutoSize = False
        Caption = 'Dez'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel16: TRLLabel
        Left = 928
        Top = 90
        Width = 70
        Height = 16
        Alignment = taCenter
        AutoSize = False
        Caption = 'Nov'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel15: TRLLabel
        Left = 851
        Top = 90
        Width = 70
        Height = 16
        Alignment = taCenter
        AutoSize = False
        Caption = 'Out'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel14: TRLLabel
        Left = 774
        Top = 90
        Width = 70
        Height = 16
        Alignment = taCenter
        AutoSize = False
        Caption = 'Set'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
    inherited RLBand2: TRLBand
      Top = 129
      Width = 1085
      Height = 24
      object txtCategoria: TRLDBText
        Tag = 10
        Left = 4
        Top = 4
        Width = 149
        Height = 16
        AutoSize = False
        DataField = 'CATEGORIA'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object txtValor: TRLDBText
        Tag = 10
        Left = 158
        Top = 4
        Width = 70
        Height = 16
        Alignment = taRightJustify
        AutoSize = False
        DataField = 'JAN_'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        BeforePrint = FormatarValor
      end
      object RLDBText1: TRLDBText
        Tag = 10
        Left = 235
        Top = 4
        Width = 70
        Height = 16
        Alignment = taRightJustify
        AutoSize = False
        DataField = 'FEV_'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        BeforePrint = FormatarValor
      end
      object RLDBText2: TRLDBText
        Tag = 10
        Left = 389
        Top = 4
        Width = 70
        Height = 16
        Alignment = taRightJustify
        AutoSize = False
        DataField = 'ABR_'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        BeforePrint = FormatarValor
      end
      object RLDBText3: TRLDBText
        Tag = 10
        Left = 312
        Top = 4
        Width = 70
        Height = 16
        Alignment = taRightJustify
        AutoSize = False
        DataField = 'MAR_'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        BeforePrint = FormatarValor
      end
      object RLDBText4: TRLDBText
        Tag = 10
        Left = 697
        Top = 4
        Width = 70
        Height = 16
        Alignment = taRightJustify
        AutoSize = False
        DataField = 'AGO_'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        BeforePrint = FormatarValor
      end
      object RLDBText5: TRLDBText
        Tag = 10
        Left = 620
        Top = 4
        Width = 70
        Height = 16
        Alignment = taRightJustify
        AutoSize = False
        DataField = 'JUL_'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        BeforePrint = FormatarValor
      end
      object RLDBText6: TRLDBText
        Tag = 10
        Left = 543
        Top = 4
        Width = 70
        Height = 16
        Alignment = taRightJustify
        AutoSize = False
        DataField = 'JUN_'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        BeforePrint = FormatarValor
      end
      object RLDBText7: TRLDBText
        Tag = 10
        Left = 466
        Top = 4
        Width = 70
        Height = 16
        Alignment = taRightJustify
        AutoSize = False
        DataField = 'MAI_'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        BeforePrint = FormatarValor
      end
      object RLDBText8: TRLDBText
        Tag = 10
        Left = 1006
        Top = 4
        Width = 70
        Height = 16
        Alignment = taRightJustify
        AutoSize = False
        DataField = 'DEZ_'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        BeforePrint = FormatarValor
      end
      object RLDBText9: TRLDBText
        Tag = 10
        Left = 928
        Top = 4
        Width = 70
        Height = 16
        Alignment = taRightJustify
        AutoSize = False
        DataField = 'NOV_'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        BeforePrint = FormatarValor
      end
      object RLDBText10: TRLDBText
        Tag = 10
        Left = 851
        Top = 4
        Width = 70
        Height = 16
        Alignment = taRightJustify
        AutoSize = False
        DataField = 'OUT_'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        BeforePrint = FormatarValor
      end
      object RLDBText11: TRLDBText
        Tag = 10
        Left = 774
        Top = 4
        Width = 70
        Height = 16
        Alignment = taRightJustify
        AutoSize = False
        DataField = 'SET_'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        BeforePrint = FormatarValor
      end
    end
    inherited RLBand3: TRLBand
      Width = 1085
    end
  end
  inherited FiltroExcel: TRLXLSFilter
    Left = 1043
    Top = 67
  end
end
