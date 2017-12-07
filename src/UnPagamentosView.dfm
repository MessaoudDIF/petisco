object PagamentosView: TPagamentosView
  Left = 297
  Top = 234
  BorderStyle = bsDialog
  Caption = 'Pagamentos Realizados'
  ClientHeight = 621
  ClientWidth = 999
  Color = 16181992
  Ctl3D = False
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object pnlCommand: TJvPanel
    Left = 782
    Top = 0
    Width = 217
    Height = 621
    Align = alRight
    BevelOuter = bvNone
    Color = 8562945
    TabOrder = 0
    object btnOk: TPanel
      Left = 16
      Top = 10
      Width = 185
      Height = 41
      BevelOuter = bvNone
      BorderStyle = bsSingle
      Caption = 'Ok'
      Color = clWhite
      Font.Charset = ANSI_CHARSET
      Font.Color = clTeal
      Font.Height = -21
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentBackground = False
      ParentFont = False
      TabOrder = 0
      OnClick = btnOkClick
    end
  end
  object pnlDesktop: TPanel
    Left = 0
    Top = 0
    Width = 782
    Height = 621
    Align = alClient
    BevelOuter = bvNone
    Color = clWhite
    TabOrder = 1
    object Panel8: TPanel
      Left = 16
      Top = 10
      Width = 750
      Height = 41
      Alignment = taLeftJustify
      BevelOuter = bvNone
      Caption = '    Pagamentos Realizados'
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
      Caption = '    Valor Total de Pagamentos'
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
    object gPagamentos: TDBGrid
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
end
