object UniMainModule: TUniMainModule
  OnCreate = UniGUIMainModuleCreate
  OnDestroy = UniGUIMainModuleDestroy
  MonitoredKeys.Keys = <>
  OnBrowserClose = UniGUIMainModuleBrowserClose
  Height = 750
  Width = 1000
  PixelsPerInch = 120
  object Connection: TFDConnection
    Left = 88
    Top = 56
  end
  object qryUsuario: TFDQuery
    Connection = Connection
    SQL.Strings = (
      'SELECT id_usuario,'
      '       login,'
      '       senha'
      '  FROM usuarios'
      'where lower(login) = lower(:login)'
      '  and lower(senha) = lower(:senha)')
    Left = 240
    Top = 48
    ParamData = <
      item
        Name = 'LOGIN'
        ParamType = ptInput
      end
      item
        Name = 'SENHA'
        ParamType = ptInput
      end>
  end
  object UniSSUserControls1: TUniSSUserControls
    TipoControle = BancoDados
    TipoConector = FireDAC
    Left = 400
    Top = 56
  end
end
