object FechamentoDeContaView: TFechamentoDeContaView
  Left = 220
  Top = 26
  BorderStyle = bsDialog
  Caption = 'Fechamento de Contas'
  ClientHeight = 638
  ClientWidth = 952
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlComandos: TJvPanel
    Left = 735
    Top = 0
    Width = 217
    Height = 638
    Align = alRight
    BevelOuter = bvNone
    Color = 8562945
    TabOrder = 1
    object Label2: TLabel
      Left = 44
      Top = 391
      Width = 131
      Height = 30
      Caption = 'Acr'#233'scimo  %'
      Color = clWhite
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -21
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    object btnOk: TPanel
      Left = 16
      Top = 15
      Width = 185
      Height = 41
      BevelOuter = bvNone
      BorderStyle = bsSingle
      Caption = 'Ok'
      Color = clWhite
      Ctl3D = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clTeal
      Font.Height = -21
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentBackground = False
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 0
      OnClick = btnOkClick
    end
    object btnImprimir: TPanel
      Left = 16
      Top = 62
      Width = 185
      Height = 41
      BevelOuter = bvNone
      BorderStyle = bsSingle
      Caption = 'Imprimir'
      Color = clWhite
      Ctl3D = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clTeal
      Font.Height = -21
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentBackground = False
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 1
      OnClick = btnImprimirClick
    end
    object btnLancarDebito: TPanel
      Left = 16
      Top = 114
      Width = 185
      Height = 41
      BevelOuter = bvNone
      BorderStyle = bsSingle
      Caption = 'Lan'#231'ar D'#233'bito ...'
      Color = clWhite
      Ctl3D = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clTeal
      Font.Height = -21
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentBackground = False
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 2
      OnClick = btnLancarDebitoClick
    end
    object btnLancarCredito: TPanel
      Left = 16
      Top = 167
      Width = 185
      Height = 41
      BevelOuter = bvNone
      BorderStyle = bsSingle
      Caption = 'Lan'#231'ar Cr'#233'dito ...'
      Color = clWhite
      Ctl3D = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clTeal
      Font.Height = -21
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentBackground = False
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 3
      OnClick = btnLancarCreditoClick
    end
    object btnLancarDinheiro: TPanel
      Left = 16
      Top = 219
      Width = 185
      Height = 41
      BevelOuter = bvNone
      BorderStyle = bsSingle
      Caption = 'Lan'#231'ar Dinheiro ...'
      Color = clWhite
      Ctl3D = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clTeal
      Font.Height = -21
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentBackground = False
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 4
      OnClick = btnLancarDinheiroClick
    end
    object btnVisualizarPagamentos: TPanel
      Left = 16
      Top = 272
      Width = 185
      Height = 41
      BevelOuter = bvNone
      BorderStyle = bsSingle
      Caption = 'Pagamentos ...'
      Color = clWhite
      Ctl3D = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clTeal
      Font.Height = -21
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentBackground = False
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 5
      OnClick = btnVisualizarPagamentosClick
    end
    object btnFecharConta: TPanel
      Left = 16
      Top = 325
      Width = 185
      Height = 41
      BevelOuter = bvNone
      BorderStyle = bsSingle
      Caption = 'Fechar Conta ...'
      Color = clWhite
      Ctl3D = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clTeal
      Font.Height = -21
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentBackground = False
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 6
      OnClick = btnFecharContaClick
    end
    object pnlDetalheView: TPanel
      Left = 16
      Top = 512
      Width = 186
      Height = 119
      BevelOuter = bvNone
      Color = 16181992
      TabOrder = 7
      object DetalheView: TMemo
        Left = 0
        Top = 0
        Width = 186
        Height = 119
        Align = alClient
        Alignment = taCenter
        BevelInner = bvNone
        BevelOuter = bvNone
        BorderStyle = bsNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clTeal
        Font.Height = -21
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
      end
    end
    object btnDecAcrescimo: TButton
      Left = 33
      Top = 426
      Width = 40
      Height = 40
      Caption = '-'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 8266522
      Font.Height = -32
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 8
      OnClick = btnDecAcrescimoClick
    end
    object txtAcrescimo: TJvValidateEdit
      Left = 88
      Top = 427
      Width = 45
      Height = 38
      AllowEmpty = True
      Flat = True
      ParentFlat = False
      CriticalPoints.MaxValueIncluded = False
      CriticalPoints.MinValueIncluded = False
      EditText = '0'
      Font.Charset = ANSI_CHARSET
      Font.Color = clTeal
      Font.Height = -24
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 9
    end
    object btnIncAcrescimo: TButton
      Left = 145
      Top = 426
      Width = 40
      Height = 40
      Caption = '+'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 8266522
      Font.Height = -32
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 10
      OnClick = btnIncAcrescimoClick
    end
  end
  object pnlDesktop: TPanel
    Left = 0
    Top = 0
    Width = 735
    Height = 638
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object pnlCliente: TPanel
      Left = 0
      Top = 51
      Width = 735
      Height = 84
      Align = alTop
      BevelOuter = bvNone
      Color = clWhite
      ParentBackground = False
      TabOrder = 0
      object lblCliente: TLabel
        Left = 32
        Top = -2
        Width = 64
        Height = 30
        Caption = 'Cliente'
        Font.Charset = ANSI_CHARSET
        Font.Color = clTeal
        Font.Height = -21
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object EdtCliente: TEdit
        Left = 32
        Top = 27
        Width = 617
        Height = 19
        HelpType = htKeyword
        HelpKeyword = 'CL_COD'
        CharCase = ecUpperCase
        Ctl3D = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clTeal
        Font.Height = -24
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 0
      end
      object EdtOid: TEdit
        Left = 3
        Top = 27
        Width = 11
        Height = 19
        HelpType = htKeyword
        HelpKeyword = 'pro_des'
        CharCase = ecUpperCase
        Ctl3D = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -24
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 1
        Visible = False
      end
      object EdtCod: TEdit
        Left = 18
        Top = 27
        Width = 11
        Height = 19
        HelpType = htKeyword
        HelpKeyword = 'pro_des'
        CharCase = ecUpperCase
        Ctl3D = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -24
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 2
        Visible = False
      end
    end
    object pnlTitulo: TPanel
      Left = 0
      Top = 0
      Width = 735
      Height = 51
      Align = alTop
      BevelOuter = bvNone
      Color = 8562945
      ParentBackground = False
      TabOrder = 1
      object lblIdComanda: TLabel
        Left = 11
        Top = 11
        Width = 204
        Height = 30
        Caption = 'Fechamento de Conta'
        Font.Charset = ANSI_CHARSET
        Font.Color = 16181992
        Font.Height = -21
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
    end
    object pnlSumario: TPanel
      Left = 0
      Top = 509
      Width = 735
      Height = 129
      Align = alBottom
      Color = clWhite
      ParentBackground = False
      TabOrder = 2
      object Panel6: TPanel
        Left = 8
        Top = 6
        Width = 719
        Height = 35
        Alignment = taLeftJustify
        BevelOuter = bvNone
        Caption = '    Total em Aberto'
        Color = 8562945
        Font.Charset = ANSI_CHARSET
        Font.Color = 16181992
        Font.Height = -24
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentBackground = False
        ParentFont = False
        TabOrder = 0
        object lblTotalEmAberto: TLabel
          Left = 655
          Top = 2
          Width = 38
          Height = 30
          Alignment = taRightJustify
          Caption = '0,00'
          Font.Charset = ANSI_CHARSET
          Font.Color = 16181992
          Font.Height = -21
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
        end
      end
      object Panel7: TPanel
        Left = 8
        Top = 86
        Width = 719
        Height = 35
        Alignment = taLeftJustify
        BevelOuter = bvNone
        Caption = '    Saldo'
        Color = 8562945
        Font.Charset = ANSI_CHARSET
        Font.Color = 16181992
        Font.Height = -24
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentBackground = False
        ParentFont = False
        TabOrder = 1
        object lblSaldo: TLabel
          Left = 655
          Top = 2
          Width = 38
          Height = 30
          Alignment = taRightJustify
          Caption = '0,00'
          Font.Charset = ANSI_CHARSET
          Font.Color = 16181992
          Font.Height = -21
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
        end
      end
      object Panel3: TPanel
        Left = 8
        Top = 46
        Width = 719
        Height = 35
        Alignment = taLeftJustify
        BevelOuter = bvNone
        Caption = '    Pagamentos'
        Color = 8562945
        Font.Charset = ANSI_CHARSET
        Font.Color = 16181992
        Font.Height = -24
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentBackground = False
        ParentFont = False
        TabOrder = 2
        object lblPagamentos: TLabel
          Left = 655
          Top = 2
          Width = 38
          Height = 30
          Alignment = taRightJustify
          Caption = '0,00'
          Font.Charset = ANSI_CHARSET
          Font.Color = 16181992
          Font.Height = -21
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
        end
      end
    end
    object gConta: TDBGrid
      Left = 0
      Top = 135
      Width = 735
      Height = 374
      Align = alClient
      Ctl3D = False
      DrawingStyle = gdsClassic
      FixedColor = 8562945
      Font.Charset = ANSI_CHARSET
      Font.Color = clTeal
      Font.Height = -21
      Font.Name = 'Segoe UI'
      Font.Style = []
      Options = [dgTitles, dgColumnResize, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 3
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clWhite
      TitleFont.Height = -19
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = []
      OnDblClick = gContaDblClick
    end
  end
  object pnlClientePesquisa: TPanel
    Left = 38
    Top = 119
    Width = 627
    Height = 16
    BevelOuter = bvNone
    BorderStyle = bsSingle
    Color = clWhite
    Ctl3D = False
    ParentBackground = False
    ParentCtl3D = False
    TabOrder = 2
    Visible = False
  end
end
