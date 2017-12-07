unit UnContaPagarRegistroView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, JvExMask, JvToolEdit, JvDBControls, StdCtrls, Mask, DBCtrls,
  JvExControls, JvLinkLabel, JvComponentBase, JvBalloonHint,
  { Fluente }
  Util, DataUtil, UnModel, Componentes, Menus, JvButton,
  JvTransparentButton, ExtCtrls;

type
  TForm1 = class(TForm)
    lblCL_OID: TJvLinkLabel;
    txtFORN_NOME: TDBEdit;
    JvLinkLabel2: TJvLinkLabel;
    txtTIT_DOC: TDBEdit;
    JvLinkLabel3: TJvLinkLabel;
    txtTIT_EMIS: TJvDBDateEdit;
    JvLinkLabel4: TJvLinkLabel;
    txtTIT_VENC: TJvDBDateEdit;
    JvLinkLabel5: TJvLinkLabel;
    txtTIT_VALOR: TDBEdit;
    JvLinkLabel7: TJvLinkLabel;
    txtCATS_DES: TDBEdit;
    JvLinkLabel10: TJvLinkLabel;
    txtCRES_DESCR: TDBEdit;
    JvLinkLabel12: TJvLinkLabel;
    txtTIT_HIST: TDBEdit;
    JvLinkLabel20: TJvLinkLabel;
    txtTIT_LIQ: TJvDBDateEdit;
    JvLinkLabel23: TJvLinkLabel;
    txtTIT_VLPAGO: TDBEdit;
    Panel1: TPanel;
    btnGravar: TJvTransparentButton;
    JvTransparentButton2: TJvTransparentButton;
    PopupMenu: TPopupMenu;
    A1: TMenuItem;
    b1: TMenuItem;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

end.
