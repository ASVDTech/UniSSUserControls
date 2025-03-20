object LoginFr: TLoginFr
  Left = 0
  Top = 0
  ClientHeight = 674
  ClientWidth = 826
  Caption = 'Login'
  BorderStyle = bsNone
  WindowState = wsMaximized
  OldCreateOrder = False
  MonitoredKeys.Keys = <>
  OnScreenResize = UniLoginFormScreenResize
  TextHeight = 15
  object pnlLogin: TUniPanel
    Left = 224
    Top = 184
    Width = 401
    Height = 289
    Hint = ''
    TabOrder = 0
    Caption = ''
    object edtLogin: TUniEdit
      Left = 80
      Top = 88
      Width = 217
      Hint = ''
      Text = ''
      TabOrder = 1
      FieldLabel = 'Login'
      FieldLabelAlign = laTop
      FieldLabelSeparator = ' '
    end
    object edtSenha: TUniEdit
      Left = 80
      Top = 144
      Width = 217
      Hint = ''
      PasswordChar = '*'
      Text = ''
      TabOrder = 2
      FieldLabel = 'Senha'
      FieldLabelAlign = laTop
      FieldLabelSeparator = ' '
    end
    object btnEntrar: TUniButton
      Left = 152
      Top = 200
      Width = 75
      Height = 25
      Hint = ''
      Caption = 'Entrar'
      TabOrder = 3
      OnClick = btnEntrarClick
    end
  end
end
