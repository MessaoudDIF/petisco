unit UnDividirView;

interface

uses
  SysUtils, Controls, ExtCtrls, StdCtrls, Classes, Forms, JvExStdCtrls, JvEdit,
  JvValidateEdit,
  { Fluente }
  UnModelo, UnTeclado;

type
  TDividirView = class(TForm)
    Label1: TLabel;
    edtDivisao: TJvValidateEdit;
    btnOk: TPanel;
    Label2: TLabel;
    edtTotal: TJvValidateEdit;
    procedure btnOkClick(Sender: TObject);
    procedure edtDivisaoEnter(Sender: TObject);
    procedure edtDivisaoExit(Sender: TObject);
  strict private
    FModelo: TModelo;
    FTeclado: TTeclado;
  public
    function Modelo(const Modelo: TModelo): TDividirView;
    function Descarregar: TDividirView;
    function Preparar: TDividirView;
  end;

var
  DividirView: TDividirView;

implementation

{$R *.dfm}

procedure TDividirView.btnOkClick(Sender: TObject);
begin
  if (Self.EdtDivisao.Text <> '') and (StrToInt(Self.EdtDivisao.Text) > 1) then
    Self.FModelo.Parametros.Gravar('divisao',
      Self.edtDivisao.Text + ' x ' +
      FormatFloat('0.00', StrToFloat(Self.edtTotal.Text) /
      StrToInt(Self.edtDivisao.Text)));
  Self.ModalResult := mrOk;
end;

function TDividirView.Modelo(const Modelo: TModelo): TDividirView;
begin
  Self.FModelo := Modelo;
  Result := Self;
end;

function TDividirView.Descarregar: TDividirView;
begin
  Self.FModelo := nil;
  Result := Self;
end;

procedure TDividirView.edtDivisaoEnter(Sender: TObject);
begin
  if Self.FTeclado = nil then
  begin
    Self.FTeclado := TTeclado.Create(nil);
    Self.FTeclado.Top := Self.Height - Self.FTeclado.Height;
    Self.FTeclado.Parent := Self;
    Self.FTeclado.ControleDeEdicao(Sender as TCustomEdit);
  end;
  Self.FTeclado.Visible := True;
end;

procedure TDividirView.edtDivisaoExit(Sender: TObject);
begin
  if Self.edtDivisao.Text <> '' then begin
    Self.btnOk.SetFocus;
  end;
  if Self.FTeclado <> nil then
    Self.FTeclado.Visible := True;
end;

function TDividirView.Preparar: TDividirView;
begin
  Self.edtTotal.Value :=
    Self.FModelo.DataSet.FieldByName('coma_saldo').AsFloat;
  Result := Self;
end;

end.
