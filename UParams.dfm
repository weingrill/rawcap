object FParams: TFParams
  Left = 302
  Top = 580
  BorderStyle = bsToolWindow
  Caption = 'Params'
  ClientHeight = 92
  ClientWidth = 142
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object SEkr: TRxSpinEdit
    Left = 8
    Top = 8
    Width = 57
    Height = 21
    Increment = 0.01
    ValueType = vtFloat
    Value = 1
    TabOrder = 0
    OnChange = SEkrChange
  end
  object SEkg: TRxSpinEdit
    Left = 8
    Top = 36
    Width = 57
    Height = 21
    Increment = 0.01
    ValueType = vtFloat
    Value = 1
    TabOrder = 1
    OnChange = SEkrChange
  end
  object SEkb: TRxSpinEdit
    Left = 8
    Top = 64
    Width = 57
    Height = 21
    Increment = 0.01
    ValueType = vtFloat
    Value = 1
    TabOrder = 2
    OnChange = SEkrChange
  end
  object SEdr: TRxSpinEdit
    Left = 76
    Top = 8
    Width = 57
    Height = 21
    TabOrder = 3
    OnChange = SEkrChange
  end
  object SEdg: TRxSpinEdit
    Left = 76
    Top = 36
    Width = 57
    Height = 21
    TabOrder = 4
    OnChange = SEkrChange
  end
  object SEdb: TRxSpinEdit
    Left = 76
    Top = 64
    Width = 57
    Height = 21
    TabOrder = 5
    OnChange = SEkrChange
  end
end
