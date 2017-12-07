object FecharContaView: TFecharContaView
  Left = 799
  Top = 244
  BorderStyle = bsDialog
  Caption = 'FecharContaView'
  ClientHeight = 544
  ClientWidth = 823
  Color = 16766378
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object pnlDesktop: TPanel
    Left = 0
    Top = 0
    Width = 606
    Height = 544
    Align = alClient
    BevelOuter = bvNone
    Color = 16181992
    TabOrder = 0
    object Panel8: TPanel
      Left = 16
      Top = 10
      Width = 577
      Height = 41
      Alignment = taLeftJustify
      BevelOuter = bvNone
      Caption = '    CONSUMO'
      Color = 8266522
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -21
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentBackground = False
      ParentFont = False
      TabOrder = 0
    end
    object Panel9: TPanel
      Left = 16
      Top = 427
      Width = 577
      Height = 41
      Alignment = taLeftJustify
      BevelOuter = bvNone
      Caption = '    SALDO A PAGAR'
      Color = 8266522
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -21
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentBackground = False
      ParentFont = False
      TabOrder = 1
    end
    object Panel10: TPanel
      Left = 16
      Top = 486
      Width = 577
      Height = 41
      Alignment = taLeftJustify
      BevelOuter = bvNone
      Caption = '    SALDO ATUAL'
      Color = 8266522
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -21
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentBackground = False
      ParentFont = False
      TabOrder = 2
    end
    object gConsumo: TDBGrid
      Left = 16
      Top = 57
      Width = 577
      Height = 364
      Ctl3D = False
      FixedColor = 16181992
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Segoe UI'
      Font.Style = []
      Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 3
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -19
      TitleFont.Name = 'Segoe UI Emoji'
      TitleFont.Style = []
    end
  end
  object JvPanel1: TJvPanel
    Left = 606
    Top = 0
    Width = 217
    Height = 544
    Align = alRight
    Color = 8266522
    TabOrder = 1
    object pnlDetalheView: TPanel
      Left = 16
      Top = 427
      Width = 186
      Height = 100
      BevelOuter = bvNone
      Color = 16181992
      TabOrder = 0
      object DetalheView: TMemo
        Left = 0
        Top = 0
        Width = 186
        Height = 100
        Align = alClient
        BevelInner = bvNone
        BevelOuter = bvNone
        BorderStyle = bsNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
      end
    end
    object btnDividir: TPanel
      Left = 16
      Top = 10
      Width = 185
      Height = 41
      BevelOuter = bvNone
      Caption = 'Dividir'
      Color = 16752269
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -21
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = btnDividirClick
    end
    object btnLancarDebito: TPanel
      Left = 16
      Top = 58
      Width = 185
      Height = 41
      BevelOuter = bvNone
      Caption = 'Lan'#231'ar D'#233'bito ...'
      Color = 16752269
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -21
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = btnLancarDebitoClick
    end
    object btnLancarCredito: TPanel
      Left = 16
      Top = 106
      Width = 185
      Height = 41
      BevelOuter = bvNone
      Caption = 'Lan'#231'ar Cr'#233'dito ...'
      Color = 16752269
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -21
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnClick = btnLancarCreditoClick
    end
    object btnLancarDinheiro: TPanel
      Left = 16
      Top = 154
      Width = 185
      Height = 41
      BevelOuter = bvNone
      Caption = 'Lan'#231'ar Dinheiro ...'
      Color = 16752269
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -21
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      OnClick = btnLancarDinheiroClick
    end
    object btnVisualizarPagamentos: TPanel
      Left = 16
      Top = 202
      Width = 185
      Height = 41
      BevelOuter = bvNone
      Caption = 'Pagamentos ...'
      Color = 16752269
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -21
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
    end
    object btnFecharConta: TPanel
      Left = 16
      Top = 250
      Width = 185
      Height = 41
      BevelOuter = bvNone
      Caption = 'Fechar Conta ...'
      Color = 16752269
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -21
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
    end
  end
end
