unit UnFoodModel;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Data.SqlExpr, Data.FMTBcd,
  Datasnap.Provider, Datasnap.DBClient, Data.DBXFirebird,
  DBXpress, FMTBcd, DB, SqlExpr, Classes;

type
  TPetiscoModel = class(TDataModule)
    cnn: TSQLConnection;
    Sql: TSQLDataSet;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PetiscoModel: TPetiscoModel;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
