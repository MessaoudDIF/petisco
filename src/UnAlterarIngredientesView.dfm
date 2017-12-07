object Form6: TForm6
  Left = 0
  Top = 0
  Width = 725
  Height = 579
  Caption = 'Alterar Ingredientes'
  Color = 16766378
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
    Width = 709
    Height = 541
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object Panel1: TPanel
      Left = 0
      Top = 0
      Width = 709
      Height = 89
      Align = alTop
      BevelOuter = bvNone
      Color = 9129746
      ParentBackground = False
      TabOrder = 0
      object Label1: TLabel
        Left = 8
        Top = 0
        Width = 69
        Height = 30
        Caption = 'Pedido'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -21
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object edtProduto: TEdit
        Left = 8
        Top = 29
        Width = 511
        Height = 40
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -24
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
    end
    object ScrollBox: TScrollBox
      Left = 0
      Top = 89
      Width = 709
      Height = 452
      Align = alClient
      BevelEdges = []
      BevelInner = bvNone
      BevelOuter = bvNone
      BorderStyle = bsNone
      TabOrder = 1
    end
  end
end
