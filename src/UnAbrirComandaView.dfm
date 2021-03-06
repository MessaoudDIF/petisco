object AbrirComandaView: TAbrirComandaView
  Left = 245
  Top = 162
  BorderStyle = bsDialog
  Caption = 'Abrir Comanda'
  ClientHeight = 571
  ClientWidth = 954
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object lblCliente: TLabel
    Left = 356
    Top = 16
    Width = 64
    Height = 30
    Caption = 'Cliente'
    Color = 8266522
    Font.Charset = ANSI_CHARSET
    Font.Color = clTeal
    Font.Height = -21
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    Transparent = True
  end
  object lblMesa: TLabel
    Left = 52
    Top = 16
    Width = 50
    Height = 30
    Caption = 'Mesa'
    Color = 8266522
    Font.Charset = ANSI_CHARSET
    Font.Color = clTeal
    Font.Height = -21
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    Transparent = True
  end
  object EdtCliente: TEdit
    Left = 356
    Top = 50
    Width = 297
    Height = 38
    HelpType = htKeyword
    HelpKeyword = 'cl_cod'
    BevelInner = bvNone
    BevelOuter = bvNone
    CharCase = ecUpperCase
    Ctl3D = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clTeal
    Font.Height = -24
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 1
    OnEnter = EdtClienteEnter
    OnExit = EdtClienteExit
  end
  object btnOk: TPanel
    Left = 687
    Top = 49
    Width = 160
    Height = 41
    BevelOuter = bvNone
    Caption = 'OK'
    Color = 8562945
    Font.Charset = ANSI_CHARSET
    Font.Color = 16181992
    Font.Height = -21
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentBackground = False
    ParentFont = False
    TabOrder = 2
    TabStop = True
    OnClick = btnOkClick
  end
  object EdtMesa: TJvComboEdit
    Left = 56
    Top = 52
    Width = 299
    Height = 38
    Alignment = taCenter
    BevelInner = bvNone
    BevelOuter = bvNone
    Flat = True
    ParentFlat = False
    ButtonFlat = True
    ButtonWidth = 40
    Font.Charset = ANSI_CHARSET
    Font.Color = clTeal
    Font.Height = -24
    Font.Name = 'Segoe UI'
    Font.Style = []
    Glyph.Data = {
      460A0000424D460A000000000000360000002800000025000000170000000100
      180000000000100A0000C40E0000C40E00000000000000000000FFFF00FFFF00
      FFFF00FFFF00AEA797A79F8EA8A08FA8A08FA8A08FA8A08FA8A08FA8A08FA8A0
      8FA8A08FA8A08FA8A08FA8A08FA8A08FA8A08FA8A08FA8A08FA8A08FA8A08FA8
      A08FA8A08FA8A08FA8A08FA8A08FA8A08FA8A08FA8A08FA79F8EABA494CDC8BF
      FFFF00FFFF00FFFF0000FFFF00FFFF0083775F6C5F4271644971644971644971
      6449716449716449716449716449716449716449716449716449716449716449
      7164497164497164497164497164497164497164497164497164497164497164
      497164497164497164497164496E614574674CFFFF00FFFF0000FFFF00847961
      73664B7063477F735A8C816B8B80698B80698B80698B80698B80698B80698B80
      698B80698B80698B80698B80698B80698B80698B80698B80698B80698B80698B
      80698B80698B80698B80698B80698B80698B80698B80698B816B8479616E6145
      75694E716549FFFF0000FFFF006C5E416F6246B8B2A4FFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFD2CDC56F6246706347B5AFA000AFA798716449
      80755DFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      9A917D716549887E6600A69E8C706348958C77FFFFFFBDB5A5BDB5A5BDB5A5BD
      B5A5FFFFFFFFFFFFBDB5A5BDB5A5BDB5A5BDB5A5BDB5A5BDB5A5BDB5A5BDB5A5
      BDB5A5BDB5A5BDB5A5BDB5A5BDB5A5FFFFFFBDB5A5BDB5A5BDB5A5BDB5A5FFFF
      FFBDB5A5BDB5A5BDB5A5BDB5A5FFFFFFB2AB9C7063487E725900A89F8E706348
      938A75FFFFFFBDB5A5BDB5A5BDB5A5BDB5A5FFFFFFFFFFFFBDB6A6C0B9AABDB5
      A5BDB5A5BDB5A5BDB5A5BDB5A5BDB5A5BDB5A5BDB5A5BDB5A5BBB3A3BDB5A5FF
      FFFFBDB5A5BCB4A4BDB5A5BDB5A5FFFFFFBDB5A5BDB5A5BDB5A5BDB5A5FFFFFF
      B0A9997063487F735B00A89F8E706348938A75FFFFFFBDB5A5BDB5A5BDB5A5BD
      B5A5FFFFFFFFFFFFBDB5A5BDB5A5BDB5A5BDB5A5BDB5A5BDB5A5BDB5A5BDB5A5
      BDB5A5BDB5A5BDB5A5BDB5A5BDB5A5FFFFFFBDB5A5BDB5A5BDB5A5BDB5A5FFFF
      FFBDB5A5BDB5A5BDB5A5BDB5A5FFFFFFB0A9997063487F735B00A89F8E706348
      938A75FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      B0A9997063487F735B00A89F8E706348938A75FFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFB0A9997063487F735B00A89F8E706348
      938A75FFFFFFBDB5A5BDB5A5BDB5A5BDB5A5FFFFFFBDB5A5BDB5A5BDB5A5BDB5
      A5FFFFFFBDB5A5BDB5A5BDB5A5BDB5A5FFFFFFBDB5A5BDB5A5BDB5A5BDB5A5FF
      FFFFBDB5A5BDB5A5BDB5A5BDB5A5FFFFFFBDB5A5BDB5A5BDB5A5BDB5A5FFFFFF
      B0A9997063487F735B00A89F8E706348938A75FFFFFFBDB5A5BDB5A5BDB5A5BD
      B5A5FFFFFFBDB5A5BDB6A6BDB5A5BDB5A5FFFFFFBDB5A5BAB2A1BCB4A4BDB5A5
      FFFFFFBDB5A5BBB3A2BBB3A3BDB5A5FFFFFFBDB5A5BCB4A4BDB5A5BDB5A5FFFF
      FFBDB5A5BDB5A5BDB5A5BDB5A5FFFFFFB0A9997063487F735B00A89F8E706348
      938A75FFFFFFBDB5A5BDB5A5BDB5A5BDB5A5FFFFFFBDB5A5BDB5A5BDB5A5BDB5
      A5FFFFFFBDB5A5BDB5A5BDB5A5BDB5A5FFFFFFBDB5A5BDB5A5BDB5A5BDB5A5FF
      FFFFBDB5A5BDB5A5BDB5A5BDB5A5FFFFFFBDB5A5BDB5A5BDB5A5BDB5A5FFFFFF
      B0A9997063487F735B00A89F8E706348938A75FFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFB0A9997063487F735B00A89F8E706348
      938A75FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      B0A9997063487F735B00A89F8E706348938A75FFFFFFBDB5A5BDB5A5BDB5A5BD
      B5A5FFFFFFBDB5A5BDB5A5BDB5A5BDB5A5FFFFFFBDB5A5BDB5A5BDB5A5BDB5A5
      FFFFFFBDB5A5BDB5A5BDB5A5BDB5A5FFFFFFBDB5A5BDB5A5BDB5A5BDB5A5FFFF
      FFBDB5A5BDB5A5BDB5A5BDB5A5FFFFFFB0A9997063487F735B00A89F8E706348
      938A75FFFFFFBDB5A5BDB5A5BDB5A5BDB5A5FFFFFFBDB5A5BDB5A5BDB5A5BDB5
      A5FFFFFFBDB5A5BDB5A5BCB4A4BDB5A5FFFFFFBDB5A5BDB5A5BDB5A5BDB5A5FF
      FFFFBDB5A5BDB5A5BDB5A5BDB5A5FFFFFFBDB5A5BDB5A5BDB5A5BDB5A5FFFFFF
      B0A9997063487F735B00A69E8C706348958C77FFFFFFBDB5A5BDB5A5BDB5A5BD
      B5A5FFFFFFBDB5A5BDB5A5BDB5A5BDB5A5FFFFFFBDB5A5BDB5A5BDB5A5BDB5A5
      FFFFFFBDB5A5BDB5A5BDB5A5BDB5A5FFFFFFBDB5A5BDB5A5BDB5A5BDB5A5FFFF
      FFBDB5A5BDB5A5BDB5A5BDB5A5FFFFFFB2AB9C7063487E725900AFA898716448
      81755DFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      9A917D716549887E6600FFFF006B5E426F6246B9B3A6FFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFD2CEC56F6246706347B5AFA000FFFF00837861
      73664B7063477F745B8C816B8B80698B80698B80698B80698B80698B80698B80
      698B80698B80698B80698B80698B80698B80698B80698B80698B80698B80698B
      80698B80698B80698B80698B80698B80698B80698B80698B816B8479616E6145
      76694E716449FFFF0000FFFF00FFFF0081775E6C5F4271654971644971644971
      6449716449716449716449716449716449716449716449716449716449716449
      7164497164497164497164497164497164497164497164497164497164497164
      497164497164497164497164496E614573684CFFFF00FFFF0000FFFF00FFFF00
      FFFF00FFFF00AEA697A7A08EA8A08FA8A08FA8A08FA8A08FA8A08FA8A08FA8A0
      8FA8A08FA8A08FA8A08FA8A08FA8A08FA8A08FA8A08FA8A08FA8A08FA8A08FA8
      A08FA8A08FA8A08FA8A08FA8A08FA8A08FA8A08FA8A08FA79F8EABA393CCC8BE
      FFFF00FFFF00FFFF0000}
    ParentFont = False
    TabOrder = 0
    Text = ''
    OnButtonClick = EdtMesaButtonClick
    OnEnter = EdtMesaEnter
    OnExit = EdtMesaExit
    NumbersOnly = True
  end
  object pnlClientePesquisa: TPanel
    Left = 361
    Top = 89
    Width = 518
    Height = 16
    BevelOuter = bvNone
    BorderWidth = 1
    BorderStyle = bsSingle
    Color = clWhite
    Ctl3D = False
    ParentBackground = False
    ParentCtl3D = False
    TabOrder = 3
    Visible = False
  end
end
