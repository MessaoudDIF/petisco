object CaixaListaRegistrosView: TCaixaListaRegistrosView
  Left = 443
  Top = 190
  Width = 908
  Height = 545
  Caption = 'Movimento de Caixa'
  Color = 16181992
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 892
    Height = 41
    Align = alTop
    Alignment = taLeftJustify
    Caption = '  Movimento de Caixa'
    Color = 8266522
    Font.Charset = ANSI_CHARSET
    Font.Color = 16181992
    Font.Height = -21
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
  end
  object pnlDesktop: TPanel
    Left = 0
    Top = 41
    Width = 892
    Height = 465
    Align = alClient
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 1
    object pnlFiltro: TPanel
      Left = 0
      Top = 0
      Width = 892
      Height = 49
      Align = alTop
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 0
    end
    object DBGrid1: TDBGrid
      Left = 0
      Top = 49
      Width = 892
      Height = 416
      Align = alClient
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
    end
    object JvPanel1: TJvPanel
      Left = 808
      Top = 416
      Width = 73
      Height = 41
      Transparent = True
      BevelOuter = bvNone
      TabOrder = 2
      object Image1: TImage
        Left = 0
        Top = 0
        Width = 73
        Height = 41
        Align = alClient
        Picture.Data = {
          055449636F6E0000010001002020100000000000E80200001600000028000000
          2000000040000000010004000000000080020000000000000000000000000000
          0000000000000000000080000080000000808000800000008000800080800000
          80808000C0C0C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000
          FFFFFF0000000000000000000000000000000000000000000000007777770000
          0000000000000000000000000007000000000000000000000000000000070000
          0000000000000000000000777007000000000000000000077070007770070000
          7000000000000077000700787000000007000000000007708000077877000070
          00700000000007088807777777770777000700000000008F88877FFFFF077887
          70070000000000088888F88888FF08870070000000000000880888877778F070
          00700000000777088888880007778F770077777000700008F088007777077F07
          000000700700008F08880800077778F7700000700708888F0880F08F807078F7
          777700700708F88F0780F070F07078F7887700700708888F0780F077807088F7
          777700700700008F0788FF00080888F77000007000000008F0780FFFF0088F77
          0070000000000008F07788000888887700700000000000008F07788888880870
          00700000000000088FF0077788088887000700000000008F888FF00000F87887
          7007000000000708F8088FFFFF88078700700000000007708000088888000070
          0700000000000077007000888007000070000000000000077700008F80070007
          0000000000000000000000888007000000000000000000000000000000070000
          0000000000000000000007777777000000000000000000000000000000000000
          00000000FFFFFFFFFFFC0FFFFFFC0FFFFFF80FFFFFF80FFFFE180E7FFC00043F
          F800001FF800000FF800000FFC00001FFE00001FE0000001C000000180000001
          80000001800000018000000180000001FC00001FFC00001FFE00001FFC00000F
          F800000FF800001FF800003FFC180C7FFE380EFFFFF80FFFFFF80FFFFFF80FFF
          FFFFFFFF}
      end
    end
  end
end
