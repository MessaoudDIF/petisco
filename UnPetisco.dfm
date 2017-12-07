object PetiscoView: TPetiscoView
  Left = 334
  Top = 0
  Width = 986
  Height = 735
  Caption = 'PetiscoView'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  WindowState = wsMaximized
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pnlCommand: TJvPanel
    Left = 0
    Top = 0
    Width = 217
    Height = 696
    Align = alLeft
    BevelOuter = bvNone
    Color = 8266522
    TabOrder = 0
    object Panel1: TPanel
      Left = 16
      Top = 10
      Width = 185
      Height = 41
      BevelOuter = bvNone
      Caption = 'Caixa'
      Color = 16752269
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -21
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object Panel2: TPanel
      Left = 16
      Top = 58
      Width = 185
      Height = 41
      BevelOuter = bvNone
      Caption = 'Contas'
      Color = 16752269
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -21
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object Panel3: TPanel
      Left = 16
      Top = 106
      Width = 185
      Height = 41
      BevelOuter = bvNone
      Caption = 'Produtos'
      Color = 16752269
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -21
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
    object Panel4: TPanel
      Left = 16
      Top = 154
      Width = 185
      Height = 41
      BevelOuter = bvNone
      Caption = 'Configura'#231#245'es'
      Color = 16752269
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -21
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
    end
  end
  object pnlDesktop: TJvPanel
    Left = 217
    Top = 0
    Width = 753
    Height = 696
    FlatBorder = True
    ArrangeSettings.BorderLeft = 15
    ArrangeSettings.BorderTop = 15
    ArrangeSettings.DistanceVertical = 20
    ArrangeSettings.DistanceHorizontal = 20
    ArrangeSettings.AutoArrange = True
    Align = alClient
    BevelOuter = bvNone
    Color = 16181992
    TabOrder = 1
  end
end
