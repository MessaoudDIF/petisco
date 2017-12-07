object ComandaDetalheView: TComandaDetalheView
  Left = 0
  Top = 0
  Caption = 'Detalhes de Produtos Consumidos na Comanda'
  ClientHeight = 613
  ClientWidth = 993
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object pnlDesktop: TPanel
    Left = 0
    Top = 0
    Width = 776
    Height = 613
    Align = alClient
    BevelOuter = bvNone
    Color = clWhite
    TabOrder = 0
    ExplicitTop = -13
    ExplicitWidth = 782
    ExplicitHeight = 621
    object Panel8: TPanel
      Left = 16
      Top = 10
      Width = 750
      Height = 41
      Alignment = taLeftJustify
      BevelOuter = bvNone
      Caption = '    Produtos Consumidos'
      Color = 8562945
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
      Top = 563
      Width = 750
      Height = 41
      Alignment = taLeftJustify
      BevelOuter = bvNone
      Caption = '    Valor Total '
      Color = 8562945
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -21
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentBackground = False
      ParentFont = False
      TabOrder = 1
      object lblPagamentos: TLabel
        Left = 691
        Top = 4
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
    object gDetalhe: TDBGrid
      Left = 16
      Top = 57
      Width = 750
      Height = 496
      Ctl3D = False
      DrawingStyle = gdsClassic
      FixedColor = 8562945
      Font.Charset = ANSI_CHARSET
      Font.Color = clTeal
      Font.Height = -19
      Font.Name = 'Segoe UI'
      Font.Style = []
      Options = [dgTitles, dgColumnResize, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 2
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clWhite
      TitleFont.Height = -19
      TitleFont.Name = 'Segoe UI Emoji'
      TitleFont.Style = []
    end
  end
  object pnlCommand: TJvPanel
    Left = 776
    Top = 0
    Width = 217
    Height = 613
    Align = alRight
    BevelOuter = bvNone
    Color = 8562945
    TabOrder = 1
    ExplicitLeft = 696
    ExplicitTop = -13
    ExplicitHeight = 621
    object btnOk: TPanel
      Left = 16
      Top = 10
      Width = 185
      Height = 41
      BevelOuter = bvNone
      BorderWidth = 1
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
  end
end
