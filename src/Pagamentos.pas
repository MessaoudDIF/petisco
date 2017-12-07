unit Pagamentos;

interface

uses
  { Fluente }
  Util;

type
  IPagamentoDinheiro = interface
  ['{81C9D4FB-BE52-48F5-9DCA-A6DA609E6B75}']
    function Parametros: TMap;
    procedure RegistrarPagamentoEmDinheiro(const Parametros: TMap);
  end;

  IPagamentoCartaoDeDebito = interface
  ['{2EB6B1D5-B28A-4A4D-9A57-244ABC0F8218}']
    function Parametros: TMap;
    procedure RegistrarPagamentoCartaoDeDebito(const Parametros: TMap);
  end;

  IPagamentoCartaoDeCredito = interface
  ['{F95F08EA-76C0-4505-B6CA-AC15A0E8B702}']
    function Parametros: TMap;
    procedure RegistrarPagamentoCartaoDeCredito(const Parametros: TMap);
  end;

implementation

end.
