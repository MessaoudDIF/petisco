object FoodApp: TFoodApp
  Left = 593
  Top = 172
  Width = 1057
  Height = 779
  Caption = 'Petisco'
  Color = 16763283
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  WindowState = wsMaximized
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object ScrollBox: TScrollBox
    Left = 225
    Top = 0
    Width = 816
    Height = 741
    Align = alClient
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = bsNone
    TabOrder = 0
    OnResize = ScrollBoxResize
  end
  object pnlCommand: TPanel
    Left = 0
    Top = 0
    Width = 225
    Height = 741
    Align = alLeft
    BevelOuter = bvNone
    Color = 10178048
    TabOrder = 1
  end
end
