unit Login;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIRegClasses, uniGUIForm, uniGUIBaseClasses, uniButton, uniCheckBox, uniEdit, uniBitBtn, UniFSButton, uniMultiItem, uniComboBox,
  UniFSCombobox, uniImage, uniPageControl, uniLabel, uniPanel;

type
  TLoginFr = class(TUniLoginForm)
    pnlLogin: TUniPanel;
    edtLogin: TUniEdit;
    edtSenha: TUniEdit;
    btnEntrar: TUniButton;
    procedure btnEntrarClick(Sender: TObject);
    procedure UniLoginFormScreenResize(Sender: TObject; AWidth, AHeight: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function LoginFr: TLoginFr;

implementation

{$R *.dfm}

uses
  uniGUIVars, MainModule, uniGUIApplication;

function LoginFr: TLoginFr;
begin
  Result := TLoginFr(UniMainModule.GetFormInstance(TLoginFr));
end;

procedure TLoginFr.btnEntrarClick(Sender: TObject);
begin
  if UniMainModule.Logar(edtLogin.Text, edtSenha.Text) then
  begin
    ModalResult := mrOk;
  end else
  begin
    ShowMessage('Usuário ou senha errado!');
  end;
end;

procedure TLoginFr.UniLoginFormScreenResize(Sender: TObject; AWidth, AHeight: Integer);
begin
  pnlLogin.Top := (AHeight div 2) - (pnlLogin.Height div 2);
  pnlLogin.Left := (AWidth div 2) - (pnlLogin.Width div 2);
end;

initialization
  RegisterAppFormClass(TLoginFr);

end.
