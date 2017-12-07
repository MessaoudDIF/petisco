unit Relatorios;

interface

uses DB, RLReport,
  { helsonsant }
  UnModelo;

type
  IReport = interface
    ['{9D658823-447A-4AF3-A641-F037899D9C2F}']
    function Dados(const Dados: TDataSource): IReport;
    function Modelo(const Modelo: TModelo): IReport;
    function ObterRelatorio: TRLReport;
    function Subtitulo(const Subtitulo: string): IReport;
    function Titulo(const Titulo: string): IReport;
  end;

implementation

end.
 