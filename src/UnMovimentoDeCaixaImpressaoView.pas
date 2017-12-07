unit UnMovimentoDeCaixaImpressaoView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, JvExMask, JvToolEdit, JvMaskEdit,
  JvCheckedMaskEdit, JvDatePickerEdit, JvExControls, JvButton,
  JvTransparentButton, ExtCtrls,
  { helsonsant }
  Util, DataUtil, UnModelo, UnAplicacao, UnMovimentoDeCaixaListaRegistrosModelo; 

type
  TMovimentoDeCaixaImpressaoView = class(TForm, ITela)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Panel1: TPanel;
    btnGravar: TJvTransparentButton;
    txtInicio: TJvDatePickerEdit;
    txtFim: TJvDatePickerEdit;
    txtTipo: TComboBox;
  private
    FControlador: IResposta;
    FMovimentoDeCaixaListaRegistrosModelo: TMovimentoDeCaixaListaRegistrosModelo;
  public
    function Descarregar: ITela;
    function Controlador(const Controlador: IResposta): ITela;
    function Modelo(const Modelo: TModelo): ITela;
    function Preparar: ITela;
    function ExibirTela: Integer;
  end;

var
  MovimentoDeCaixaImpressaoView: TMovimentoDeCaixaImpressaoView;

implementation

{$R *.dfm}

{ TMovimentoDeCaixaImpressaoView }

function TMovimentoDeCaixaImpressaoView.Controlador(
  const Controlador: IResposta): ITela;
begin
  Self.FControlador := Controlador;
  Result := Self;
end;

function TMovimentoDeCaixaImpressaoView.Descarregar: ITela;
begin
  Self.FControlador := nil;
  Self.FMovimentoDeCaixaListaRegistrosModelo := nil;
  Result := Self;
end;

function TMovimentoDeCaixaImpressaoView.ExibirTela: Integer;
begin
  Result := Self.ShowModal;
end;

function TMovimentoDeCaixaImpressaoView.Modelo(
  const Modelo: TModelo): ITela;
begin
  Self.FMovimentoDeCaixaListaRegistrosModelo :=
    (Modelo as TMovimentoDeCaixaListaRegistrosModelo);
  Result := Self;
end;

function TMovimentoDeCaixaImpressaoView.Preparar: ITela;
begin
  Result := Self;
end;

end.
