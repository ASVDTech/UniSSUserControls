object MainForm: TMainForm
  Left = 0
  Top = 0
  ClientHeight = 606
  ClientWidth = 979
  Caption = 'MainForm'
  OnShow = UniFormShow
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
  object btnDeslogar: TUniButton
    Left = 584
    Top = 56
    Width = 75
    Height = 25
    Hint = ''
    Caption = 'Deslogar'
    TabOrder = 0
    OnClick = btnDeslogarClick
  end
end
