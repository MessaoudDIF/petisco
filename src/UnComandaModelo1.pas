unit UnComandaModelo1;

interface

uses
  SysUtils, Classes, FMTBcd, DB, SqlExpr, DBClient, Provider, DBXpress,
  { Fluente }
  Util, DataUtil, Configuracoes, UnModelo;


type
  TComandaModelo = class(TModelo)
  public
    procedure AbrirComanda(const Cliente: string; const Mesa: string);
    procedure CarregarComanda(const Identificacao: string);
    procedure FecharComanda;
    procedure InserirItem(const ProdutoOid: string; const ValorUnitario,
      Quantidade, Total: Real);
    procedure InserirPagamento;
    procedure LimparComanda;
    procedure SalvarComanda;
    procedure TotalizaComanda;
  end;

var
  ComandaModelo: TComandaModelo;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}


end.
