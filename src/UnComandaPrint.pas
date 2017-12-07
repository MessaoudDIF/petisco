unit UnComandaPrint;

interface

uses Classes, Printers,
  { Fluente }
  UnComandaModelo;

type
  TUnidadeDeMedidaDaImpressao = (umiMilimetros, umiCaracteres);

  TAlinhamentoDaImpressao = (adiEsquerda, adiDireira, adiCentralizado);

  TDispositivoDeImpressao  = (ddiTela, ddiImpressora);

  TComandaPrint = class
  private
    FAlinhamento: TAlinhamentoDaImpressao;
    FComandaModelo: TComandaModelo;
    FDispositivo: TDispositivoDeImpressao;
    FLarguraImpressao: Integer;
    FImprimirDiretamente: Boolean;
    FImpressaoExpandida: Boolean;
    FSpool: TStringList;
    FUnidadeDeMedidaDaLarguraDeImpressao: TUnidadeDeMedidaDaImpressao;
  protected
    procedure ImprimirArquivoTexto;
  public
    function AlinharADireita: TComandaPrint;
    function AlinharAEsquerda: TComandaPrint;
    function AtivarExpandido: TComandaPrint;
    function ComandaModelo(const ComandaModelo: TComandaModelo): TComandaPrint;
    function DefinirLarguraDaImpressaoEmCaracteres(
      const LarguraEmCaracteres: Integer): TComandaPrint;
    function DefinirLarguraDaImpressaoEmMilimetros(
      const LarguraEmMilimetros: Integer): TComandaPrint;
    function DesativarExpandido: TComandaPrint;
    function Descarregar: TComandaPrint;
    function DesligarImpressaoDireta: TComandaPrint;
    function DispositivoParaImpressao(
      const Dispositivo: TDispositivoDeImpressao): TComandaPrint;
    function FinalizarImpressao: TComandaPrint;
    function Imprimir(const Texto: string): TComandaPrint;
    function ImprimirLinha(const Texto: string): TComandaPrint;
    function IniciarImpressao: TComandaPrint;
    function LigarImpressaoDireta: TComandaPrint;
    function Preparar: TComandaPrint;
  end;

implementation

uses
  { Fluente }
  UnImpressao, SysUtils;

{ TComandaPrint }

function TComandaPrint.AlinharADireita: TComandaPrint;
begin
  Self.FAlinhamento := adiDireira;
  Result := Self;
end;

function TComandaPrint.AlinharAEsquerda: TComandaPrint;
begin
  Self.FAlinhamento := adiEsquerda;
  Result := Self;
end;

function TComandaPrint.AtivarExpandido: TComandaPrint;
begin
  Self.FImpressaoExpandida := True;
  Result := Self;
end;

function TComandaPrint.ComandaModelo(
  const ComandaModelo: TComandaModelo): TComandaPrint;
begin
  Self.FComandaModelo := ComandaModelo;
  Result := Self;
end;

function TComandaPrint.DefinirLarguraDaImpressaoEmCaracteres(
  const LarguraEmCaracteres: Integer): TComandaPrint;
begin
  Self.FLarguraImpressao := LarguraEmCaracteres;
  Self.FUnidadeDeMedidaDaLarguraDeImpressao := umiCaracteres;
  Result := Self;
end;

function TComandaPrint.DefinirLarguraDaImpressaoEmMilimetros(
  const LarguraEmMilimetros: Integer): TComandaPrint;
begin
  Self.FLarguraImpressao := LarguraEmMilimetros;
  Self.FUnidadeDeMedidaDaLarguraDeImpressao := umiMilimetros;
  Result := Self;
end;

function TComandaPrint.DesativarExpandido: TComandaPrint;
begin
  Self.FImpressaoExpandida := False;
  Result := Self;
end;

function TComandaPrint.Descarregar: TComandaPrint;
begin
  Result := Self;
end;

function TComandaPrint.DesligarImpressaoDireta: TComandaPrint;
begin
  Self.FImprimirDiretamente := False;
  Result := Self;
end;

function TComandaPrint.DispositivoParaImpressao(
  const Dispositivo: TDispositivoDeImpressao): TComandaPrint;
begin          
  Self.FDispositivo := Dispositivo;
  Result := Self;
end;

function TComandaPrint.FinalizarImpressao: TComandaPrint;
var
  _i: Integer;
  _saida: TImpressaoView;
begin
  if FileExists('.\system\virtualprinter.sys') then
  begin
    _saida := TImpressaoView.Create(nil);
    try
      for _i := 0 to Self.FSpool.Count-1 do
        _saida.Impressao.Lines.Add(Self.FSpool[_i]);
      _saida.ShowModal;
    finally
      _saida.descarregar;
      FreeAndNil(_saida);
    end;
  end
  else
    Self.ImprimirArquivoTexto;
  Result := Self;
end;

function TComandaPrint.Imprimir(const Texto: string): TComandaPrint;
begin
  Self.FSpool[Self.FSpool.Count-1] := Self.FSpool[Self.FSpool.Count-1] + Texto; 
  Result := Self;
end;

procedure TComandaPrint.ImprimirArquivoTexto;
var
  _arquivoTexto : TextFile;
  _i: Integer;
begin
  AssignPrn(_arquivoTexto);
  Rewrite(_arquivoTexto);
  for _i := 0 to Self.FSpool.Count-1 do
    Writeln(_arquivoTexto, Self.FSpool[_i]);
  CloseFile(_arquivoTexto);
end;

function TComandaPrint.ImprimirLinha(const Texto: string): TComandaPrint;
begin
  Self.FSpool.Add(Texto);
  Result := Self;
end;

function TComandaPrint.IniciarImpressao: TComandaPrint;
begin
  Result := Self;
end;

function TComandaPrint.LigarImpressaoDireta: TComandaPrint;
begin
  Self.FImprimirDiretamente := True;
  Result := Self;
end;

function TComandaPrint.Preparar: TComandaPrint;
begin
  Self.FSpool := TStringList.Create;
  Result := Self;
end;

end.
