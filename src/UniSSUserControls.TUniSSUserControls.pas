unit UniSSUserControls.TUniSSUserControls;

interface

uses
  System.SysUtils,
  System.Classes,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Stan.Error,
  FireDAC.DatS,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf,
  FireDAC.Stan.Async,
  FireDAC.DApt,
  Data.DB,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  uniGUIBaseClasses,
  uniGUIClasses,
  uniGUIForm,
  UniSSUserControls.Utils.Geral,
  UniSSUserControls.Entidade.SessaoUsuario, uniGUIApplication;

const
  ABOUT = 'Arthur Steinbach';
  VERSION = '1.0.0';

type
  TUniSSUserControls = class(TUniComponent)
  strict private
    { Private declarations }
    FConnection: TFDConnection;
    FTipoControle: TTipoControle;
    FTipoConector: TTipoConector;
    FSQLIniciarSessao: TStringList;
    FParametrosSQLIniciar: TStringList;
    FSQLFinalizarSessao: TStringList;
    FParametrosSQLFinalizar: TStringList;
  strict protected
    { Protected declarations }
    function GetAbout: string;
    function GetVersion: string;

    function GetConnection: TFDConnection;
    procedure SetConnection(const pValor: TFDConnection);

    function GetTipoControle: TTipoControle;
    procedure SetTipoControle(const pValor: TTipoControle);

    function GetSQLIniciarSessao: TStringList;
    procedure SetSQLIniciarSessao(const pValor: TStringList);

    function GetParametrosSQLIniciar: TStringList;
    procedure SetParametrosSQLIniciar(const pValor: TStringList);

    function GetSQLFinalizarSessao: TStringList;
    procedure SetSQLFinalizarSessao(const pValor: TStringList);

    function GetParametrosSQLFinalizar: TStringList;
    procedure SetParametrosSQLFinalizar(const pValor: TStringList);

    function GetTipoConector: TTipoConector;
    procedure SetTipoConector(const pValor: TTipoConector);
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    procedure CarregarControleFimSessao(const pSessao: TUniGUISession);

    function CriarUsuarioSessao: TSessaoUsuario;
    procedure IniciarSessao(const pSessao: TSessaoUsuario = nil);
    procedure GravarInicioSessao;
    procedure GravarFimSessao;
    procedure FinalizarSessao(const pSessao: TSessaoUsuario = nil);
  published
    { Published declarations }
    property About: string read GetAbout;
    property Versao: string read GetVersion;

    property Connection: TFDConnection read GetConnection write SetConnection;
    property TipoControle: TTipoControle read GetTipoControle write SetTipoControle;
    property TipoConector: TTipoConector read GetTipoConector write SetTipoConector;
    property SQLIniciarSessao: TStringList read GetSQLIniciarSessao write SetSQLIniciarSessao;
    property ParametrosSQLIniciar: TStringList read GetParametrosSQLIniciar write SetParametrosSQLIniciar;
    property SQLFinalizarSessao: TStringList read GetSQLFinalizarSessao write SetSQLFinalizarSessao;
    property ParametrosSQLFinalizar: TStringList read GetParametrosSQLFinalizar write SetParametrosSQLFinalizar;
  end;

procedure Register;

implementation

uses
  UniSSUserControls.Conector.FireDAC;

procedure Register;
begin
  RegisterComponents('SteinSoft', [TUniSSUserControls]);
end;

{ TUniSSUserControls }

procedure TUniSSUserControls.CarregarControleFimSessao(const pSessao: TUniGUISession);
begin
  pSessao.AddJS('window.onbeforeunload = function() { ajaxRequest(MainForm.form, "SessionClosing", []); }');
end;

constructor TUniSSUserControls.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FSQLIniciarSessao := TStringList.Create;
  FParametrosSQLIniciar := TStringList.Create;
  FSQLFinalizarSessao := TStringList.Create;
  FParametrosSQLFinalizar := TStringList.Create;
end;

function TUniSSUserControls.CriarUsuarioSessao: TSessaoUsuario;
begin
  Result := TSessaoUsuario.Create;
end;

procedure TUniSSUserControls.FinalizarSessao(const pSessao: TSessaoUsuario);
begin
  case FTipoControle of
    Memoria: ;
    BancoDados:
      begin
        GravarFimSessao;
      end;
  end;
end;

function TUniSSUserControls.GetAbout: string;
begin
  Result := ABOUT;
end;

function TUniSSUserControls.GetConnection: TFDConnection;
begin
  Result := FConnection;
end;

function TUniSSUserControls.GetParametrosSQLFinalizar: TStringList;
begin
  Result := FParametrosSQLFinalizar;
end;

function TUniSSUserControls.GetParametrosSQLIniciar: TStringList;
begin
  Result := FParametrosSQLIniciar;
end;

function TUniSSUserControls.GetSQLFinalizarSessao: TStringList;
begin
  Result := FSQLFinalizarSessao;
end;

function TUniSSUserControls.GetSQLIniciarSessao: TStringList;
begin
  Result := FSQLIniciarSessao;
end;

function TUniSSUserControls.GetTipoConector: TTipoConector;
begin
  Result := FTipoConector;
end;

function TUniSSUserControls.GetTipoControle: TTipoControle;
begin
  Result := FTipoControle;
end;

function TUniSSUserControls.GetVersion: string;
begin
  Result := VERSION;
end;

procedure TUniSSUserControls.GravarFimSessao;
var
  lConectorFireDAC: TConectorFireDAC;
begin
  lConectorFireDAC := TConectorFireDAC.Create(FConnection);
  try
    lConectorFireDAC.ExecutarSQL(FSQLFinalizarSessao.Text, FParametrosSQLFinalizar);
  finally
    lConectorFireDAC.Free;
  end;
end;

procedure TUniSSUserControls.GravarInicioSessao;
var
  lConectorFireDAC: TConectorFireDAC;
begin
  lConectorFireDAC := TConectorFireDAC.Create(FConnection);
  try
    lConectorFireDAC.ExecutarSQL(FSQLIniciarSessao.Text, FParametrosSQLIniciar);
  finally
    lConectorFireDAC.Free;
  end;
end;

procedure TUniSSUserControls.IniciarSessao(const pSessao: TSessaoUsuario);
begin
  case FTipoControle of
    Memoria:
      begin

      end;
    BancoDados:
      begin
        GravarInicioSessao;
      end;
  end;
end;

procedure TUniSSUserControls.SetConnection(const pValor: TFDConnection);
begin
  FConnection := pValor;
end;

procedure TUniSSUserControls.SetParametrosSQLFinalizar(const pValor: TStringList);
begin
  FParametrosSQLFinalizar := pValor;
end;

procedure TUniSSUserControls.SetParametrosSQLIniciar(const pValor: TStringList);
begin
  FParametrosSQLIniciar := pValor;
end;

procedure TUniSSUserControls.SetSQLFinalizarSessao(const pValor: TStringList);
begin
  FSQLFinalizarSessao := pValor;
end;

procedure TUniSSUserControls.SetSQLIniciarSessao(const pValor: TStringList);
begin
  FSQLIniciarSessao := pValor;
end;

procedure TUniSSUserControls.SetTipoConector(const pValor: TTipoConector);
begin
  FTipoConector := pValor;
end;

procedure TUniSSUserControls.SetTipoControle(const pValor: TTipoControle);
begin
  FTipoControle := pValor;
end;

end.
