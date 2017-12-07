object MenuView: TMenuView
  Left = 568
  Top = 135
  BorderStyle = bsNone
  Caption = 'MenuView'
  ClientHeight = 468
  ClientWidth = 561
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
    Width = 561
    Height = 468
    Align = alClient
    BevelOuter = bvNone
    BorderStyle = bsSingle
    Color = clWhite
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 0
    object lblMensagem: TLabel
      Left = 0
      Top = 92
      Width = 559
      Height = 25
      Align = alTop
      Caption = '...'
      Font.Charset = ANSI_CHARSET
      Font.Color = clGray
      Font.Height = -19
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      ExplicitWidth = 12
    end
    object pnlTitle: TPanel
      Left = 0
      Top = 0
      Width = 559
      Height = 42
      Align = alTop
      BevelOuter = bvNone
      Color = clWhite
      TabOrder = 0
      object btnFechar: TSpeedButton
        Left = 508
        Top = 0
        Width = 51
        Height = 42
        Align = alRight
        Caption = 'X'
        Flat = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clGray
        Font.Height = -27
        Font.Name = 'Swis721 Ex BT'
        Font.Style = []
        ParentFont = False
        OnClick = btnFecharClick
      end
    end
    object pnlCaption: TPanel
      Left = 0
      Top = 42
      Width = 559
      Height = 50
      Align = alTop
      Alignment = taLeftJustify
      BevelOuter = bvNone
      BorderWidth = 15
      Caption = 'Selecione sua op'#231#227'o:'
      Color = clWhite
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowFrame
      Font.Height = -21
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentBackground = False
      ParentFont = False
      TabOrder = 1
    end
    object pnlFooter: TPanel
      Left = 0
      Top = 417
      Width = 559
      Height = 49
      Align = alBottom
      BevelOuter = bvNone
      Color = clWhite
      TabOrder = 2
    end
    object pnlOpcoes: TJvPanel
      Left = 0
      Top = 117
      Width = 559
      Height = 300
      Align = alClient
      BevelOuter = bvNone
      BorderWidth = 15
      Color = clWhite
      TabOrder = 3
    end
  end
end
