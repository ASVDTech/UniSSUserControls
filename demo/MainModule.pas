unit MainModule;

interface

uses
  uniGUIMainModule,
  SysUtils,
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
  Data.DB,
  FireDAC.Comp.Client,
  FireDAC.Stan.Param,
  FireDAC.DatS,
  FireDAC.DApt.Intf,
  FireDAC.DApt,
  FireDAC.Comp.DataSet, uniGUIBaseClasses, uniGUIClasses, UniSSUserControls.TUniSSUserControls;

type
  TUniMainModule = class(TUniGUIMainModule)
    Connection: TFDConnection;
    qryUsuario: TFDQuery;
    UniSSUserControls1: TUniSSUserControls;
    procedure UniGUIMainModuleCreate(Sender: TObject);
    procedure UniGUIMainModuleDestroy(Sender: TObject);
    procedure UniGUIMainModuleBrowserClose(Sender: TObject);
  private
    { Private declarations }
    FIdUsuario: Integer;
    procedure CarregarParametrosSaida;
  public
    { Public declarations }
    function Logar(const pUsuario: string; const pSenha: string): Boolean;
    property IDUsuario: Integer read FIDUsuario write FIDUsuario;
  end;

function UniMainModule: TUniMainModule;

implementation

{$R *.dfm}

uses
  UniGUIVars, ServerModule, uniGUIApplication, Main;

function UniMainModule: TUniMainModule;
begin
  Result := TUniMainModule(UniApplication.UniMainModule)
end;

procedure TUniMainModule.CarregarParametrosSaida;
begin
  UniSSUserControls1.ParametrosSQLFinalizar.Clear;
  UniSSUserControls1.ParametrosSQLFinalizar.Add(FormatDateTime('dd/mm/yyyy hh:nn:ss', Now));
  UniSSUserControls1.ParametrosSQLFinalizar.Add(TStatusSessao.Inativo.ToInteger.ToString);
  UniSSUserControls1.ParametrosSQLFinalizar.Add(UniMainModule.IDUsuario.ToString);
end;

function TUniMainModule.Logar(const pUsuario, pSenha: string): Boolean;
begin
  Result := False;
  qryUsuario.Active := False;
  qryUsuario.ParamByName('login').AsString := pUsuario;
  qryUsuario.ParamByName('senha').AsString := pSenha;
  qryUsuario.Active := True;
  if qryUsuario.RecordCount > 0 then
  begin
    FIdUsuario := qryUsuario.FieldByName('id_usuario').AsInteger;
    Result := True;
  end;
end;

procedure TUniMainModule.UniGUIMainModuleBrowserClose(Sender: TObject);
begin
  CarregarParametrosSaida;
  UniSSUserControls1.FinalizarSessao;
end;

procedure TUniMainModule.UniGUIMainModuleCreate(Sender: TObject);
begin
  Connection.Connected := False;
  Connection.DriverName := 'SQLite';
  Connection.Params.Add('Database=' + ExtractFilePath(ParamStr(0)) + 'Banco.db');
  Connection.Connected := True;
end;

procedure TUniMainModule.UniGUIMainModuleDestroy(Sender: TObject);
begin
  Connection.Connected := False;
end;

initialization
  RegisterMainModuleClass(TUniMainModule);
end.
