unit UnPagamentos;

interface

uses
  { Fluente }
  Util;

type
  IPagamentoDinheiro = interface
    procedure RegistrarPagamentoEmDinheiro(const Parametros: TMap);
  end;

implementation

end.
