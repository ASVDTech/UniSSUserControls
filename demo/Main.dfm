object MainForm: TMainForm
  Left = 0
  Top = 0
  ClientHeight = 553
  ClientWidth = 782
  Caption = 'MainForm'
  OldCreateOrder = False
  MonitoredKeys.Keys = <>
  ClientEvents.ExtEvents.Strings = (
    
      'window.beforerender=function window.beforerender(sender, eOpts)'#13 +
      #10'{'#13#10'   window.onunload = function() {'#13#10'         ajaxRequest(send' +
      'er, '#39'SessionClosed'#39', [] );'#13#10'  };'#13#10'}'
    
      'form.beforerender=function form.beforerender(sender, eOpts)'#13#10'{'#13#10 +
      '     window.onbeforeunload = function() {'#13#10'         ajaxRequest(' +
      'sender, '#39'SessionClosed'#39', [] );'#13#10'  };'#13#10'}')
  OnAjaxEvent = UniFormAjaxEvent
  OnCreate = UniFormCreate
  TextHeight = 15
  object UniButton1: TUniButton
    Left = 360
    Top = 288
    Width = 75
    Height = 25
    Hint = ''
    Caption = 'UniButton1'
    TabOrder = 0
  end
  object UniSSUserControls1: TUniSSUserControls
    TipoControle = Memoria
    TipoConector = FireDAC
    Left = 272
    Top = 184
  end
end
