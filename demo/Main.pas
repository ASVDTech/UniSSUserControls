unit Main;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  uniGUITypes,
  uniGUIAbstractClasses,
  uniGUIClasses,
  uniGUIRegClasses,
  uniGUIForm,
  uniGUIBaseClasses,
  uniButton,
  UniSSUserControls.TUniSSUserControls;

type
  TStatusSessao = (Inativo, Ativo);
  TStatusSessaoHeler = record helper for TStatusSessao
    function ToInteger: UInt8;
  end;
  TMainForm = class(TUniForm)
    btnDeslogar: TUniButton;
    procedure UniFormCreate(Sender: TObject);
    procedure UniFormAjaxEvent(Sender: TComponent; EventName: string; Params: TUniStrings);
    procedure UniFormShow(Sender: TObject);
    procedure btnDeslogarClick(Sender: TObject);
  private
    { Private declarations }
    procedure CarregarConfiguracoes;
    procedure CarregarParametrosEntrada;
    procedure CarregarParametrosSaida;
  public
    { Public declarations }
    procedure FinalizarSessao;
  end;

function MainForm: TMainForm;

implementation

{$R *.dfm}

uses
  uniGUIVars,
  MainModule,
  uniGUIApplication;

function MainForm: TMainForm;
begin
  Result := TMainForm(UniMainModule.GetFormInstance(TMainForm));
end;

procedure TMainForm.btnDeslogarClick(Sender: TObject);
begin
  FinalizarSessao;
  UniApplication.Restart;
end;

procedure TMainForm.CarregarConfiguracoes;
begin
  UniMainModule.UniSSUserControls1.Connection := UniMainModule.Connection; // Coloque aqui o seu connection
  UniMainModule.UniSSUserControls1.SQLIniciarSessao.Text := 'INSERT INTO sessoes (id_usuario, sessionID, dataEntrada, status ) ' +
    'VALUES ( :id_usuario, :sessionID, :dataEntrada, :status )';
  UniMainModule.UniSSUserControls1.SQLFinalizarSessao.Text := 'update sessoes set dataSaida = :dataSaida, status = :status where id_usuario = :id_usuario';
  CarregarParametrosEntrada;
end;

procedure TMainForm.CarregarParametrosEntrada;
begin
  UniMainModule.UniSSUserControls1.ParametrosSQLIniciar.Clear;
  UniMainModule.UniSSUserControls1.ParametrosSQLIniciar.Add(UniMainModule.IDUsuario.ToString);
  UniMainModule.UniSSUserControls1.ParametrosSQLIniciar.Add(UniSession.SessionId);
  UniMainModule.UniSSUserControls1.ParametrosSQLIniciar.Add(FormatDateTime('dd/mm/yyyy hh:nn:ss', Now));
  UniMainModule.UniSSUserControls1.ParametrosSQLIniciar.Add(TStatusSessao.Ativo.ToInteger.ToString);
end;

procedure TMainForm.CarregarParametrosSaida;
begin
  UniMainModule.UniSSUserControls1.ParametrosSQLFinalizar.Clear;
  UniMainModule.UniSSUserControls1.ParametrosSQLFinalizar.Add(FormatDateTime('dd/mm/yyyy hh:nn:ss', Now));
  UniMainModule.UniSSUserControls1.ParametrosSQLFinalizar.Add(TStatusSessao.Inativo.ToInteger.ToString);
  UniMainModule.UniSSUserControls1.ParametrosSQLFinalizar.Add(UniMainModule.IDUsuario.ToString);
end;

procedure TMainForm.FinalizarSessao;
begin
  CarregarParametrosSaida;
  UniMainModule.UniSSUserControls1.FinalizarSessao;
end;

procedure TMainForm.UniFormAjaxEvent(Sender: TComponent; EventName: string; Params: TUniStrings);
begin
  if SameText(EventName, 'SessionClosed') then
  begin
    FinalizarSessao;
    UniSession.Terminate;
  end;
end;

procedure TMainForm.UniFormCreate(Sender: TObject);
begin
  UniMainModule.UniSSUserControls1.CarregarControleFimSessao(UniSession);
  CarregarConfiguracoes;
end;

procedure TMainForm.UniFormShow(Sender: TObject);
begin
  UniMainModule.UniSSUserControls1.IniciarSessao;
end;

{ TStatusSessaoHeler }

function TStatusSessaoHeler.ToInteger: UInt8;
begin
  Result := UInt8(Self);
end;

initialization
  RegisterAppFormClass(TMainForm);

end.
