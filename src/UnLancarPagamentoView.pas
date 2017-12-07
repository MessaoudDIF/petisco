unit UnLancarPagamentoView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  { Fluente }
  UnComandaModel, UnComandaController,
  Controls, ExtCtrls, StdCtrls, Classes;

type
  TLancarPagamentoView = class(TForm)
    Label1: TLabel;
    edtProduto: TEdit;
    Label2: TLabel;
    Edit1: TEdit;
    btnOk: TPanel;
    btnFechar: TPanel;
    procedure btnOkClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
  private
    FComandaModel: TComandaModel;
    FComandaController: TComandaController;
  public
    constructor Create(const ComandaModel: TComandaModel;
      const ComandaController: TComandaController); reintroduce;
  end;

var
  LancarPagamentoView: TLancarPagamentoView;

implementation

{$R *.dfm}

constructor TLancarPagamentoView.Create(const ComandaModel: TComandaModel; const ComandaController: TComandaController);
begin
  inherited Create(nil);
  Self.FComandaModel := ComandaModel;
  Self.FComandaController := ComandaController;
end;

procedure TLancarPagamentoView.btnFecharClick(Sender: TObject);
begin
  Self.ModalResult := mrCancel;
end;

procedure TLancarPagamentoView.btnOkClick(Sender: TObject);
begin
  Self.ModalResult := mrOk;
end;

end.
