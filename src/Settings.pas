unit Settings;

interface

uses SysUtils, Classes,
  { Fluente }
  Util;

type
  TSettings = class(TObject)
  private
    FSettings: TStringList;
  public
    constructor Create(const CaminhoArquivoConfiguracao: string); reintroduce;
    function save(const Key, Value: string): TSettings;
    function get(const Key: string): string;
  end;

implementation

{ TSettings }

constructor TSettings.Create(const CaminhoArquivoConfiguracao: string);
var
  _i: Integer;
  _arquivo: TStringList;
begin
  inherited Create;
  Self.FSettings := TStringList.Create;
  if FileExists(CaminhoArquivoConfiguracao) then
  begin
    _arquivo := TStringList.Create();
    try
      _arquivo.LoadFromFile(CaminhoArquivoConfiguracao);
      for _i := 0 to _arquivo.Count-1 do
      begin
        Self.FSettings.AddObject(
          Copy(_arquivo[_i], 1, Pos('=', _arquivo[_i]) -1),
          TValor.Create()
            .Texto(Copy(_arquivo[_i], Pos('=', _arquivo[_i])+1, 1024))) ;
      end;
    finally
      FreeAndNil(_arquivo);
    end;
  end;

end;

function TSettings.get(const Key: string): string;
begin
  // Self.FSettings.TryGetValue(Key, Result)
end;

function TSettings.save(const Key, Value: string): TSettings;
begin
  // Self.FSettings.AddOrSetValue(Key, Value);
  Result := Self
end;

end.
