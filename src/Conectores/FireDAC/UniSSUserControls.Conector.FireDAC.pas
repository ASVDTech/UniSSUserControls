unit UniSSUserControls.Conector.FireDAC;

interface

uses
  Classes,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.VCLUI.Wait,
  FireDAC.Stan.Param,
  FireDAC.DatS,
  FireDAC.DApt.Intf,
  FireDAC.DApt,
  Data.DB,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TConectorFireDAC = class
  strict private
    FConnection: TFDConnection;
  public
    constructor Create(pConnection: TFDConnection);

    procedure ExecutarSQL(const pSQL: string; const pParametros: TStringList);
  end;

implementation

{ TConectorFireDAC }

constructor TConectorFireDAC.Create(pConnection: TFDConnection);
begin
  FConnection := pConnection;
end;

procedure TConectorFireDAC.ExecutarSQL(const pSQL: string; const pParametros: TStringList);
var
  lQryExecutar: TFDQuery;
  lI: Integer;
begin
  lQryExecutar := TFDQuery.Create(nil);
  try
    lQryExecutar.Connection := FConnection;
    lQryExecutar.Active := False;
    lQryExecutar.SQL.Add(pSQL);
    for lI := 0 to pParametros.Count - 1 do
    begin
      lQryExecutar.Params[lI].Value := pParametros[lI];
    end;
    lQryExecutar.ExecSQL;
  finally
    lQryExecutar.Free;
  end;
end;

end.
