unit UnMovimentoDeContaCorrenteImpressaoView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, JvExControls, JvButton, JvTransparentButton, StdCtrls,
  Mask, JvExMask, JvToolEdit, JvMaskEdit, JvCheckedMaskEdit, JvDatePickerEdit,
  { helsonsant }
  Util, DataUtil, UnModelo, UnAplicacao,
  UnMovimentoDeContaCorrenteListaRegistrosModelo;

type
  TMovimentoDeContaCorrenteImpressaoView = class(TForm, ITela)
    Panel1: TPanel;
    btnGravar: TJvTransparentButton;
    txtInicio: TJvDatePickerEdit;
    Label1: TLabel;
    Label2: TLabel;
    txtFim: TJvDatePickerEdit;
    Label3: TLabel;
    txtTipo: TComboBox;
  private
    FControlador: IResposta;
    FMovimentoDeContaCorrenteListaRegistrosModelo:
      TMovimentoDeContaCorrenteListaRegistrosModelo;
  public
    function Descarregar: ITela;
    function Controlador(const Controlador: IResposta): ITela;
    function Modelo(const Modelo: TModelo): ITela;
    function Preparar: ITela;
    function ExibirTela: Integer;
  end;

var
  MovimentoDeContaCorrenteImpressaoView: TMovimentoDeContaCorrenteImpressaoView;

implementation

{$R *.dfm}

{ TForm1 }

function TMovimentoDeContaCorrenteImpressaoView.Controlador(const Controlador: IResposta): ITela;
begin
  Self.FControlador := Controlador;
  Result := Self;
end;

function TMovimentoDeContaCorrenteImpressaoView.Descarregar: ITela;
begin
  Self.FControlador := nil;
  Self.FMovimentoDeContaCorrenteListaRegistrosModelo := nil;
  Result := Self;
end;

function TMovimentoDeContaCorrenteImpressaoView.ExibirTela: Integer;
begin
  Result := Self.ShowModal;
end;

function TMovimentoDeContaCorrenteImpressaoView.Modelo(const Modelo: TModelo): ITela;
begin
  Self.FMovimentoDeContaCorrenteListaRegistrosModelo :=
    (Modelo as TMovimentoDeContaCorrenteListaRegistrosModelo);
  Result := Self;
end;

function TMovimentoDeContaCorrenteImpressaoView.Preparar: ITela;
var
  _parametros: TMap;
  _inicio, _fim: TDateTime;
begin
  _parametros := Self.FMovimentoDeContaCorrenteListaRegistrosModelo.Parametros;
  _inicio := StrToDate(_parametros.Ler('inicio').ComoTexto);
  _fim := StrToDate(_parametros.Ler('fim').ComoTexto);
  Self.txtInicio.Date := _inicio;
  Self.txtFim.Date := _fim;
  Result := Self;
end;

end.
