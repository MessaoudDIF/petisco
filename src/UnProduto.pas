unit UnProduto;

interface

uses Classes;

type
  TipoDeProduto = (tdpComprado, tdpProduzido);

  TProduto = class
  private
    FCodigo: string;
    FDescricao: string;
    { TODO: implementar tipo de produto fabricado ou comprado
    FTipoDeProduto: TipoDeProduto;
    }
    FValor: Real;
  public
    constructor Create(const Codigo: string; const Descricao: string; const Valor: Real); reintroduce;
    function GetCodigo: string;
    function GetDescricao: string;
    function GetValor: Real;
  end;

  TItem = class
  private
    FIdentificacao: string;
    FProduto: TProduto;
    FNumeroPedidos: Integer;
    FPedidos: array of Real;
  public
    function AumentarQuantidadeEm(const Aumento: Real): TItem;
    function Identificacao(const Identificacao: string): TItem;
    function ObterIdentificacao: string;
    function ObterProduto: TProduto;
    function ObterQuantidade: Real;
    function Produto(const Produto: TProduto): TItem;
    function Quantidade(const Quantidade: Integer): TItem;
  end;

implementation

{ TProduto }
constructor TProduto.Create(const Codigo, Descricao: string; const Valor: Real);
begin
  Self.FCodigo := Codigo;
  Self.FDescricao := Descricao;
  Self.FValor := Valor;
end;

function TProduto.GetCodigo: string;
begin
  Result := Self.FCodigo
end;

function TProduto.GetDescricao: string;
begin
  Result := Self.FDescricao
end;

function TProduto.GetValor: Real;
begin
  Result := Self.FValor
end;

{ TItem }

function TItem.AumentarQuantidadeEm(const Aumento: Real): TItem;
begin
  Self.FNumeroPedidos := Self.FNumeroPedidos + 1;
  SetLength(Self.FPedidos, Self.FNumeroPedidos);
  Self.FPedidos[Self.FNumeroPedidos-1] := Aumento;
  Result := Self;
end;

function TItem.Identificacao(const Identificacao: string): TItem;
begin
  Self.FIdentificacao := Identificacao;
  Result := Self;
end;

function TItem.ObterIdentificacao: string;
begin
  Result := Self.FIdentificacao;
end;

function TItem.ObterProduto: TProduto;
begin
  Result := Self.FProduto;
end;

function TItem.ObterQuantidade: Real;
var
  i: Integer;
begin
  Result := 0;
  for i := 0 to Self.FNumeroPedidos-1 do
    Result := Result + Self.FPedidos[i]
end;

function TItem.Produto(const Produto: TProduto): TItem;
begin
  Self.FProduto := Produto;
  Result := Self;
end;

function TItem.Quantidade(const Quantidade: Integer): TItem;
begin
  Self.AumentarQuantidadeEm(Quantidade);
  Result := Self;
end;

end.
