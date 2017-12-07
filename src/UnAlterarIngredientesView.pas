unit UnAlterarIngredientesView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Forms, StdCtrls, Controls, Classes, ExtCtrls;

type
  TForm6 = class(TForm)
    pnlDesktop: TPanel;
    Panel1: TPanel;
    Label1: TLabel;
    edtProduto: TEdit;
    ScrollBox: TScrollBox;
    procedure btnOkClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form6: TForm6;

implementation

{$R *.dfm}

procedure TForm6.btnOkClick(Sender: TObject);
begin
  Self.ModalResult := mrOk;
end;

procedure TForm6.btnFecharClick(Sender: TObject);
begin
  Self.ModalResult := mrCancel;
end;

end.
