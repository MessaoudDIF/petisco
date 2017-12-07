object ImpressaoView: TImpressaoView
  Left = 786
  Top = 230
  Caption = 'Impress'#227'o'
  ClientHeight = 711
  ClientWidth = 440
  Color = clCream
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Impressao: TRichEdit
    Left = 0
    Top = 49
    Width = 440
    Height = 662
    Align = alClient
    BevelInner = bvNone
    BevelOuter = bvNone
    Color = clCream
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Courier New'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    Zoom = 100
  end
  object pnlCommandBar: TPanel
    Left = 0
    Top = 0
    Width = 440
    Height = 49
    Align = alTop
    BevelOuter = bvNone
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 1
    object Button1: TButton
      Left = 16
      Top = 12
      Width = 75
      Height = 25
      Caption = 'Imprimir'
      TabOrder = 0
      OnClick = Button1Click
    end
  end
end
