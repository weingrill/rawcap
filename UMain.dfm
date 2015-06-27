object FMain: TFMain
  Left = 196
  Top = 103
  Width = 648
  Height = 586
  Caption = 'RAWCap'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Icon.Data = {
    0000010001002020100000000000E80200001600000028000000200000004000
    0000010004000000000080020000000000000000000000000000000000000000
    000000008000008000000080800080000000800080008080000080808000C0C0
    C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000FFF8880000000000000000000000000FFFF8888000000000
    000000000000000FFFF888800000000000000000000000FFFFFF888800000000
    0000000000000FFFFFFF8888800000000000000000000FFFFFFF888880000000
    0000000000000FFFFFFF888880000000000000000000FFFFFFFFF88888000000
    000000000000FFFFFFFFF8888800000000000000000FFFFFFFFFF88888800000
    00000000000FFFFFFFFFF8888880000000000000000FFFFFFFFFF88888800000
    00000000000FFFFFBBBB33888880000000000000000FFFFBBBB3333888800000
    00000000000FFFFBBB0033388880000000000000000FFFFBB00003388880AAAA
    AAACCCCCCC0FFFFBB00003388880AAAAAAACCCCCCC0FFFFBBB0033388880AAAA
    AAACCCCCCC0FFFFBBBB333388880AAAAAAACCCCCCC00FFFFBBBB33888800AAAA
    AAACCCCCCC00FFFFFFFF88888800AAAAAAACCCCCCC000FFFFFFF88888000AAAA
    AAACCCCCCC0000FFFFF8888800009999999AAAAAAA000000FFF8880000009999
    999AAAAAAA0000000000000000009999999AAAAAAA0000000000000000009999
    999AAAAAAA0000000000000000009999999AAAAAAA0000000000000000009999
    999AAAAAAA0000000000000000009999999AAAAAAA000000000000000000FFFF
    FFFFFFFFFFFFFFFFF03FFFFFE01FFFFFE01FFFFFC00FFFFF8007FFFF8007FFFF
    8007FFFF0003FFFF0003FFFE0001FFFE0001FFFE0001FFFE0001FFFE0001FFFE
    0001FFFE00010002000100020001000200010003000300030003000380070003
    C00F0003F03F0003FFFF0003FFFF0003FFFF0003FFFF0003FFFF0003FFFF}
  Menu = MainMenu1
  OldCreateOrder = False
  ShowHint = True
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 0
    Top = 41
    Width = 640
    Height = 480
    Align = alClient
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 640
    Height = 41
    Align = alTop
    TabOrder = 0
    object SBSettings: TSpeedButton
      Left = 8
      Top = 8
      Width = 23
      Height = 22
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        04000000000080000000130B0000130B00001000000010000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFF88808888888FCCFFFFF0FFFFFFF
        FCCFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFF88888888088FAAFFFFFFFFFF0FF
        FAAFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFF88088888888F99FFFF0FFFFFFFF
        F99FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      OnClick = SBSettingsClick
    end
    object SpeedButton1: TSpeedButton
      Left = 36
      Top = 8
      Width = 23
      Height = 22
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        04000000000080000000130B0000130B00001000000010000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000000
        000FF0FFFFFFFFFFFF0FF0FFFFFFFFFFFF0FF0000000000FFF0FF0FFFFFFFF0F
        FF0FF0FFFFFFFF0FFF0FF00000FFFF0FFF0FF0FFF0FFFF0FFF0FF0FFF0FFFF0F
        FF0FF00000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      OnClick = SpeedButton1Click
    end
    object SBRecord: TSpeedButton
      Left = 344
      Top = 8
      Width = 23
      Height = 22
      Hint = 'Capture'
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        04000000000080000000130B0000130B00001000000010000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFF99999FFFFFFFFF199999991FFFFFF1999999999
        1FFFFF99999999999FFFF9999999999999FFF9999999999999FFF99999999999
        99FFF9999999999999FFF9999999999999FFFF99999999999FFFFF1999999999
        1FFFFFF199999991FFFFFFFFF99999FFFFFFFFFFFFFFFFFFFFFF}
      OnClick = SBRecordClick
    end
    object FEFiles: TFilenameEdit
      Left = 64
      Top = 8
      Width = 265
      Height = 21
      DefaultExt = 'bmp'
      Filter = 'Bitmaps|*.bmp|JPEG|*.jpg;*.jpeg|all files (*.*)|*.*'
      FilterIndex = 0
      NumGlyphs = 1
      TabOrder = 0
      Text = 'c:\CAP.bmp'
      OnChange = FEFilesChange
    end
    object SPCount: TRxSpinEdit
      Left = 384
      Top = 8
      Width = 73
      Height = 21
      TabOrder = 1
    end
    object CBWB: TCheckBox
      Left = 472
      Top = 12
      Width = 97
      Height = 17
      Caption = 'White Balance'
      TabOrder = 2
    end
  end
  object SBInfo: TStatusBar
    Left = 0
    Top = 521
    Width = 640
    Height = 19
    Panels = <>
    SimplePanel = True
  end
  object MainMenu1: TMainMenu
    Left = 8
    Top = 48
    object MIProgram: TMenuItem
      Caption = 'Program'
      object MIClose: TMenuItem
        Caption = 'Close'
        OnClick = MICloseClick
      end
    end
    object MIOptions: TMenuItem
      Caption = 'Options'
      object MIlowgain: TMenuItem
        Caption = 'low gain'
        Checked = True
        GroupIndex = 1
        RadioItem = True
        OnClick = MIlowgainClick
      end
      object MImedgain: TMenuItem
        Caption = 'med gain'
        GroupIndex = 1
        RadioItem = True
        OnClick = MImedgainClick
      end
      object MIhighgain: TMenuItem
        Caption = 'high gain'
        GroupIndex = 1
        RadioItem = True
        OnClick = MIhighgainClick
      end
      object N1: TMenuItem
        Caption = '-'
        GroupIndex = 1
      end
      object MIColor: TMenuItem
        Caption = 'color mode'
        Checked = True
        GroupIndex = 2
        RadioItem = True
        OnClick = MIColorClick
      end
      object MIMono: TMenuItem
        Caption = 'mono mode'
        GroupIndex = 2
        RadioItem = True
        OnClick = MIMonoClick
      end
      object MIraw: TMenuItem
        Caption = 'raw mode'
        GroupIndex = 2
        RadioItem = True
        OnClick = MIrawClick
      end
      object N2: TMenuItem
        Caption = '-'
        GroupIndex = 3
      end
      object MItimestamp: TMenuItem
        Caption = 'insert timestamp'
        GroupIndex = 3
        OnClick = MItimestampClick
      end
      object MIremark: TMenuItem
        Caption = 'insert remark'
        GroupIndex = 3
        OnClick = MIremarkClick
      end
    end
  end
  object FPMain: TFormPlacement
    IniFileName = 'Software\Weingrill\RAWCap'
    IniSection = 'MainFrom'
    UseRegistry = True
    Left = 40
    Top = 48
  end
end
