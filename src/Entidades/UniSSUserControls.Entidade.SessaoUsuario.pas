unit UniSSUserControls.Entidade.SessaoUsuario;

interface

uses
  Generics.Collections;

type
  TSessaoUsuario = class
  strict private
    FIDUsuario: Integer;
    FIDSession: string;
    FDataEntrada: TDateTime;
    FDataSaida: TDateTime;
    FIPAdress: string;
    FCamposCustomizados: TDictionary<string, Variant>;
  public
    constructor Create;
    destructor Destroy; override;

    property IDUsuario: Integer read FIDUsuario write FIDUsuario;
    property IDSession: string read FIDSession write FIDSession;
    property DataEntrada: TDateTime read FDataEntrada write FDataEntrada;
    property DataSaida: TDateTime read FDataSaida write FDataSaida;
    property IPAdress: string read FIPAdress write FIPAdress;
    property CamposCustomizados: TDictionary<string, Variant> read FCamposCustomizados write FCamposCustomizados;
  end;

implementation

{ TSessaoUsuario }

constructor TSessaoUsuario.Create;
begin
  inherited;
  FCamposCustomizados := TDictionary<string, Variant>.Create;
end;

destructor TSessaoUsuario.Destroy;
begin
  FCamposCustomizados.Free;
  inherited;
end;

end.
