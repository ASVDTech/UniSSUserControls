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
  TMainForm = class(TUniForm)
    UniSSUserControls1: TUniSSUserControls;
    UniButton1: TUniButton;
    procedure UniFormCreate(Sender: TObject);
    procedure UniFormAjaxEvent(Sender: TComponent; EventName: string; Params: TUniStrings);
  private
    { Private declarations }
    procedure CarregarConfiguracoes;
    procedure CarregarParametros;
  public
    { Public declarations }
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

procedure TMainForm.CarregarConfiguracoes;
begin
  UniSSUserControls1.Connection := nil; // Coloque aqui o seu connection
  UniSSUserControls1.SQLIniciarSessao.Add('insert into sua_tabela');
  UniSSUserControls1.SQLFinalizarSessao.Add('update sua_tabela');
  CarregarParametros;
end;

procedure TMainForm.CarregarParametros;
begin
  UniSSUserControls1.ParametrosSQLIniciar.Add('campo1');
  UniSSUserControls1.ParametrosSQLIniciar.Add('campo2');

  UniSSUserControls1.ParametrosSQLFinalizar.Add('campo1');
  UniSSUserControls1.ParametrosSQLFinalizar.Add('campo1');
end;

procedure TMainForm.UniFormAjaxEvent(Sender: TComponent; EventName: string; Params: TUniStrings);
begin
  if SameText(EventName, 'SessionClosed') then
  begin
    UniSSUserControls1.FinalizarSessao;
  end;
end;

procedure TMainForm.UniFormCreate(Sender: TObject);
begin
//  UniSSUserControls1.CarregarControleFimSessao(Self);
end;

initialization
  RegisterAppFormClass(TMainForm);

end.
