unit UnAbrirComandaView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, DB,
  { JEDI }
  JvExStdCtrls, JvEdit, JvExControls, JvButton, Vcl.Mask, JvExMask,
  JvToolEdit, JvTransparentButton, JvComponentBase, JvEnterTab, JvLinkLabel,
  { Fluente }
  Util, UnComandaModelo, SearchUtil, UnModelo, UnTeclado;

type
  TAbrirComandaView = class(TForm)
    lblCliente: TLabel;
    lblMesa: TLabel;
    EdtCliente: TEdit;
    btnOk: TPanel;
    EdtMesa: TJvComboEdit;
    pnlClientePesquisa: TPanel;
    procedure btnOkClick(Sender: TObject);
    procedure EdtMesaEnter(Sender: TObject);
    procedure EdtMesaExit(Sender: TObject);
    procedure EdtClienteExit(Sender: TObject);
    procedure EdtClienteEnter(Sender: TObject);
    procedure EdtMesaButtonClick(Sender: TObject);
  private
    FClienteSearch: TPesquisa;
    FComandaModelo: TComandaModelo;
    FTeclado: TTeclado;
  protected
    function EhAberturaValida: Boolean;
    function GetTeclado(Sender: TObject): TTeclado;
  public
    constructor Create(const ComandaModelo: TComandaModelo); reintroduce; overload;
    function Preparar: TAbrirComandaView;
    procedure ProcessarSelecaoDeCliente(Pesquisa: TObject);
  end;

implementation

{$R *.dfm}

procedure TAbrirComandaView.btnOkClick(Sender: TObject);
begin
  Self.btnOk.SetFocus;
  if Self.EhAberturaValida then
  begin
    Self.FComandaModelo := nil;
    Self.ModalResult := mrOk;
  end
  else
    TMessages.Mensagem('Favor informar: ' +
      #13 + ' - Uma mesa, ' +
      #13 + ' - Selecionar um cliente cadastrado,  ou ' +
      #13 + ' - Informar o nome de um cliente!');
end;

constructor TAbrirComandaView.Create(const ComandaModelo: TComandaModelo);
begin
  inherited Create(nil);
  Self.FComandaModelo := ComandaModelo;
end;

procedure TAbrirComandaView.EdtClienteEnter(Sender: TObject);
begin
  Self.GetTeclado(Sender).Exibir;
end;

procedure TAbrirComandaView.EdtClienteExit(Sender: TObject);
var
  _nomeDoCliente: string;
begin
  _nomeDoCliente := TEdit(Sender).Text;
  try
    if _nomeDoCliente <> '' then
      Self.FComandaModelo
        .Parametros
          .Gravar('cl_cod', _nomeDoCliente);
  finally
    _nomeDoCliente := '';
  end;
  if Self.FTeclado <> nil then
    Self.FTeclado.Visible := False;
end;

procedure TAbrirComandaView.EdtMesaButtonClick(Sender: TObject);
begin
  Self.GetTeclado(Sender).Exibir;
end;

procedure TAbrirComandaView.EdtMesaEnter(Sender: TObject);
begin
  Self.GetTeclado(Sender).Exibir;
end;

procedure TAbrirComandaView.EdtMesaExit(Sender: TObject);
begin
  if Self.EdtMesa.Text <> '' then begin
    Self.btnOk.SetFocus;
  end;
  if Self.FTeclado <> nil then
    Self.FTeclado.Visible := False;
end;

function TAbrirComandaView.EhAberturaValida: Boolean;
begin
  Result := False;
  if (Self.EdtMesa.Text <> '') then begin
    Result := True;
    Self.FComandaModelo.Parametros.Gravar('mesa', Self.EdtMesa.Text);
  end
  else
    if Self.EdtCliente.Text <> '' then
      Result := True;
end;

function TAbrirComandaView.GetTeclado(Sender: TObject): TTeclado;
begin
  if Self.FTeclado = nil then
  begin
    Self.FTeclado := TTeclado.Create(nil);
    Self.FTeclado.Left := 15;
    Self.FTeclado.Top := Self.Height - Self.FTeclado.Height - 30;
    Self.FTeclado.Parent := Self;
  end;
  Self.FTeclado.ControleDeEdicao(Sender as TCustomEdit);
  Result := Self.FTeclado;
end;

function TAbrirComandaView.Preparar: TAbrirComandaView;
begin
  Result := Self;
  Self.FClienteSearch := TConstrutorDePesquisas
    .Formulario(Self)
    .ControleDeEdicao(Self.edtCliente)
    .PainelDePesquisa(Self.pnlClientePesquisa)
    .Modelo('ClientePesquisaModelo')
    .AcaoAposSelecao(Self.ProcessarSelecaoDeCliente)
    .Construir;
end;

procedure TAbrirComandaView.ProcessarSelecaoDeCliente(Pesquisa: TObject);
begin
  TUtil.AtualizarCampoDeEdicao(Self.EdtCliente, TPesquisa(Pesquisa).Modelo.DataSet.FieldByName('cl_cod').AsString);
  Self.FComandaModelo
    .Parametros
      .Gravar('cl_oid', TPesquisa(Pesquisa).Modelo.DataSet.FieldByName('cl_oid').AsString)
      .Gravar('cl_cod', TPesquisa(Pesquisa).Modelo.DataSet.FieldByName('cl_cod').AsString);
end;

end.
