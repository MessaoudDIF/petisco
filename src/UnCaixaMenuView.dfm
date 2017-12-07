object CaixaMenuView: TCaixaMenuView
  Left = 563
  Top = 202
  BorderStyle = bsNone
  Caption = 'Op'#231#245'es de Caixa'
  ClientHeight = 545
  ClientWidth = 461
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object pnlDesktop: TPanel
    Left = 0
    Top = 0
    Width = 461
    Height = 545
    Align = alClient
    BevelOuter = bvNone
    BorderStyle = bsSingle
    Color = clWhite
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 0
    object btnAbertura: TPanel
      Left = 70
      Top = 60
      Width = 320
      Height = 41
      BevelOuter = bvNone
      Caption = 'Abertura de Caixa'
      Color = 8562945
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -19
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentBackground = False
      ParentFont = False
      TabOrder = 0
      OnClick = btnAberturaClick
    end
    object btnTroco: TPanel
      Left = 70
      Top = 125
      Width = 320
      Height = 41
      BevelOuter = bvNone
      Caption = 'Troco'
      Color = 8562945
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -19
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentBackground = False
      ParentFont = False
      TabOrder = 1
      OnClick = btnTrocoClick
    end
    object btnSaida: TPanel
      Left = 70
      Top = 191
      Width = 320
      Height = 41
      BevelOuter = bvNone
      Caption = 'Sa'#237'da'
      Color = 8562945
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -19
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentBackground = False
      ParentFont = False
      TabOrder = 2
      OnClick = btnSaidaClick
    end
    object btnSuprimento: TPanel
      Left = 70
      Top = 256
      Width = 320
      Height = 41
      BevelOuter = bvNone
      Caption = 'Suprimento'
      Color = 8562945
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -19
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentBackground = False
      ParentFont = False
      TabOrder = 3
      OnClick = btnSuprimentoClick
    end
    object btnSangria: TPanel
      Left = 70
      Top = 322
      Width = 320
      Height = 41
      BevelOuter = bvNone
      Caption = 'Sangria'
      Color = 8562945
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -19
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentBackground = False
      ParentFont = False
      TabOrder = 4
      OnClick = btnSangriaClick
    end
    object btnFechamento: TPanel
      Left = 70
      Top = 388
      Width = 320
      Height = 41
      BevelOuter = bvNone
      Caption = 'Fechamento'
      Color = 8562945
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -19
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentBackground = False
      ParentFont = False
      TabOrder = 5
      OnClick = btnFechamentoClick
    end
    object pnlTitle: TPanel
      Left = 0
      Top = 0
      Width = 459
      Height = 42
      Align = alTop
      BevelOuter = bvNone
      Color = clWhite
      ParentBackground = False
      TabOrder = 6
      object btnFechar: TJvTransparentButton
        Left = 408
        Top = 0
        Width = 51
        Height = 42
        Align = alRight
        BorderWidth = 0
        Caption = 'X'
        Font.Charset = ANSI_CHARSET
        Font.Color = clGray
        Font.Height = -19
        Font.Name = 'Swis721 Ex BT'
        Font.Style = []
        HotTrackFont.Charset = ANSI_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -19
        HotTrackFont.Name = 'Swis721 Ex BT'
        HotTrackFont.Style = []
        FrameStyle = fsNone
        ParentFont = False
        OnClick = btnFecharClick
      end
    end
    object btnExtrato: TPanel
      Left = 70
      Top = 452
      Width = 320
      Height = 41
      BevelOuter = bvNone
      Caption = 'Extrato de Caixa'
      Color = 8562945
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -19
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentBackground = False
      ParentFont = False
      TabOrder = 7
      OnClick = btnExtratoClick
    end
  end
end
